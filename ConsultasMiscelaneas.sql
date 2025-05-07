/*
SELECT 
    s.Name AS esquema,
    t.NAME AS tabla,
    p.rows AS registros,
    CASE 
        WHEN p.rows = 0 THEN 'Vacía'
        ELSE 'Con datos'
    END AS estado
FROM 
    sys.tables t
INNER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN  
    sys.partitions p ON t.object_id = p.object_id
WHERE 
    p.index_id IN (0, 1) -- 0 tabla heap, 1 clustered index
ORDER BY 
    p.rows DESC;

*/




-- Query #1

-- Crear vista dinamica --

CREATE VIEW dbo.vistaDinamicaPlanesPopularesMontosPorUsuario
WITH SCHEMABINDING AS
(
SELECT
    p.planId AS PlanId,
    p.name AS NombrePlan,
    COUNT_BIG(*) AS TotalUsuarios,
    AVG(pp.amount) AS MontoPromedio,
    SUM(pp.amount) AS MontoTotal,
    STRING_AGG(CONCAT(pe.firstName, ' ', pe.lastName), ', ') WITHIN GROUP (ORDER BY pe.lastName) AS ListaUsuarios
FROM dbo.caipi_plans p
INNER JOIN dbo.caipi_planPerUser ppu ON p.planId = ppu.planId AND ppu.enabled = 1
INNER JOIN dbo.caipi_planPrices pp ON p.planId = pp.planId AND pp.[current] = 1
INNER JOIN dbo.caipi_Users u ON ppu.userId = u.userId
INNER JOIN dbo.caipi_Personas pe ON u.personId = pe.personId
GROUP BY p.planId, p.name
)

-- Demostrar que es dinamico -- 

-- 1. Consulta inicial
SELECT * FROM vistaDinamicaPlanesPopularesMontosPorUsuario
ORDER BY TotalUsuarios DESC;

-- 2. Insertar datos de prueba
INSERT INTO dbo.caipi_Personas (firstName, lastName, birthdate)
VALUES ('Maria', 'Gomez', '1985-05-15');

DECLARE @newPersonId INT = SCOPE_IDENTITY();

INSERT INTO dbo.caipi_Users (password, enabled, personId)
VALUES (0x010203, 1, @newPersonId);

DECLARE @newUserId INT = SCOPE_IDENTITY();


INSERT INTO dbo.caipi_planPerUser (adquisitionDate, expirationDate, enabled, planId, userId)
VALUES (GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1, 1, @newUserId);

-- 3. Verificar que la vista se actualiza automáticamente
SELECT * FROM vistaDinamicaPlanesPopularesMontosPorUsuario
WHERE PlanId = 1;


-- Query #2

CREATE PROCEDURE [dbo].[CaipiSP_RenovarPlanUsuario]
	@PlanPerUserId INT,
    @NuevoPlanId INT = NULL,
    @MetodoPagoId INT,
    @UsuarioEjecucion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT;
    DECLARE @ErrorMessage VARCHAR(200);
    DECLARE @IniciaTransaccion BIT = 0;
    DECLARE @Monto DECIMAL(16,2);
    DECLARE @UserId INT;
    DECLARE @PlanActualId INT;
    DECLARE @FechaExpiracionActual DATE;
    DECLARE @NuevaFechaExpiracion DATE;
	DECLARE @ProximoLogId INT;

    -- Obtener datos actuales
    SELECT 
        @UserId = userId,
        @PlanActualId = planId,
        @FechaExpiracionActual = expirationDate
    FROM dbo.caipi_planPerUser
    WHERE planPerUserId = @PlanPerUserId;
    
    -- Validaciones iniciales
    IF @UserId IS NULL
    BEGIN
        RAISERROR('Suscripción no encontrada', 16, 1);
        RETURN -1;
    END
    
    -- Determinar nuevo plan y si no se especifica, renovar el mismo
    SET @NuevoPlanId = COALESCE(@NuevoPlanId, @PlanActualId);
    
   
    SELECT @Monto = amount
    FROM dbo.caipi_planPrices
    WHERE planId = @NuevoPlanId AND [current] = 1;
    
    IF @Monto IS NULL
    BEGIN
        RAISERROR('No se encontró precio vigente para el plan', 16, 1);
        RETURN -2;
    END
    
    -- Calcular nueva fecha de expiración (1 mes después de la actual o hoy si ya expiró)
    SET @NuevaFechaExpiracion = DATEADD(
        MONTH, 
        1, 
        CASE WHEN @FechaExpiracionActual > GETDATE() 
             THEN @FechaExpiracionActual 
             ELSE GETDATE() END
    );
    
    
    IF @@TRANCOUNT = 0 
    BEGIN
        SET @IniciaTransaccion = 1;
        BEGIN TRANSACTION;
    END
    
    BEGIN TRY
        -- 1. Actualizar suscripción existente (marcar como no activa)
        UPDATE dbo.caipi_planPerUser
        SET enabled = 0,
            expirationDate = GETDATE()
        WHERE planPerUserId = @PlanPerUserId;
        
        -- 2. Crear nueva suscripción
        INSERT INTO dbo.caipi_planPerUser (
            adquisitionDate, expirationDate, enabled, planId, userId
        )
        VALUES (
            GETDATE(), @NuevaFechaExpiracion, 1, @NuevoPlanId, @UserId
        );
        
        DECLARE @NuevoPlanPerUserId INT = SCOPE_IDENTITY();
        
        -- 3. Registrar el pago

		
		DECLARE @ProximoPagoId INT;
		SELECT @ProximoPagoId = COALESCE(MAX(pagoId), 0) + 1 FROM dbo.caipi_Pagos;
		

		INSERT INTO dbo.caipi_Pagos (
			pagoId, pagoMedioId, metodoPagoId, personId, monto, actualMonto,
			result, auth, chargeToken, error, fecha, checksum,
			exchangeRate, convertedAmount, moduleId, currencyId, scheduleId
		)
		SELECT
			@ProximoPagoId, @MetodoPagoId, 1,
			(SELECT personId FROM dbo.caipi_Users WHERE userId = @UserId),
			@Monto, @Monto, 0x00, 0x00, 0x00, NULL, GETDATE(), 0x00, 1.0, @Monto, 1, 1, 1;
        
        DECLARE @PagoId INT = @ProximoPagoId;


         -- 4. Registrar distribución del pago
		DECLARE @ProximoDistributionId INT;
		SELECT @ProximoDistributionId = COALESCE(MAX(distributionId), 0) + 1 FROM dbo.caipi_distribution;
       
        INSERT INTO dbo.caipi_distribution (
            distributionId, enabled, checksum, subTypeId, pagoId
        )
        VALUES (
            @ProximoDistributionId, 1, 0x00, 1, @PagoId
        );
        
        -- 5. Registrar en log
		SELECT @ProximoLogId = COALESCE(MAX(logId), 0) + 1 FROM dbo.caipi_Log;

        INSERT INTO dbo.caipi_Log (
            logId, description, postTime, computer, username, trace,
            reference1, reference2, value1, value2, checksum
        )
        VALUES (
            @ProximoLogId, 'Renovación de plan automática', GETDATE(), HOST_NAME(), @UsuarioEjecucion,
            'Usuario: ' + CAST(@UserId AS VARCHAR) + ' - Plan anterior: ' + CAST(@PlanActualId AS VARCHAR) + ' - Nuevo plan: ' + CAST(@NuevoPlanId AS VARCHAR),
            @NuevoPlanPerUserId, @PagoId, @PlanActualId, @NuevoPlanId, 0x00
        );
        
        
        IF @IniciaTransaccion = 1
            COMMIT TRANSACTION;
        
        -- Retornar ID de la nueva suscripción
        SELECT @NuevoPlanPerUserId AS NuevoPlanPerUserId;
        
        RETURN 0;
    END TRY
    BEGIN CATCH
        SET @ErrorNumber = ERROR_NUMBER();
        SET @ErrorSeverity = ERROR_SEVERITY();
        SET @ErrorState = ERROR_STATE();
        SET @ErrorMessage = ERROR_MESSAGE();
        
        -- Revertir transacción
        IF @IniciaTransaccion = 1 AND @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Registrar error
		SELECT @ProximoLogId = COALESCE(MAX(logId), 0) + 1 FROM dbo.caipi_Log;

        INSERT INTO dbo.caipi_Log (
            logId, description, postTime, computer, username, trace,
            reference1, reference2, value1, value2, checksum
        )
        VALUES (
            @ProximoLogId, 'Error en renovación de plan', GETDATE(), HOST_NAME(), @UsuarioEjecucion, @ErrorMessage,
            @PlanPerUserId, @NuevoPlanId, @UserId, NULL, 0x00
        );
        
        RAISERROR('Error renovando plan: %s', @ErrorSeverity, @ErrorState, @ErrorMessage);
        RETURN -99;
    END CATCH;
END;
GO

-- Pruebas del SP

-- 1. Renovación normal (mismo plan)
EXEC [dbo].[CaipiSP_RenovarPlanUsuario] 
    @PlanPerUserId = 9,
    @MetodoPagoId = 3,
    @UsuarioEjecucion = 'cron_renovaciones';


-- 2. Cambio de plan durante renovación
EXEC [dbo].[CaipiSP_RenovarPlanUsuario] 
    @PlanPerUserId = 6,
    @NuevoPlanId = 1,  
    @MetodoPagoId = 1, 
    @UsuarioEjecucion = 'cliente_web';

select * from dbo.caipi_planPerUser
select * from dbo.caipi_Pagos
select * from dbo.caipi_subTypes


-- Query #3 -- Seleccionar y clasificar a los usuarios en base al tiempo que ha pasado desde que adquirieron un plan y cuenta cuantos planes activos han tenido	
SELECT 
    u.userId,
    pe.firstName + ' ' + pe.lastName AS NombreCompleto,
    DATEDIFF(MONTH, ppu.adquisitionDate, GETDATE()) AS MesesActivo,
    CASE 
		WHEN ppu.adquisitionDate IS NULL THEN 'N/A'
        WHEN DATEDIFF(MONTH, ppu.adquisitionDate, GETDATE()) < 3 THEN 'Nuevo (0-3 meses)'
        WHEN DATEDIFF(MONTH, ppu.adquisitionDate, GETDATE()) BETWEEN 3 AND 6 THEN 'Regular (3-6 meses)'
        WHEN DATEDIFF(MONTH, ppu.adquisitionDate, GETDATE()) BETWEEN 6 AND 12 THEN 'Antiguo (6-12 meses)'
        ELSE 'VIP (+1 año)'
    END AS SegmentoAntiguedad,
    COUNT(ppu.planPerUserId) AS CantidadPlanesAdquiridos
FROM 
    dbo.caipi_Users u
INNER JOIN 
    dbo.caipi_Personas pe ON u.personId = pe.personId
LEFT JOIN 
    dbo.caipi_planPerUser ppu ON u.userId = ppu.userId AND ppu.enabled = 1
GROUP BY 
    u.userId, 
    pe.firstName, 
    pe.lastName, 
    ppu.adquisitionDate
ORDER BY 
    MesesActivo DESC;

select * from caipi_planPerUser


-- Query #4

-- Query para crear la funcion escalar

CREATE OR ALTER FUNCTION dbo.FormatoMoneda  
(
    @Monto DECIMAL(16,2),
    @CurrencyId INT = NULL  -- Valor por defecto NULL
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @SimboloMoneda CHAR(1) = '$';  -- Valor por defecto
    DECLARE @MontoFormateado VARCHAR(50);
    
    -- Si @CurrencyId no es NULL, busca el símbolo
    IF @CurrencyId IS NOT NULL
    BEGIN
        SELECT @SimboloMoneda = COALESCE(c.symbol, '$')
        FROM dbo.caipi_Currencies c
        WHERE c.currencyid = @CurrencyId;
    END
    
    SET @MontoFormateado = @SimboloMoneda + ' ' + FORMAT(COALESCE(@Monto, 0), 'N2');
    
    RETURN @MontoFormateado;
END

-- Query Principal
 -- Reporte detallado por institución sobre el uso, beneficios, pagos y planes asociados
WITH BeneficiosActivos AS (
    SELECT 
        pdb.partnerDealBenefitsId,
        pdb.partnerDealId,
        pdb.dealBenefitTypesid,
        pdb.[limit],
        pdb.planId,
        pdb.userId
    FROM caipi_partnerDealBenefits pdb
    WHERE pdb.starDate <= GETDATE() 
    AND (pdb.endDate IS NULL OR pdb.endDate >= GETDATE())
),
PlanesConPrecios AS (
    SELECT 
        pp.planId,
        pp.amount,
		(SELECT TOP 1 c.currencyId
         FROM caipi_plans pl
         JOIN caipi_partnerDealBenefits pdb ON pl.planId = pdb.planId
         JOIN caipi_PartnerDeals pd ON pdb.partnerDealId = pd.partnerDealId
         JOIN caipi_Instituciones i ON pd.institucioneId = i.institucioneId
         JOIN caipi_adresses a ON i.adressId = a.adressId
         JOIN caipi_Cities ci ON a.cityId = ci.cityId
         JOIN caipi_States s ON ci.stateId = s.stateId
         JOIN caipi_Countries c ON s.countryId = c.countryId
         WHERE pl.planId = pp.planId) AS currencyId
    FROM caipi_planPrices pp
    WHERE pp.[current] = 1
),
UsuariosPorInstitucion AS (
    SELECT 
        pd.institucioneId,
        COUNT(DISTINCT u.userId) AS TotalUsuarios
    FROM caipi_PartnerDeals pd
    JOIN caipi_partnerDealBenefits pdb ON pd.partnerDealId = pdb.partnerDealId
    JOIN caipi_Users u ON pdb.userId = u.userId
    WHERE u.enabled = 1
    GROUP BY pd.institucioneId
),
PagosPorInstitucion AS (
    SELECT 
        i.institucioneId,
        SUM(p.monto) AS TotalPagado,
        p.currencyId
    FROM caipi_Instituciones i
    JOIN caipi_PartnerDeals pd ON i.institucioneId = pd.institucioneId
    JOIN caipi_Pagos p ON pd.partnerDealId = p.moduleId
    GROUP BY i.institucioneId, p.currencyId
)

SELECT 
    i.nombre AS Institucion,
    p.name AS NombrePlan,
    dbo.FormatoMoneda(AVG(pp.amount), pp.currencyId) AS PrecioPromedio,
    COUNT(ba.partnerDealBenefitsId) AS TotalBeneficios,
    AVG(ba.[limit]) AS PromedioLimite,
    CONVERT(VARCHAR, MAX(pd.sealDate), 106) AS FechaAcuerdo,
    CASE 
        WHEN upi.TotalUsuarios > 5 THEN 'Alto uso'
        WHEN upi.TotalUsuarios > 0 THEN 'Uso moderado'
        ELSE 'Sin usuarios'
    END AS NivelUso,
    dbo.FormatoMoneda(ppi.TotalPagado, ppi.currencyId) AS TotalPagado,
    (SELECT COUNT(*) FROM caipi_Pagos pg 
     WHERE pg.moduleId IN (SELECT moduleId FROM caipi_Modules WHERE name LIKE '%Beneficio%')) AS PagosBeneficios,
    (SELECT STRING_AGG(CONVERT(VARCHAR, pdb2.userId), ', ') 
     FROM caipi_partnerDealBenefits pdb2 
     WHERE pdb2.partnerDealId = pd.partnerDealId) AS UsuariosAsociados
FROM 
    caipi_Instituciones i
INNER JOIN 
    caipi_PartnerDeals pd ON i.institucioneId = pd.institucioneId AND pd.isActive = 1
INNER JOIN 
    BeneficiosActivos ba ON pd.partnerDealId = ba.partnerDealId
INNER JOIN 
    caipi_plans p ON ba.planId = p.planId AND p.enabled = 1
INNER JOIN 
    PlanesConPrecios pp ON p.planId = pp.planId
LEFT JOIN 
    UsuariosPorInstitucion upi ON i.institucioneId = upi.institucioneId
LEFT JOIN 
    PagosPorInstitucion ppi ON i.institucioneId = ppi.institucioneId
WHERE 
    p.planId IN (SELECT planId FROM caipi_planPrices WHERE [current] = 1)
GROUP BY 
    i.nombre, 
    p.name,
	pp.currencyId,
    upi.TotalUsuarios,
    pd.partnerDealId,
    ppi.TotalPagado,
    ppi.currencyId
HAVING 
    COUNT(ba.partnerDealBenefitsId) > 0
ORDER BY 
    upi.TotalUsuarios DESC,
    i.nombre ASC;



-- Eliminar la funcion
DROP FUNCTION IF EXISTS caipiDb.dbo.CaipiFuncion_FormatoMoneda;


-----------------------------------------------------------
-- Descripcion: Actualización de plan de usuario
-- Otros detalles: Cambia plan de usuario, actualiza límites y gestiona planes
-----------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[SP_UserPlan_Update]
    @userId INT,
    @newPlanName VARCHAR(50),
    @newPlanDescription VARCHAR(200),
    @newPlanAmount DECIMAL(10, 2),
    @newLimitPeople TINYINT,
    @newLimitValue INT,
    @success BIT OUTPUT,
    @message NVARCHAR(500) OUTPUT
WITH ENCRYPTION, EXECUTE AS 'dbo'
AS 
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT;
    DECLARE @ErrorMessage VARCHAR(100);
    DECLARE @InicieTransaccion BIT;
    DECLARE @oldPlanId INT, @oldPlanPerUserId INT;

   

    SELECT TOP 1 
        @oldPlanId = [planId],
        @oldPlanPerUserId = [planPerUserId]
    FROM [dbo].[caipi_planPerUser]
    WHERE [userId] = @userId AND [enabled] = 1
    ORDER BY [adquisitionDate] DESC;
    
    SET @InicieTransaccion = 0;
    IF @@TRANCOUNT = 0 BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;     
    END;
    
    BEGIN TRY
        SET @CustomError = 2003;

        -- Verificar si el usuario tiene un plan activo
        IF @oldPlanId IS NULL
            RAISERROR('El usuario no tiene un plan activo', 16, 1);
        
        -- Deshabilitar el planPerUser actual
        UPDATE [dbo].[caipi_planPerUser]
        SET [enabled] = 0
        WHERE [planPerUserId] = @oldPlanPerUserId;
        
        -- Verificar si se deshabilitó el plan
        IF @@ROWCOUNT = 0
            RAISERROR('No se pudo deshabilitar el plan actual del usuario', 16, 1);
        
        -- Llamar al SP 2 para manejar la creación del nuevo plan
        DECLARE @planSuccess BIT;
        DECLARE @newPlanId INT;
        
        EXEC dbo.SP_Plan_Management 
            @userId = @userId,
            @newPlanName = @newPlanName,
            @newPlanDescription = @newPlanDescription,
            @newPlanAmount = @newPlanAmount,
            @oldPlanId = @oldPlanId,
            @success = @planSuccess OUTPUT,
            @newPlanId = @newPlanId OUTPUT;
            
        IF @planSuccess = 0 OR @newPlanId IS NULL
            RAISERROR('Error en la creación del nuevo plan', 16, 1);
        
        -- Crear nuevo planPerUser para el usuario
        DECLARE @newPlanPerUserId INT;
        
        INSERT INTO [dbo].[caipi_planPerUser] (
            [adquisitionDate],
            [expirationDate],
            [enabled],
            [planId],
            [userId]
        )
        VALUES (
            GETDATE(),
            DATEADD(YEAR, 1, GETDATE()),
            1,
            @newPlanId,
            @userId
        );
        
        SET @newPlanPerUserId = SCOPE_IDENTITY();
        
        -- Actualizar el límite del plan anterior al nuevo en PlanLimits
        UPDATE [dbo].[caipi_PlanLimits]
        SET 
            [limit_people] = @newLimitPeople,
            [limit] = @newLimitValue,
            [planPerUserId] = @newPlanPerUserId
        WHERE [planPerUserId] = @oldPlanPerUserId;
        
        -- Verificar si se actualizó el límite o insertar nuevo
        IF @@ROWCOUNT = 0
        BEGIN
            INSERT INTO [dbo].[caipi_PlanLimits] (
                [planLimitId],
                [limit_people],
                [limit],
                [featureId],
                [planPerUserId],
                [description]
            )
            VALUES (
                (SELECT ISNULL(MAX([planLimitId]), 0) + 1 FROM [dbo].[caipi_PlanLimits]),
                @newLimitPeople,
                @newLimitValue,
                1,
                @newPlanPerUserId,
                'Nuevo límite para el plan actualizado'
            );
        END;
        
        SET @success = 1;
        SET @message = 'Plan actualizado exitosamente';
        
        IF @InicieTransaccion = 1 BEGIN
            COMMIT;
        END;
    END TRY
    BEGIN CATCH
        SET @ErrorNumber = ERROR_NUMBER();
        SET @ErrorSeverity = ERROR_SEVERITY();
        SET @ErrorState = ERROR_STATE();
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @success = 0;
        SET @message = 'Error al actualizar el plan: ' + @ErrorMessage;
        
        IF @InicieTransaccion = 1 BEGIN
            ROLLBACK;
        END;
        
		-- Insertar en caipi_Log (esto disparará el trigger)
		DECLARE @LogId INT
		SELECT @logId = ISNULL(MAX([logId]), 0) + 1 FROM [dbo].[caipi_Log];
        
        INSERT INTO [dbo].[caipi_Log] (
            [logId],
            [description],
            [postTime],
            [computer],
            [username],
            [trace],
            [reference1],
            [reference2],
            [value1],
            [value2],
            [checksum]
        )
        VALUES (
            @logId,
            LEFT('Error en SP_UserPlan_Update: ' + @Message, 100),
            GETDATE(),
            HOST_NAME(),
            SUSER_NAME(),
            'Línea: ' + CAST(ERROR_LINE() AS VARCHAR(10)),
            @ErrorNumber,
            @ErrorSeverity,
            @ErrorState,
            NULL,
            HASHBYTES('SHA2_256', LEFT('Error en SP_UserPlan_Update: ' + @Message, 100))
        );


        
        RAISERROR('Error en actualización de plan de usuario - Código: %i', 
            @ErrorSeverity, @ErrorState, @CustomError);
    END CATCH;
    
    RETURN 0;
END;
GO

-----------------------------------------------------------
-- Descripcion: Manejo de planes y precios
-- Otros detalles: Crea nuevo plan, deshabilita viejo y establece precios
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[SP_Plan_Management]
    @userId INT,
    @newPlanName VARCHAR(50),
    @newPlanDescription VARCHAR(200),
    @newPlanAmount DECIMAL(10, 2),
    @oldPlanId INT,
    @success BIT OUTPUT,
    @newPlanId INT OUTPUT
WITH ENCRYPTION, EXECUTE AS 'dbo'
AS 
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT;
    DECLARE @Message VARCHAR(100);
    DECLARE @InicieTransaccion BIT;
    
    
    DECLARE @oldPlanEnabled BIT;
    SELECT @oldPlanEnabled = [enabled] 
    FROM [dbo].[caipi_plans] 
    WHERE [planId] = @oldPlanId;
    
    SET @InicieTransaccion = 0;
    IF @@TRANCOUNT = 0 BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;     
    END;
    
    BEGIN TRY
        SET @CustomError = 2002;

        -- Crear nuevo plan
        INSERT INTO [dbo].[caipi_plans] (
            [name], 
            [description], 
            [periodStart], 
            [periodEnd], 
            [enabled], 
            [imgURL]
        )
        VALUES (
            @newPlanName,
            @newPlanDescription,
            GETDATE(),
            DATEADD(YEAR, 1, GETDATE()),
            1,
            NULL
        );
        
        SET @newPlanId = SCOPE_IDENTITY();
        
        -- Deshabilitar plan viejo
        UPDATE [dbo].[caipi_plans]
        SET [enabled] = 0
        WHERE [planId] = @oldPlanId;
        
        -- Verificar si se deshabilitó el plan viejo
        IF @oldPlanEnabled = 1 AND @@ROWCOUNT = 0
            RAISERROR('No se deshabilitó el plan antiguo', 16, 1);
        
        -- Crear precio para el nuevo plan
        INSERT INTO [dbo].[caipi_planPrices] (
            [amount], 
            [postTime], 
            [endDate], 
            [recurrencyType], 
            [current], 
            [planId]
        )
        VALUES (
            @newPlanAmount,
            GETDATE(),
            NULL,
            1,
            1,
            @newPlanId
        );
        
        -- Llamar al SP 3 para manejar features
        DECLARE @featuresSuccess BIT;

        EXEC dbo.SP_Features_Management
            @newPlanId = @newPlanId,
            @oldPlanId = @oldPlanId,
            @success = @featuresSuccess OUTPUT;
            
        IF @featuresSuccess = 0
            RAISERROR('Error en el manejo de features', 16, 1);
        
        SET @success = 1;
        
        IF @InicieTransaccion = 1 BEGIN
            COMMIT;
        END;
    END TRY
    BEGIN CATCH
        SET @ErrorNumber = ERROR_NUMBER();
        SET @ErrorSeverity = ERROR_SEVERITY();
        SET @ErrorState = ERROR_STATE();
        SET @Message = ERROR_MESSAGE();
        SET @success = 0;
        SET @newPlanId = NULL;
        
        IF @InicieTransaccion = 1 BEGIN
            ROLLBACK;
        END;

		DECLARE @LogId INT
		SELECT @logId = ISNULL(MAX([logId]), 0) + 1 FROM [dbo].[caipi_Log];
        
        INSERT INTO [dbo].[caipi_Log] (
            [logId],
            [description],
            [postTime],
            [computer],
            [username],
            [trace],
            [reference1],
            [reference2],
            [value1],
            [value2],
            [checksum]
        )
        VALUES (
            @logId,
            LEFT('Error en SP_Plan_Management: ' + @Message, 100),
            GETDATE(),
            HOST_NAME(),
            SUSER_NAME(),
            'Línea: ' + CAST(ERROR_LINE() AS VARCHAR(10)),
            @ErrorNumber,
            @ErrorSeverity,
            @ErrorState,
            NULL,
            HASHBYTES('SHA2_256', LEFT('Error en SP_Plan_Management: ' + @Message, 100))
        );
        
        
        RAISERROR('Error en gestión de planes - Código: %i', 
            @ErrorSeverity, @ErrorState, @CustomError);
    END CATCH;
    
    RETURN 0;
END;
GO

-----------------------------------------------------------
-- Descripcion: Manejo de features y features por plan
-- Otros detalles: Actualiza features para planes nuevos y viejos
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[SP_Features_Management]
    @newPlanId INT,
    @oldPlanId INT,
    @success BIT OUTPUT
WITH ENCRYPTION, EXECUTE AS 'dbo'
AS 
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT;
    DECLARE @Message VARCHAR(100);
    DECLARE @InicieTransaccion BIT;
    
    
    DECLARE @oldFeaturesCount INT;
    SELECT @oldFeaturesCount = COUNT(*) 
    FROM [dbo].[caipi_featuresPerPlan] 
    WHERE [planId] = @oldPlanId AND [enabled] = 1;
    
    SET @InicieTransaccion = 0;
    IF @@TRANCOUNT = 0 BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;     
    END;
    
    BEGIN TRY
        SET @CustomError = 2001;

        -- Deshabilitar featuresPerPlan del plan viejo
        UPDATE [dbo].[caipi_featuresPerPlan]
        SET [enabled] = 0
        WHERE [planId] = @oldPlanId AND [enabled] = 1;
        
        -- Verificar si se afectaron filas
        IF @oldFeaturesCount > 0 AND @@ROWCOUNT = 0
            RAISERROR('No se deshabilitaron features para el plan antiguo', 16, 1);
        
        -- Crear nuevos featuresPerPlan para el nuevo plan
        INSERT INTO [dbo].[caipi_featuresPerPlan] ([enabled], [featureId], [planId])
        VALUES 
            (1, 1, @newPlanId),
            (1, 2, @newPlanId); 
            
        -- Deshabilitar los features asociados al plan viejo
        UPDATE [dbo].[caipi_Features]
        SET [enabled] = 0
        WHERE [featureId] IN (
            SELECT [featureId] 
            FROM [dbo].[caipi_featuresPerPlan] 
            WHERE [planId] = @oldPlanId
        );
        
        SET @success = 1;
        
        IF @InicieTransaccion = 1 BEGIN
            COMMIT;
        END;
    END TRY
    BEGIN CATCH
        SET @ErrorNumber = ERROR_NUMBER();
        SET @ErrorSeverity = ERROR_SEVERITY();
        SET @ErrorState = ERROR_STATE();
        SET @Message = ERROR_MESSAGE();
        SET @success = 0;
        
        IF @InicieTransaccion = 1 BEGIN
            ROLLBACK;
        END;
        
        DECLARE @LogId INT
		SELECT @logId = ISNULL(MAX([logId]), 0) + 1 FROM [dbo].[caipi_Log];
        
        INSERT INTO [dbo].[caipi_Log] (
            [logId],
            [description],
            [postTime],
            [computer],
            [username],
            [trace],
            [reference1],
            [reference2],
            [value1],
            [value2],
            [checksum]
        )
        VALUES (
            @logId,
            LEFT('Error en SP_Features_Management: ' + @Message, 100),
            GETDATE(),
            HOST_NAME(),
            SUSER_NAME(),
            'Línea: ' + CAST(ERROR_LINE() AS VARCHAR(10)),
            @ErrorNumber,
            @ErrorSeverity,
            @ErrorState,
            NULL,
            HASHBYTES('SHA2_256', LEFT('Error en SP_Features_Management: ' + @Message, 100))
        );

        RAISERROR('Error en gestión de features - Código: %i', 
            @ErrorSeverity, @ErrorState, @CustomError);
    END CATCH;
    
    RETURN 0;
END;
GO


DECLARE @success BIT;
DECLARE @message NVARCHAR(500);

-- Ejecutar con usuario ID 1 que existe y tiene un plan activo
EXEC [dbo].[SP_UserPlan_Update]
    @userId = 1,
    @newPlanName = 'Plan Premium 2025',
    @newPlanDescription = 'Plan con beneficios premium para el año 2025',
    @newPlanAmount = 99.99,
    @newLimitPeople = 5,
    @newLimitValue = 1000,
    @success = @success OUTPUT,
    @message = @message OUTPUT;

SELECT @success AS Success, @message AS Message;

-- Verificar resultados
SELECT * FROM [dbo].[caipi_planPerUser] WHERE [userId] = 1;
SELECT * FROM [dbo].[caipi_plans] WHERE [name] = 'Plan Premium 2025';
SELECT * FROM [dbo].[caipi_PlanLimits] WHERE [planPerUserId] IN (
   SELECT [planPerUserId] FROM [dbo].[caipi_planPerUser] WHERE [userId] = 1
);

DECLARE @success BIT;
DECLARE @message NVARCHAR(500);

-- Ejecutar con usuario ID 999 que no existe
EXEC [dbo].[SP_UserPlan_Update]
    @userId = 999,
    @newPlanName = 'Plan Premium 2025',
    @newPlanDescription = 'Plan con beneficios premium para el año 2025',
    @newPlanAmount = 99.99,
    @newLimitPeople = 5,
    @newLimitValue = 1000,
    @success = @success OUTPUT,
    @message = @message OUTPUT;

SELECT @success AS Success, @message AS Message;

DECLARE @success BIT;
DECLARE @message NVARCHAR(500);

-- Ejecutar con nombre de plan nulo (inválido)
EXEC [dbo].[SP_UserPlan_Update]
    @userId = 1,
    @newPlanName = NULL,
    @newPlanDescription = 'Plan con beneficios premium para el año 2025',
    @newPlanAmount = 99.99,
    @newLimitPeople = 5,
    @newLimitValue = 1000,
    @success = @success OUTPUT,
    @message = @message OUTPUT;

SELECT @success AS Success, @message AS Message;


-- TRIGGER
CREATE TRIGGER dbo.caipi_Log_AfterInsertTrigger
ON [dbo].[caipi_Log]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @logId INT, @description NVARCHAR(100), @errorNumber INT;
    
    -- Obtener los datos de la inserción
    SELECT 
        @logId = [logId],
        @description = [description],
        @errorNumber = [reference1]  
    FROM inserted;
    
    -- Solo procesar registros de errores de SPs
    IF @description LIKE 'Error en SP[_]%'
    BEGIN
        BEGIN TRY
            -- Determinar severidad basada en errorNumber
            DECLARE @severityName VARCHAR(50);
            IF @errorNumber BETWEEN 1 AND 10 SET @severityName = 'Informativo';
            ELSE IF @errorNumber BETWEEN 11 AND 16 SET @severityName = 'Advertencia';
            ELSE SET @severityName = 'Error Crítico';
            
            -- Insertar en caipi_LogSeverity
            INSERT INTO [dbo].[caipi_LogSeverity] (
                [logSeverityId],
                [name],
                [logId]
            )
            VALUES (
                (SELECT ISNULL(MAX([logSeverityId]), 0) + 1 FROM [dbo].[caipi_LogSeverity]),
                @severityName,
                @logId
            );
            
            -- Insertar en caipi_LogSources
            INSERT INTO [dbo].[caipi_LogSources] (
                [logSourceId],
                [name],
                [logId]
            )
            VALUES (
                (SELECT ISNULL(MAX([logSourceId]), 0) + 1 FROM [dbo].[caipi_LogSources]),
                'Trigger caipi_Log_AfterInsertTrigger',
                @logId
            );
            
            -- Insertar en caipi_LogTypes
            INSERT INTO [dbo].[caipi_LogTypes] (
                [logtypeId],
                [name],
                [ref1Desc],
                [ref2Desc],
                [val1Desc],
                [val2Desc],
                [logId]
            )
            VALUES (
                (SELECT ISNULL(MAX([logtypeId]), 0) + 1 FROM [dbo].[caipi_LogTypes]),
                'Error de Procedimiento Almacenado',
                'Número de Error',
                'Severidad',
                'Estado',
                NULL,
                @logId
            );
        END TRY
        BEGIN CATCH
            -- Registrar error del trigger sin causar bucles infinitos
            IF ERROR_NUMBER() <> 266 -- No registrar errores de transacción no iniciada
            BEGIN
                DECLARE @triggerError NVARCHAR(4000) = ERROR_MESSAGE();
                PRINT 'Error en trigger caipi_Log_AfterInsertTrigger: ' + @triggerError;
            END
        END CATCH;
    END
END;
GO







---------------------------------------------- Consultas Miscelaneas 2 ----------------------------------------------

use caipiDb;

-- Contenido CSV entre State y Countries
SELECT CAST(STRING_AGG(Line, CHAR(13) + CHAR(10)) AS NVARCHAR(MAX)) AS CsvOutput
FROM (
    -- Header Info
    SELECT 'stateId,stateName,countryId,countryName,currencyId' AS Line

    UNION ALL

    -- Datos
    SELECT 
        CAST(s.stateId AS VARCHAR) + ',' +
        s.name + ',' +
        CAST(c.countryId AS VARCHAR) + ',' +
        c.name + ',' +
        CAST(c.currencyId AS VARCHAR)
    FROM caipi_States s
    JOIN caipi_Countries c ON s.countryId = c.countryId
) AS CsvLines;


-- Intersect para Cities y Adressess en San Jose
SELECT c.cityId, c.name AS cityName, a.line1, a.line2, a.zipcode
FROM caipi_Cities c
JOIN caipi_States s ON c.stateId = s.stateId
JOIN caipi_adresses a ON c.cityId = a.cityId
WHERE s.name = 'San José'
INTERSECT
SELECT c1.cityId, c1.name AS cityName, a1.line1, a1.line2, a1.zipcode
FROM caipi_Cities c1
JOIN caipi_States s1 ON c1.stateId = s1.stateId
JOIN caipi_adresses a1 ON c1.cityId = a1.cityId
WHERE s1.name = 'San José';

-- Except: Se comprueba que si un address esta en San Jose, su estado también.
---- Se usaría para encontrar discrepancias o errores en ubicaciones insertadas
SELECT 
    c.cityId AS City_ID, 
    c.name AS City_Name, 
    a.zipcode AS Postal_Code
FROM caipi_Cities c
JOIN caipi_States s ON c.stateId = s.stateId
JOIN caipi_adresses a ON c.cityId = a.cityId
WHERE s.name = 'San José'
EXCEPT
SELECT 
    c1.cityId AS City_ID, 
    c1.name AS City_Name, 
    a1.zipcode AS Postal_Code
FROM caipi_Cities c1
JOIN caipi_States s1 ON c1.stateId = s1.stateId
JOIN caipi_adresses a1 ON c1.cityId = a1.cityId
WHERE s1.name = 'San José';

-- JSON de Planes
SELECT 
    p.name AS plan_name,
    p.description AS plan_description,
    p.periodStart AS period_start,
    p.periodEnd AS period_end,
    fpf.enabled AS feature_enabled,
    fn.name AS feature_name,
    ft.name AS feature_type,
    f.value AS feature_value
FROM caipi_plans p
JOIN caipi_featuresPerPlan fpf ON p.planId = fpf.planId
JOIN caipi_Features f ON fpf.featureId = f.featureId
JOIN caipi_FeaturesType ft ON f.featureTypeId = ft.featureTypeId
JOIN caipi_featureName fn ON f.featureNameId = fn.featureNameId
WHERE p.enabled = 1
FOR JSON PATH, ROOT('Plans')

-- DISTINCT
---- Se usa para retornar combinaciones únicas de ciudades con zip code
SELECT DISTINCT 
    ca.zipcode, 
    ca.cityId, 
    c.name AS cityName
FROM caipi_adresses ca
JOIN caipi_Cities c ON ca.cityId = c.stateId;

-- UNION
---- Se usa para unir los adresses de instituciones y ciudades
SELECT 
    line1 AS name,
    'Address' AS type,
    zipcode,
    cityId
FROM caipi_adresses
UNION
SELECT 
    i.nombre AS name,
    'Institution' AS type,
    a.zipcode,
    a.cityId
FROM caipi_Instituciones i
JOIN caipi_adresses a ON i.adressId = a.adressId;

-- LTRIM, SUBSTRING y && (AND)
---- La posición geográfica de los adresses se cambia a string y se le aplica LTRIM y se usa SUBSTRING para extraer la primera coordenada.
---- El zipcode no puede tener el número 7 y la linea 2 desde la dirección no puede tener la palabra "Ruta"
SELECT 
    line1 AS Linea1,
    line2 AS Linea2,
    zipcode AS [Zip Code],
    LTRIM(SUBSTRING(
        geoposition.ToString(), 
        CHARINDEX('(', geoposition.ToString()) + 1, 
        CHARINDEX(',', geoposition.ToString()) - CHARINDEX('(', geoposition.ToString()) - 1
    )) AS [First Coordinate]
FROM caipi_adresses
WHERE 
    CAST(zipcode AS VARCHAR) NOT LIKE '7%' AND
    LOWER(line2) NOT LIKE '%Ruta%';

-- MERGE
----- Usado para eliminar las ciudades con nombre asemejados a provincias

MERGE caipi_Cities AS target
USING caipi_States AS source
ON target.name = source.name
WHEN MATCHED THEN UPDATE SET target.name = 'Repetido';





---------------------------------------------- Consultas Miscelaneas 3 ----------------------------------------------

CREATE TYPE ContractConditionsTVP AS TABLE
(
    featureName NVARCHAR(100),
    featureTypeId INT,
    value FLOAT,
    featurePriceTypeId INT,
    originalPrice MONEY,
    discountValue FLOAT,
    solturaPercent FLOAT,
    userPrice MONEY,
    userPriceivi MONEY
);
GO

CREATE PROCEDURE sp_UpsertProviderContract
    @ProviderName NVARCHAR(100),
    @AddressId INT,
    @Conditions tvp_ContractConditions READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @InstitutionId INT;

        -- Verificar si ya existe el proveedor
        SELECT @InstitutionId = institucioneId
        FROM caipi_Instituciones
        WHERE nombre = @ProviderName;

        -- Si no existe, insertarlo
        IF @InstitutionId IS NULL
        BEGIN
            INSERT INTO caipi_Instituciones(nombre, creationDate, enabled, adressId)
            VALUES (@ProviderName, GETDATE(), 1, @AddressId);

            SET @InstitutionId = SCOPE_IDENTITY();
        END

        -- Crear nuevo PartnerDeal si no existe uno activo
        DECLARE @PartnerDealId INT;

        SELECT TOP 1 @PartnerDealId = partnerDealId
        FROM caipi_PartnerDeals
        WHERE institucioneId = @InstitutionId AND isActive = 1
        ORDER BY sealDate DESC;

        IF @PartnerDealId IS NULL
        BEGIN
            INSERT INTO caipi_PartnerDeals(institucioneId, sealDate, isActive, dealDescription)
            VALUES (@InstitutionId, GETDATE(), 1, 'Generated by SP');

            SET @PartnerDealId = SCOPE_IDENTITY();
        END

        -- Procesar cada condición
        DECLARE @featureName NVARCHAR(100),
                @featureTypeId INT,
                @value NVARCHAR(100),
                @featurePriceTypeId INT,
                @originalPrice DECIMAL(18, 2),
                @discountValue DECIMAL(18, 2),
                @solturaPercent DECIMAL(18, 2),
                @userPrice DECIMAL(18, 2),
                @userPriceivi DECIMAL(18, 2),
                @featureNameId INT,
                @featurePriceId INT;

        DECLARE condition_cursor CURSOR FOR
            SELECT featureName, featureTypeId, value, featurePriceTypeId, originalPrice, discountValue,
                   solturaPercent, userPrice, userPriceivi
            FROM @Conditions;

        OPEN condition_cursor;
        FETCH NEXT FROM condition_cursor INTO @featureName, @featureTypeId, @value,
                                             @featurePriceTypeId, @originalPrice, @discountValue,
                                             @solturaPercent, @userPrice, @userPriceivi;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obtener o insertar featureNameId
            SELECT @featureNameId = featureNameId FROM caipi_featureName WHERE name = @featureName;

            IF @featureNameId IS NULL
            BEGIN
                INSERT INTO caipi_featureName(name) VALUES (@featureName);
                SET @featureNameId = SCOPE_IDENTITY();
            END

            -- Insertar nuevo featurePrice
            INSERT INTO caipi_featurePrice(featurePriceTypeId, originalPrice, discountValue,
                                           solturaPercent, userPrice, userPriceivi, partnerDealId)
            VALUES (@featurePriceTypeId, @originalPrice, @discountValue,
                    @solturaPercent, @userPrice, @userPriceivi, @PartnerDealId);

            SET @featurePriceId = SCOPE_IDENTITY();

            -- Insertar nueva característica
            INSERT INTO caipi_Features(featureNameId, value, enabled, featureTypeId,
                                       institucionesid, featurePriceId)
            VALUES (@featureNameId, @value, 1, @featureTypeId,
                    @InstitutionId, @featurePriceId);

            FETCH NEXT FROM condition_cursor INTO @featureName, @featureTypeId, @value,
                                                 @featurePriceTypeId, @originalPrice, @discountValue,
                                                 @solturaPercent, @userPrice, @userPriceivi;
        END

        CLOSE condition_cursor;
        DEALLOCATE condition_cursor;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END



DECLARE @contract tvp_ContractConditions;

INSERT INTO @contract(featureName, featureTypeId, value, featurePriceTypeId,
                      originalPrice, discountValue, solturaPercent, userPrice, userPriceivi)
VALUES 
('Free WiFi/mo', 2, '1', 1, 5000, 500, 0.1, 4500, 5000),
('Extra Lounge Access', 1, '2', 2, 10000, 0.2, 0.1, 8000, 9000);

EXEC sp_UpsertProviderContract 
    @ProviderName = 'New Lounge Co',
    @AddressId = 8,
    @Conditions = @contract;




