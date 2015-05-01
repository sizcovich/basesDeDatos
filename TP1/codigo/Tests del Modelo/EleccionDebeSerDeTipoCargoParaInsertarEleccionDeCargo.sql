INSERT INTO Eleccion VALUES(NEWID(), 'Cargo', '01/05/2015', '08:00', '18:00')
INSERT INTO Eleccion VALUES(NEWID(), 'Cargo', '02/05/2015', '08:00', '18:00')
-- Este funciona
INSERT INTO EleccionDeCargo VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '01/05/2015'), 'Jefe de Gobierno de la Ciudad de Buenos Aires')
-- Este no
INSERT INTO ConsultaPopular VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '02/05/2015'), 'Construccion de Estacion de Tren en Ciudad Universitaria')