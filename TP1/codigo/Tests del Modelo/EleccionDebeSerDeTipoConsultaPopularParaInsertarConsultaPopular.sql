-- Este funciona
INSERT INTO ConsultaPopular VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '03/05/2015'), 'Construccion de Estacion de Tren en Ciudad Universitaria')
-- Este no
INSERT INTO EleccionDeCargo VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '04/05/2015'), 'Jefe de Gobierno de la Ciudad de Buenos Aires')

