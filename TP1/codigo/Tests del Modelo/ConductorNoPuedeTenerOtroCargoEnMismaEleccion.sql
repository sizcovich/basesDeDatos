INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 1, 93696263, 1, 34445438, 1, 36088188)
INSERT INTO Conduce VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 36827289, 'ABC-123')

-- Estos no funcionan
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 2, 1, 36827289, 1, 35962842, 1, 32637028)
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 2, 1, 35962842, 1, 36827289, 1, 32637028)
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 2, 1, 35962842, 1, 32637028, 1, 36827289)
INSERT INTO EsFiscalDe VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 1, 36827289, (SELECT TOP 1 IdPartido FROM Partido WHERE Nombre = 'Partido Pobrero'))

--borrado de filas insertadas
DELETE FROM Mesa WHERE IdEleccion = (SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015') AND Numero = 1
DELETE FROM Conduce WHERE IdEleccion = (SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015') AND NumeroDocumento = 36827289