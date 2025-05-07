use caipiDB;


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
