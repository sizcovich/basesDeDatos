INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '06/05/2015'), 1, 1, 93696263, 1, 34445438, 1, 36088188)

-- Estos no funcionan
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '06/05/2015'), 2, 1, 93696263, 1, 36827289, 1, 36088188)
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '06/05/2015'), 2, 1, 36827289, 1, 93696263, 1, 36088188)
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '06/05/2015'), 2, 1, 36827289, 1, 35962842, 1, 93696263)
INSERT INTO EsFiscalDe VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '06/05/2015'), 1, 1, 93696263, (SELECT TOP 1 IdPartido FROM Partido WHERE Nombre = 'Partido Pobrero'))
INSERT INTO Conduce VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '06/05/2015'), 1, 93696263, (SELECT TOP 1 IdPartido FROM Partido WHERE Nombre = 'Partido Pobrero'))