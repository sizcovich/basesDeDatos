INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 1, 93696263, 1, 34445438, 1, 36088188)

-- Estos no funcionan
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 2, 1, 36088188, 1, 36827289, 1, 35962842)
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 2, 1, 36827289, 1, 36088188, 1, 35962842)
INSERT INTO EsFiscalDe VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 1, 36088188, (SELECT TOP 1 IdPartido FROM Partido WHERE Nombre = 'Partido Pobrero'))
INSERT INTO Conduce VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 36088188, 'ABC-123')

--borrado de fila insertada
DELETE FROM Mesa WHERE IdEleccion = (SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015') AND Numero = 1