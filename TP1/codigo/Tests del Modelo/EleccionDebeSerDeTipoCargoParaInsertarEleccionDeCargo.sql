-- Este funciona
INSERT INTO EleccionDeCargo VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '01/05/2015'), 'Jefe de Gobierno de la Ciudad de Buenos Aires')
-- Este no
INSERT INTO ConsultaPopular VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '02/05/2015'), 'Construccion de Estacion de Tren en Ciudad Universitaria')

--borrado de fila insertada
DELETE FROM EleccionDeCargo WHERE IdEleccion = (SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '01/05/2015')