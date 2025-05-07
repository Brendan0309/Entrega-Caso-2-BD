use caipiDB;

/*
insert into caipi_Currencies(name, acronym, symbol)
values ('Colón Costarricense', 'CRC', '₡'),
('Dólar Estadounidense', 'USD', '$');

insert into caipi_CurrencyConversions(startdate, enddate, exchangeRate, enabled, currentExchangeRate, currencyid_source, currencyid_destiny)
values (GETDATE(), DATEADD(m, 2, GETDATE()), 0.002, 1, 1, 1, 2),
(GETDATE(), DATEADD(m, 2, GETDATE()), 502.53, 1, 1, 2, 1);

insert into caipi_Personas(firstName, lastname, birthdate)
values ('Lucas', 'Ramírez', '2001-08-14'),
('Sofía', 'González', '1999-03-10'),
('Mateo', 'Fernández', '2000-11-22'),
('Isabella', 'Martínez', '2004-01-05'),
('Sebastián', 'López', '1998-09-16'),
('Valentina', 'Hernández', '2002-06-25'),
('Gabriel', 'Jiménez', '1997-02-13'),
('Camila', 'Morales', '2003-12-30'),
('Tomás', 'Castillo', '2005-04-02'),
('Emilia', 'Ortega', '2006-05-19'),
('Santiago', 'Cruz', '2004-07-11'),
('Lucía', 'Silva', '2001-10-09'),
('Diego', 'Vargas', '2000-03-28'),
('Martina', 'Reyes', '1999-06-07'),
('Daniel', 'Navarro', '2005-09-03'),
('Renata', 'Torres', '2002-01-18'),
('Julián', 'Flores', '2003-08-23'),
('Victoria', 'Ríos', '1996-12-14'),
('Emmanuel', 'Carrillo', '2004-02-26'),
('Antonia', 'Mendoza', '2001-07-17'),
('Agustín', 'Romero', '1998-04-06'),
('Josefina', 'Suárez', '1999-11-01'),
('Andrés', 'Peña', '2006-03-09'),
('Catalina', 'Delgado', '2000-10-30'),
('Nicolás', 'Ibarra', '2003-06-12'),
('Paula', 'Campos', '2004-09-27'),
('Bruno', 'Vega', '2002-05-20'),
('Florencia', 'Acosta', '2005-12-05'),
('Lautaro', 'Paredes', '1997-07-21'),
('Milagros', 'Molina', '2006-01-30');

insert into caipi_Users(password, enabled, personId)
select 
    convert(varbinary(36), newid()) as password,
    1 as enabled,
    p.personId as personId
from (
    select top 30 personId
    from caipi_Personas
    order by personId asc
) as p;

insert into caipi_Countries(name, currencyId)
values ('Costa Rica', 1);

insert into caipi_States(name, countryId)
values ('San José', 1), ('Alajuela', 1), ('Cartago', 1), ('Heredia', 1), ('Guanacaste', 1), ('Puntarenas', 1), ('Limón', 1);

insert into caipi_Cities(name, stateId)
values ('Escazú', 1), ('Grecia', 2), ('Cartago', 3), ('Heredia', 4), ('Liberia', 5), ('Puntarenas', 6), ('Pococí', 7);

INSERT INTO caipi_adresses (line1, line2, zipcode, geoposition, cityId)
VALUES 
('Avenida Escazú', 'Ruta hacia Multiplaza Escazú', 10201, 
geography::STGeomFromText('LINESTRING(-84.1400 9.9189, -84.1375 9.9195, -84.1350 9.9200)', 4326), 1),
('San Rafael', 'Camino al Parque Central de Escazú', 10201, 
geography::STGeomFromText('LINESTRING(-84.1390 9.9270, -84.1380 9.9240, -84.1370 9.9210)', 4326), 1),
('Bello Horizonte', 'Recorrido por calle residencial', 10201, 
geography::STGeomFromText('LINESTRING(-84.3005 10.0750, -84.2990 10.0755, -84.2975 10.0760)', 4326), 1),
('Mercado Municipal', 'Camino hacia el Colegio Nocturno', 20304, 
geography::STGeomFromText('LINESTRING(-84.3040 10.0720, -84.3025 10.0728, -84.3010 10.0735)', 4326), 2),
('Residencial El Trapiche', 'Calle 2 dirección al parque', 20304, 
geography::STGeomFromText('LINESTRING(-84.3095 10.0700, -84.3080 10.0710, -84.3065 10.0720)', 4326), 2),
('Barrio Latino', 'Desde cancha de fútbol hacia la iglesia', 20304, 
geography::STGeomFromText('LINESTRING(-84.3075 10.0740, -84.3060 10.0750, -84.3045 10.0760)', 4326), 2),
('Basílica de Nuestra Señora de los Ángeles', 'Ruta desde Parque Central', 30101, 
geography::STGeomFromText('LINESTRING(-83.9170 9.8640, -83.9160 9.8650, -83.9150 9.8660)', 4326), 3),
('Mercado Municipal de Cartago', 'Camino hacia Estación de Tren', 30101, 
geography::STGeomFromText('LINESTRING(-83.9185 9.8620, -83.9175 9.8630, -83.9165 9.8640)', 4326), 3),
('Universidad de Costa Rica - Sede Cartago', 'Ruta por Avenida 4', 30101, 
geography::STGeomFromText('LINESTRING(-83.9195 9.8600, -83.9185 9.8610, -83.9175 9.8620)', 4326), 3),
('Parque Central de Heredia', 'Ruta por Calle 2', 40101, 
geography::STGeomFromText('LINESTRING(-84.1160 9.9980, -84.1150 9.9990, -84.1140 10.0000)', 4326), 4),
('Universidad Nacional de Costa Rica', 'Camino hacia Biblioteca Central', 40101, 
geography::STGeomFromText('LINESTRING(-84.1175 9.9960, -84.1165 9.9970, -84.1155 9.9980)', 4326), 4),
('Hospital San Vicente de Paúl', 'Ruta desde Avenida Central', 40101, 
geography::STGeomFromText('LINESTRING(-84.1185 9.9940, -84.1175 9.9950, -84.1165 9.9960)', 4326), 4),
('Parque Central de Liberia', 'Ruta por Calle Real', 50101, 
geography::STGeomFromText('LINESTRING(-85.4370 10.6340, -85.4360 10.6350, -85.4350 10.6360)', 4326), 5),
('Museo de Guanacaste', 'Camino hacia Iglesia Inmaculada Concepción', 50101, 
geography::STGeomFromText('LINESTRING(-85.4385 10.6320, -85.4375 10.6330, -85.4365 10.6340)', 4326), 5),
('Estación de Autobuses de Liberia', 'Ruta desde Avenida 25 de Julio', 50101, 
geography::STGeomFromText('LINESTRING(-85.4395 10.6300, -85.4385 10.6310, -85.4375 10.6320)', 4326), 5),
('Parque Marino del Pacífico', 'Ruta por Paseo de los Turistas', 60101, 
geography::STGeomFromText('LINESTRING(-84.8330 9.9760, -84.8320 9.9770, -84.8310 9.9780)', 4326), 6),
('Catedral de Puntarenas', 'Camino hacia Mercado Municipal', 60101, 
geography::STGeomFromText('LINESTRING(-84.8345 9.9740, -84.8335 9.9750, -84.8325 9.9760)', 4326), 6),
('Estación de Trenes de Puntarenas', 'Ruta desde Avenida Central', 60101, 
geography::STGeomFromText('LINESTRING(-84.8355 9.9720, -84.8345 9.9730, -84.8335 9.9740)', 4326), 6),
('Parque Central de Guápiles', 'Ruta por Calle 4', 70201, 
geography::STGeomFromText('LINESTRING(-83.7890 10.2150, -83.7880 10.2160, -83.7870 10.2170)', 4326), 7),
('Terminal de Buses de Guápiles', 'Camino hacia Hospital de Guápiles', 70201, 
geography::STGeomFromText('LINESTRING(-83.7905 10.2130, -83.7895 10.2140, -83.7885 10.2150)', 4326), 7),
('Centro Comercial Guápiles', 'Ruta desde Avenida Central', 70201, 
geography::STGeomFromText('LINESTRING(-83.7915 10.2110, -83.7905 10.2120, -83.7895 10.2130)', 4326), 7);

insert into caipi_Instituciones(nombre, creationDate, enabled, adressId)
values ('SmartFit', GETDATE(), 1, 1),
	('EcoCombustibles', GETDATE(), 1, 2),
	('Aromatta Café', GETDATE(), 1, 3),
	('Cinemark', GETDATE(), 1, 4),
	('Wing Shun', GETDATE(), 1, 5),
	('Delicias Grill', GETDATE(), 1, 6),
	('Parqueo Central+', GETDATE(), 1, 7);

insert into caipi_PartnerDeals(institucioneId, sealDate, isActive, dealDescription)
values (1, GETDATE(), 1, 'This is a deal'),
(2, GETDATE(), 1, 'This is a deal'),
(3, GETDATE(), 1, 'This is a deal'),
(4, GETDATE(), 1, 'This is a deal'),
(5, GETDATE(), 1, 'This is a deal'),
(6, GETDATE(), 1, 'This is a deal'),
(7, GETDATE(), 1, 'This is a deal');

insert into caipi_featurePriceTypes(name)
values ('Monto Fijo'), ('Porcentaje');

INSERT INTO caipi_featurePrice (featurePriceTypeId, originalPrice, discountValue, solturaPercent, userPrice, userPriceivi, partnerDealId)
VALUES
(2, 29862, 0.26, 0.19, 22097, 24950, 1),
(2, 74406, 0.1, 0.28, 63616, 71900, 1),
(1, 47126, 1160, 0.18, 41483, 46900, 1),
(2, 60871, 0.21, 0.19, 48088, 54350, 2),
(2, 54186, 0.09, 0.27, 46843, 52950, 2),
(1, 17754, 2934, 0.17, 14820, 16750, 2),
(2, 61368, 0.33, 0.17, 41116, 46450, 3),
(2, 78565, 0.21, 0.12, 62066, 70150, 3),
(2, 15390, 0.08, 0.16, 13450, 15200, 3),
(1, 75710, 13242, 0.25, 62468, 70600, 4),
(2, 79278, 0.38, 0.20, 49152, 55550, 4),
(2, 23141, 0.30, 0.14, 16198, 18300, 4),
(2, 19939, 0.05, 0.26, 17094, 19300, 5),
(2, 80045, 0.13, 0.18, 69639, 78700, 5),
(1, 91017, 31301, 0.16, 59716, 67500, 5),
(2, 48029, 0.28, 0.24, 34580, 39100, 6),
(1, 21283, 5949, 0.16, 15334, 17350, 6),
(2, 26598, 0.36, 0.12, 17022, 19250, 6),
(2, 46577, 0.29, 0.16, 33069, 37350, 7),
(2, 26893, 0.30, 0.26, 18825, 21250, 7),
(1, 84974, 29225, 0.16, 55749, 63000, 7);

insert into caipi_featureName(name)
values ('free classes/mo'),
('Unlimited membership classes'),
('Free fitness eval/mo'),

('Amount off fuel (Purchase value greater than 10,000 CRC)'),
('Monthly oil check'),
('Priority lane access'),

('free drink/mo'),
('Free coffee upsize/wk'),

('Buy 1 ticket get 1 free fridays'),
('Free popcorn w/ ticket'),
('Percent off weekends'),

('Free Appetizer/mo'),
('Free Friday delivery'),

('Free dessert weekends'),
('% off takeout'),

('Free hrs/wk'),
('% off nights'),
('Amount weekend rate (Purchase value greater than 2,000 CRC)');

insert into caipi_FeaturesType(name, enabled)
values ('Unlimited service access during month', 1),
('Amount of free uses per month', 1),
('Amount of free uses per week', 1 ),
('Free access to service on given day', 1),
('Free access to service on weekends', 1),
('Set price discount', 1 ),
('Set price discount on weekends',1),
('% discount',1),
('% discount on weekends', 1),
('Hours of service per week',1);

insert into caipi_Features (featureNameId, value, enabled, featureTypeId, institucionesid, featurePriceId)
values (1, 4, 1, 2, 1, 1),
(2, 1, 1, 1, 1, 2),
(3, 1, 1, 2, 1, 3),
(3, 5000, 1, 6, 2, 4),
(5, 1, 1, 2, 2, 5),
(6, 1, 1, 1, 2, 6),
(7, 3, 1, 2, 3, 7),
(8, 1, 1, 3, 3, 8),
(9, 5, 1, 4, 4, 9),
(10, 1, 1, 1, 4, 10),
(11, 0.2, 1, 9, 4, 11),
(12, 1, 1, 2, 5, 12),
(13, 5, 1, 4, 5, 13),
(14, 1, 1, 5, 6, 14),
(15, 0.2, 1, 8, 6, 15),
(16, 10, 1, 10, 7, 16),
(17, 0.3, 1, 8, 7, 17),
(18, 1000, 1, 7, 7, 18);

insert into caipi_plans(name, description, periodStart, periodEnd, enabled)
values ('FitPlus Access', 'A complete fitness plan for those seeking flexibility, expert support, and training freedom.', GETDATE(), DATEADD(year, 1, GETDATE()), 1),
('Café Comfort Plan', 'Ideal for coffee lovers looking to enjoy more flavor, savings, and perks every visit.', GETDATE(), DATEADD(year, 1, GETDATE()), 1),
('DriveSaver Plan', 'The smart choice for frequent drivers who value convenience, savings, and reliability.', GETDATE(), DATEADD(year, 1, GETDATE()), 1),
('Movie Treat Pack', 'Perfect for film fans who love great value, extra snacks, and exclusive day deals.', GETDATE(), DATEADD(year, 1, GETDATE()), 1),
('Wing Night Deal', 'Craving comfort food? Get more flavor, savings, and convenience every week.', GETDATE(), DATEADD(year, 1, GETDATE()), 1),
('Chill & Grill', 'Enjoy your meals with added perks and value, whether dining in or ordering out.', GETDATE(), DATEADD(year, 1, GETDATE()), 1),
('EasyPark Pass', 'A worry-free parking plan that offers flexibility, savings, and peace of mind.', GETDATE(), DATEADD(year, 1, GETDATE()), 1);

insert into caipi_featuresPerPlan(enabled, featureId, planId)
values (1, 1, 1), (1, 2, 1), (1, 3, 1), (1, 4, 2), (1, 5, 2), (1, 6, 2), (1, 7, 3), (1, 8, 3), (1, 9, 4), (1, 10, 4), (1, 11, 4),
(1, 12, 5), (1, 13, 5), (1, 14, 6), (1, 15, 6), (1, 16, 7), (1, 17, 7), (1, 18, 7);

insert into caipi_planPerUser(adquisitionDate, expirationDate, enabled, planId, userId)
select 
    '2025-5-1' as adquisitionDate,
    '2025-6-1' as expirationDate,
	1 as enabled,
	((p.userId - 1) % 7) + 1 as planId,
    p.userId as userId
from (
    select top 25 userId
    from caipi_Users
    order by userId asc
) as p;
*/

insert into caipi_MetodosDePago(name, apiURL, secretKey, llave, enabled)
values ('Stripe', 'https://api.stripe.com/v1/charges/', convert(varbinary(250), newid()), convert(varbinary(128), newid()), 1),
('Authorize.net', 'https://www.sandbox.paypal.com', convert(varbinary(250), newid()), convert(varbinary(128), newid()), 1),
('PayPal', 'https://api-m.sandbox.paypal.com', convert(varbinary(250), newid()), convert(varbinary(128), newid()), 1),
('Adyen', 'https://checkout-test.adyen.com/', convert(varbinary(250), newid()), convert(varbinary(128), newid()), 1),
('Braintree', 'https://payments.braintree-api.com', convert(varbinary(250), newid()), convert(varbinary(128), newid()), 1);

select * from caipi_MetodosDePago;

insert into caipi_mediosDisponibles(name, token, expTokenDate, maskAccount, callbackURLget, callBackPost, callBackRedirect, userId, metodoPagoId)
select
	concat('Metodo de pago 1 de usuario ', p.userId) as name,
	convert(varbinary(250), newid()) as token,
	dateadd(m, 2, getdate()) as expTokenDate,
	concat('**** **** **** **', p.userId + 10) as mascAccount,
	'https://mybusiness.com/api/payment/status' as callbackURLget,
	'https://mybusiness.com/api/payment/notification' as callBackPost,
	'https://mybusiness.com/payment/thank-you' as callBackRedirect,
	p.userId as userId,
	((p.userId * 13 - 1) % 5) + 1 as metodoPagoId
from (
    select top 30 userId
    from caipi_Users
    order by userId asc
) as p;

select * from caipi_mediosDisponibles;

-- Insertar datos de prueba en planprices

INSERT INTO [dbo].[caipi_planPrices] (
    amount, postTime, endDate, recurrencyType, [current], planId
)
VALUES
    -- Plan 1: Dos precios históricos y uno actual
    (39000, DATEADD(MONTH, -4, GETDATE()), DATEADD(MONTH, -2, GETDATE()), 3, 0, 1),  -- Trimestral, precio antiguo
    (35000, DATEADD(MONTH, -2, GETDATE()), DATEADD(MONTH, -1, GETDATE()), 3, 0, 1),  -- Precio intermedio
    (29000, DATEADD(MONTH, -1, GETDATE()), NULL, 3, 1, 1),  -- Precio actual
    
    -- Plan 2: Dos precios históricos y uno actual
    (19000, DATEADD(MONTH, -4, GETDATE()), DATEADD(MONTH, -2, GETDATE()), 3, 0, 2),  -- Trimestral, precio antiguo
    (15000, DATEADD(MONTH, -2, GETDATE()), DATEADD(MONTH, -1, GETDATE()), 3, 0, 2),  -- Precio intermedio
    (9000, DATEADD(MONTH, -1, GETDATE()), NULL, 3, 1, 2),  -- Precio actual

    -- Plan 3: Dos precios históricos y uno actual
    (29000, DATEADD(MONTH, -4, GETDATE()), DATEADD(MONTH, -2, GETDATE()), 3, 0, 3),  -- Trimestral, precio antiguo
    (25000, DATEADD(MONTH, -2, GETDATE()), DATEADD(MONTH, -1, GETDATE()), 3, 0, 3),  -- Precio intermedio
    (19000, DATEADD(MONTH, -1, GETDATE()), NULL, 3, 1, 3),  -- Precio actual

    -- Plan 4: Dos precios históricos y uno actual
    (59000, DATEADD(MONTH, -4, GETDATE()), DATEADD(MONTH, -2, GETDATE()), 3, 0, 4),  -- Trimestral, precio antiguo
    (55000, DATEADD(MONTH, -2, GETDATE()), DATEADD(MONTH, -1, GETDATE()), 3, 0, 4),  -- Precio intermedio
    (49000, DATEADD(MONTH, -1, GETDATE()), NULL, 3, 1, 4); -- Precio actual
    
-- Insertar datos de prueba en Metodos de pago
INSERT INTO [dbo].[caipi_MetodosDePago] 
    ([name], [apiURL], [secretKey], [llave], [logoIconURL], [enabled], [templateJSON])
VALUES
    ('Stripe', 'https://api.stripe.com/v1/charges/', 
     0x6034F5E0BB55334A94BAC4BE87CFDE90, 
     0x89E506C60F502045B576DE849B754429, 
     NULL, 1, NULL),
    
    ('Authorize.net', 'https://www.sandbox.paypal.com', 
     0x859A7A32CF852E45A71A8A30F47AA44A, 
     0x693019A482F5164DB6412FFF2AE4696F, 
     NULL, 1, NULL),
    
    ('PayPal', 'https://api-m.sandbox.paypal.com', 
     0x77E5C9D504656A46B6774630BD5BD0B6, 
     0x2730D1CA704242448432AA40856276A1, 
     NULL, 1, NULL),
    
    ('Adyen', 'https://checkout-test.adyen.com/', 
     0xD6BC40705000434EBD11C4F463C72F1E, 
     0xC04C802C63841F4CA4A96E75E3DFFE2D, 
     NULL, 1, NULL),
    
    ('Braintree', 'https://payments.braintree-api.com', 
     0x1B2C6C42244A2B439FDDE5F9C2BC2DCD, 
     0x9751E6F33926204794BC7B15ECBF98D1, 
     NULL, 1, NULL),
    
    ('Stripe', 'https://api.stripe.com/v1/charges/', 
     0xF8427E9F53D92040B6DE2F67F41B0DB0, 
     0x40463D70B7F9A244950A4B75E535A1A0, 
     NULL, 1, NULL),
    
    ('Authorize.net', 'https://www.sandbox.paypal.com', 
     0x6AA30D29D9415F4E927509B7BC2CEEF4, 
     0xFC3E21E77C0A6343ACFC24D199951563, 
     NULL, 1, NULL),
    
    ('PayPal', 'https://api-m.sandbox.paypal.com', 
     0x8D96721022FCE445ABDD998968202B39, 
     0x26BC0C6548D0CF48A48C7D1451AF04B1, 
     NULL, 1, NULL),
    
    ('Adyen', 'https://checkout-test.adyen.com/', 
     0xB4093BCF262739469F71B6149F75E8E2, 
     0xAA985CBF80A89041B2F4AF6A7A195A62, 
     NULL, 1, NULL),
    
    ('Braintree', 'https://payments.braintree-api.com', 
     0x3BA84A9DAB782846810059FBD23F5FC0, 
     0x4C0AD89498862D468A9B0EB655465AEB, 
     NULL, 1, NULL)

-- Insertar datos de prueba en MediosDisponibles

INSERT INTO [dbo].[caipi_MediosDisponibles] (
    [name],
    [token],
    [expTokenDate],
    [maskAccount],
    [callbackURLget],
    [callBackPost],
    [callBackRedirect],
    [userId],
    [metodoPagoId],
    [configurationJSON]
)
VALUES
(
    'Cuenta PayPal Personal',
    0x50617950616C2E4163636F756E742331,
    DATEADD(YEAR, 2, GETDATE()),
    'usuario1@dominio.com',
    'https://api.paypal.com/callback/get/111',
    'https://api.paypal.com/callback/post/111',
    'https://cliente.paypal.com/redirect/111',
    1,
    3,
    '{"email":"usuario1@dominio.com","verified":true,"accountType":"personal"}'
),
(
    'Cuenta PayPal Negocios',
    0x50617950616C2E4163636F756E742332,
    DATEADD(YEAR, 1, GETDATE()),
    'negocio@empresa.com',
    'https://api.paypal.com/callback/get/222',
    'https://api.paypal.com/callback/post/222',
    'https://cliente.paypal.com/redirect/222',
    2,
    3,
    '{"email":"negocio@empresa.com","verified":true,"accountType":"business","businessName":"Mi Empresa SL"}'
),
(
    'PayPal Premier',
    0x50617950616C2E4163636F756E742333,
    DATEADD(YEAR, 3, GETDATE()),
    'premier@cliente.com',
    'https://api.paypal.com/callback/get/333',
    'https://api.paypal.com/callback/post/333',
    'https://cliente.paypal.com/redirect/333',
    3, 
    3, 
    '{"email":"premier@cliente.com","verified":true,"accountType":"premier","creditCardLinked":true}'
),
(
    'PayPal Familiar',
    0x50617950616C2E4163636F756E742334,
    DATEADD(MONTH, 18, GETDATE()),
    'familia@hogar.com',
    'https://api.paypal.com/callback/get/444',
    'https://api.paypal.com/callback/post/444',
    'https://cliente.paypal.com/redirect/444',
    4,
    3,
    '{"email":"familia@hogar.com","verified":true,"accountType":"family","members":4}'
),
(
    'PayPal Ahorros',
    0x50617950616C2E4163636F756E742335,
    DATEADD(YEAR, 2, GETDATE()),
    'ahorros@finanzas.com',
    'https://api.paypal.com/callback/get/555',
    'https://api.paypal.com/callback/post/555',
    'https://cliente.paypal.com/redirect/555',
    5, 
    3, 
    '{"email":"ahorros@finanzas.com","verified":true,"accountType":"savings","balance":1500.00}'
)


-- Insertar datos de prueba en Languages

INSERT INTO [dbo].[caipi_Languages] (
    [languageId],
    [name],
    [culture],
    [countryId]
)
VALUES
-- Idioma 1: Español (España)
(
    1,
    'Español',
    'es-ES',
    1  -- Asumiendo que countryId 1 es España
)


-- Insertar datos de prueba en Modules

INSERT INTO [dbo].[caipi_Modules] (
    [moduleId],
    [name],
    [languajeId]
)
VALUES
-- Módulo 1: Suscripciones (asumiendo languageId 1 para español)
(
    1,
    'Suscripciones',
    1
),
-- Módulo 2: Tienda Online
(
    2,
    'Tienda Online',
    1
),
-- Módulo 3: Servicios
(
    3,
    'Servicios',
    1
),
-- Módulo 4: Donaciones
(
    4,
    'Donaciones',
    1
),
-- Módulo 5: Facturación
(
    5,
    'Facturación',
    1
),
-- Módulo 6: Reportes
(
    6,
    'Reportes',
    1
),
-- Módulo 7: Configuración
(
    7,
    'Configuración',
    1
),
-- Módulo 8: Administración
(
    8,
    'Administración',
    1
),
-- Módulo 9: Soporte
(
    9,
    'Soporte',
    1
),
-- Módulo 10: API
(
    10,
    'API',
    1
)


-- Insertar datos de prueba en Schedules

SET IDENTITY_INSERT [dbo].[caipi_Schedules] ON

INSERT INTO [dbo].[caipi_Schedules] (
    [scheduleId],
    [name],
    [recurrencyType],
    [repeat]
)
VALUES
(
    1,
    'Mensual',
    3,  -- Mensual
    1
)

SET IDENTITY_INSERT [dbo].[caipi_Schedules] OFF


-- Insertar datos de prueba en Pagos

INSERT INTO [dbo].[caipi_Pagos] (
    [pagoId],
    [pagoMedioId],
    [metodoPagoId],
    [personId],
    [monto],
    [actualMonto],
    [result],
    [auth],
    [chargeToken],
    [error],
    [fecha],
    [checksum],
    [exchangeRate],
    [convertedAmount],
    [moduleId],
    [currencyId],
    [scheduleId]
)
VALUES
    -- Pago 1: Suscripción (éxito)
    (
        1, 
        1, 
        1, 
        1, 
        29000,  -- 29.99 convertido
        29000,  -- 29.99 convertido
        0x53756363657373, 
        0x417574683132333435, 
        0x546F6B656E313233,
        NULL,
        '2025-01-15 10:30:00',
        0x436865636B73756D31,
        1.0,
        29000,  -- 29.99 convertido
        1,
        1,
        1
    ),
    -- Pago 2: Compra en tienda (error)
    (
        2, 
        2,
        3,
        2, 
        59000,  -- 59.50 convertido
        0, 
        0x4572726F72,
        0x417574683132333436, 
        0x546F6B656E313234, 
        'Fondos insuficientes',
        '2025-01-16 14:45:00', 
        0x436865636B73756D32, 
        1.0, 
        0, 
        2,
        1, 
        1
    ),
    -- Pago 3: Pago recurrente (éxito)
    (
        3, 
        3,
        2,
        3, 
        120000,  -- 120.00 convertido
        120000,  -- 120.00 convertido
        0x53756363657373, 
        0x417574683132333437, 
        0x546F6B656E313235, 
        NULL, 
        '2025-01-17 09:15:00', 
        0x436865636B73756D33, 
        0.85,
        102000,  -- 102.00 convertido
        3,
        2,
        1
    ),
    -- Pago 4: Renovación anual (éxito)
    (
        4, 
        1,
        1,
        4, 
        299000,  -- 299.00 convertido
        299000,  -- 299.00 convertido
        0x53756363657373, 
        0x417574683132333438, 
        0x546F6B656E313236, 
        NULL, 
        '2025-01-18 16:20:00', 
        0x436865636B73756D34, 
        1.0,
        299000,  -- 299.00 convertido
        1,
        1,
        1
    ),
    -- Pago 5: Donación (éxito)
    (
        5, 
        2,
        3,
        5, 
        50000,  -- 50.00 convertido
        50000,  -- 50.00 convertido
        0x53756363657373, 
        0x417574683132333439, 
        0x546F6B656E313237, 
        NULL, 
        '2025-01-19 11:10:00', 
        0x436865636B73756D35, 
        1.0,
        50000,  -- 50.00 convertido
        4,
        1,
        1
    ),
    -- Pago 6: Ejemplo adicional
    (
        6,
        1,
        1,
        1, 
        100000,  -- 100.00 convertido
        100000,  -- 100.00 convertido
        0x4578616D706C65526573756C7431,
        0x4578616D706C654175746831,
        0x4578616D706C65546F6B656E31,
        NULL,
        '2025-04-29 08:32:07.860',
        0x4578616D706C65436865636B73756D31,
        1,
        100000,  -- 100.00 convertido
        1,
        1,
        NULL
    ),
    -- Pago 7: Ejemplo adicional
    (
        7,
        3,
        3,
        2, 
        75000,  -- 75.50 convertido
        75000,  -- 75.50 convertido
        0x4578616D706C65526573756C7432,
        0x4578616D706C654175746832,
        0x4578616D706C65546F6B656E32,
        NULL,
        '2025-04-24 08:32:07.860',
        0x4578616D706C65436865636B73756D32,
        1,
        75000,  -- 75.50 convertido
        2,
        1,
        NULL
    ),
    -- Pago 8: Ejemplo adicional (error)
    (
        8,
        2,
        2,
        3, 
        200000,  -- 200.00 convertido
        0, 
        0x4578616D706C65526573756C7433,
        0x4578616D706C654175746833,
        0x4578616D706C65546F6B656E33,
        'Tarjeta declinada',
        '2025-04-19 08:32:07.860',
        0x4578616D706C65436865636B73756D33,
        1,
        0,
        3,
        1,
        NULL
    ),
    -- Pago 9: Ejemplo adicional
    (
        9,
        5,
        5,
        4, 
        150000,  -- 150.75 convertido (truncado a 150)
        150000,  -- 150.75 convertido (truncado a 150)
        0x4578616D706C65526573756C7434,
        0x4578616D706C654175746834,
        0x4578616D706C65546F6B656E34,
        NULL,
        '2025-04-14 08:32:07.860',
        0x4578616D706C65436865636B73756D34,
        1,
        150000,  -- 150.75 convertido (truncado a 150)
        4,
        1,
        NULL
    ),
    -- Pago 10: Ejemplo adicional
    (
        10,
        4,
        4,
        5, 
        89000,  -- 89.99 convertido
        89000,  -- 89.99 convertido
        0x4578616D706C65526573756C7435,
        0x4578616D706C654175746835,
        0x4578616D706C65546F6B656E35,
        NULL,
        '2025-04-09 08:32:07.860',
        0x4578616D706C65436865636B73756D35,
        1,
        89000,  -- 89.99 convertido
        5,
        1,
        NULL
    );


-- Insertar datos de prueba en SubTypes

INSERT INTO [dbo].[caipi_subTypes] (
    [subTypeId],
    [porcentaje],
    [detalle]
)
VALUES
-- Subtipo 1: Comisión estándar
(
    1,
    0.10, -- 10%
    'Comisión estándar por servicio'
)

-- Insertar datos de prueba en DealBenefitTypes

INSERT INTO [dbo].[caipi_DealBenefitTypes] 
    ([dealBenefitTypesId], [name], [description], [isActive])
VALUES
    (1, 'Descuento porcentual', 'Descuento aplicado como porcentaje sobre el precio original', 1),
    (2, 'Descuento fijo', 'Cantidad fija de descuento aplicada al precio', 1),
    (3, 'Envío gratuito', 'Beneficio de envío sin costo para el cliente', 1),
    (4, 'Producto gratis', 'Obsequio de un producto adicional con la compra', 1)


-- Insertar datos de prueba en partnerDealBenefits
INSERT INTO [dbo].[caipi_partnerDealBenefits] 
    ([partnerDealBenefitsId], [partnerDealId], [dealBenefitTypesid], 
     [starDate], [endDate], [planId], [limit], [userId])
VALUES
    (1, 1, 1, '2025-01-01', '2025-12-31', 1, 100, 1),
    (2, 1, 3, '2025-01-01', NULL, 1, 50, 1),
    (3, 2, 1, '2025-03-15', '2025-06-15', 2, 200, 2),
    (4, 3, 4, '2025-02-01', '2025-05-01', 3, 30, 3),
    (5, 4, 3, '2025-01-01', '2025-12-31', 4, 1000, 4),
    (6, 5, 2, '2025-04-01', NULL, 5, 75, 5)




-- Datos de prueba en pagos de los ultimos 30 dias
DECLARE @UltimoId INT;
SELECT @UltimoId = ISNULL(MAX(pagoId), 0) + 1 FROM dbo.caipi_Pagos;

INSERT INTO [dbo].[caipi_Pagos] (
    [pagoId],
    [pagoMedioId],
    [metodoPagoId],
    [personId],
    [monto],
    [actualMonto],
    [result],
    [auth],
    [chargeToken],
    [error],
    [fecha],
    [checksum],
    [exchangeRate],
    [convertedAmount],
    [moduleId],
    [currencyId],
    [scheduleId]
)
VALUES
    -- Pago 1: Pago exitoso con Stripe (hace 5 días)
    (@UltimoId, 1, 1, 1, 100.00, 100.00, 
     0x4578616D706C65526573756C7431, 0x4578616D706C654175746831, 
     0x4578616D706C65546F6B656E31, NULL, 
     DATEADD(day, -5, GETDATE()), 
     0x4578616D706C65436865636B73756D31, 1.0, 100.00, 1, 1, NULL),
    
    -- Pago 2: Pago exitoso con PayPal (hace 10 días)
    (@UltimoId + 1, 3, 3, 2, 75.50, 75.50, 
     0x4578616D706C65526573756C7432, 0x4578616D706C654175746832, 
     0x4578616D706C65546F6B656E32, NULL, 
     DATEADD(day, -10, GETDATE()), 
     0x4578616D706C65436865636B73756D32, 1.0, 75.50, 2, 1, NULL),
    
    -- Pago 3: Pago fallido con Authorize.net (hace 15 días)
    (@UltimoId + 2, 2, 2, 3, 200.00, 0.00, 
     0x4578616D706C65526573756C7433, 0x4578616D706C654175746833, 
     0x4578616D706C65546F6B656E33, 'Tarjeta declinada', 
     DATEADD(day, -15, GETDATE()), 
     0x4578616D706C65436865636B73756D33, 1.0, 0.00, 3, 1, NULL),
    
    -- Pago 4: Pago exitoso con Braintree (hace 20 días)
    (@UltimoId + 3, 5, 5, 4, 150.75, 150.75, 
     0x4578616D706C65526573756C7434, 0x4578616D706C654175746834, 
     0x4578616D706C65546F6B656E34, NULL, 
     DATEADD(day, -20, GETDATE()), 
     0x4578616D706C65436865636B73756D34, 1.0, 150.75, 4, 1, NULL),
    
    -- Pago 5: Pago exitoso con Adyen (hace 25 días)
    (@UltimoId + 4, 4, 4, 5, 89.99, 89.99, 
     0x4578616D706C65526573756C7435, 0x4578616D706C654175746835, 
     0x4578616D706C65546F6B656E35, NULL, 
     DATEADD(day, -25, GETDATE()), 
     0x4578616D706C65436865636B73756D35, 1.0, 89.99, 5, 1, NULL)





-- Datos de prueba en el PPU

insert into caipi_planPerUser(adquisitionDate, expirationDate, enabled, planId, userId)
select 
    CAST(GETDATE() AS DATE) as adquisitionDate,
    CAST(DATEADD(MONTH, 1, GETDATE()) AS DATE) as expirationDate,
	1 as enabled,
	((p.userId - 1) % 7) + 1 as planId,
    p.userId as userId
from (
    select top 25 userId
    from caipi_Users
    order by userId asc
) as p;


-- Datos de prueba para los 3 SP
-- Insertar monedas
INSERT INTO [dbo].[caipi_Currencies] ([name], [acronym], [symbol])
VALUES 
    ('Dólar Estadounidense', 'USD', '$'),
    ('Euro', 'EUR', '€'),
    ('Peso Mexicano', 'MXN', '$');

-- Insertar países
INSERT INTO [dbo].[caipi_Countries] ([name], [currencyId])
VALUES 
    ('Estados Unidos', 1),
    ('México', 3),
    ('España', 2);

-- Insertar estados
INSERT INTO [dbo].[caipi_States] ([name], [countryId])
VALUES 
    ('California', 1),
    ('Texas', 1),
    ('Ciudad de México', 2),
    ('Barcelona', 3);

-- Insertar ciudades
INSERT INTO [dbo].[caipi_Cities] ([name], [stateId])
VALUES 
    ('Los Ángeles', 1),
    ('Austin', 2),
    ('CDMX', 3),
    ('Barcelona', 4);

-- Insertar direcciones
INSERT INTO [dbo].[caipi_adresses] ([line1], [line2], [zipcode], [geoposition], [cityId])
VALUES 
    ('123 Main St', 'Apt 4B', '90001', geography::Point(34.0522, -118.2437, 4326), 1),
    ('456 Oak Ave', NULL, '78701', geography::Point(30.2672, -97.7431, 4326), 2);

-- Insertar personas
INSERT INTO [dbo].[caipi_Personas] ([firstName], [lastname], [birthdate])
VALUES 
    ('Juan', 'Pérez', '1985-05-15'),
    ('María', 'Gómez', '1990-08-22');

-- Insertar usuarios
INSERT INTO [dbo].[caipi_Users] ([password], [enabled], [userCompanyId], [personId])
VALUES 
    (0x8F3A7D20C45F6E, 1, NULL, 1), -- Contraseña hasheada
    (0xA5B4C3D2E1F0, 1, NULL, 2);

-- Insertar tipos de features
INSERT INTO [dbo].[caipi_FeaturesType] ([name], [enabled])
VALUES 
    ('Tipo Feature 1', 1),
    ('Tipo Feature 2', 1);

-- Insertar nombres de features
INSERT INTO [dbo].[caipi_featureName] ([name])
VALUES 
    ('Feature Básica'),
    ('Feature Premium');

-- Insertar features
INSERT INTO [dbo].[caipi_Features] ([featureNameId], [value], [enabled], [featureTypeId], [institucionesid], [featurePriceId])
VALUES 
    (1, 'Valor Feature 1', 1, 1, 1, 1),
    (2, 'Valor Feature 2', 1, 2, 1, 2);

-- Insertar tipos de precios de features
INSERT INTO [dbo].[caipi_featurePriceTypes] ([name])
VALUES 
    ('Tipo Precio 1'),
    ('Tipo Precio 2');

-- Insertar precios de features
INSERT INTO [dbo].[caipi_featurePrice] ([featurePriceTypeId], [originalPrice], [discountValue], [solturaPercent], [userPrice], [userPriceivi], [partnerDealId])
VALUES 
    (1, 100, 10, 0.05, 90, 95, 1),
    (2, 200, 20, 0.10, 180, 190, 1);

-- Insertar instituciones
INSERT INTO [dbo].[caipi_Instituciones] ([nombre], [creationDate], [enabled], [adressId])
VALUES 
    ('Institución Ejemplo', GETDATE(), 1, 1);

-- Insertar acuerdos con socios
INSERT INTO [dbo].[caipi_PartnerDeals] ([institucioneId], [sealDate], [isActive], [dealDescription])
VALUES 
    (1, GETDATE(), 1, 'Acuerdo de prueba');

-- Insertar planes
INSERT INTO [dbo].[caipi_plans] ([name], [description], [periodStart], [periodEnd], [enabled], [imgURL])
VALUES 
    ('Plan Básico', 'Plan inicial para pruebas', '2023-01-01', '2023-12-31', 1, NULL),
    ('Plan Intermedio', 'Plan de nivel medio', '2023-01-01', '2023-12-31', 1, NULL);

-- Insertar precios de planes
INSERT INTO [dbo].[caipi_planPrices] ([amount], [postTime], [endDate], [recurrencyType], [current], [planId])
VALUES 
    (50.00, GETDATE(), NULL, 1, 1, 1),
    (75.00, GETDATE(), NULL, 1, 1, 2);

-- Insertar planes por usuario
INSERT INTO [dbo].[caipi_planPerUser] ([adquisitionDate], [expirationDate], [enabled], [planId], [userId])
VALUES 
    ('2023-01-01', '2023-12-31', 1, 1, 1),
    ('2023-01-01', '2023-12-31', 1, 2, 2);

-- Insertar límites de planes
INSERT INTO [dbo].[caipi_PlanLimits] ([planLimitId], [limit_people], [limit], [featureId], [planPerUserId], [description])
VALUES 
    (1, 3, 500, 1, 1, 'Límite plan básico'),
    (2, 5, 1000, 2, 2, 'Límite plan intermedio');

-- Insertar features por plan
INSERT INTO [dbo].[caipi_featuresPerPlan] ([enabled], [featureId], [planId])
VALUES 
    (1, 1, 1),
    (1, 2, 2);


/*
select * into caipi_Temp from caipi_featurePrice;
delete from caipi_featurePrice;
DBCC CHECKIDENT ('caipi_mediosDisponibles', reseed, 0);
insert into caipi_featurePrice (featurePriceTypeId, originalPrice, discountValue, solturaPercent, userPrice, userPriceivi, partnerDealId) select featurePriceTypeId, originalPrice, discountValue, solturaPercent, userPrice, userPriceivi, partnerDealId from caipi_Temp order by featurePriceId asc;
drop table caipi_Temp;
select * from caipi_featurePrice;

update caipi_featureName
set name = 'Amount weekend rate (Purchase value greater than 2,000 CRC)'
where featureNameId = 18;
select * from caipi_featureName;
*/