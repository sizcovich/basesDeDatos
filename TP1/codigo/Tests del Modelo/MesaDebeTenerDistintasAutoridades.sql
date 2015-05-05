-- Estos no funcionan
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 1, 36827289, 1, 36827289, 1, 34445438)
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 1, 36827289, 1, 34445438, 1, 36827289)
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 1, 34445438, 1, 36827289, 1, 36827289)

-- Este si
INSERT INTO Mesa VALUES((SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015'), 1, 1, 93696263, 1, 34445438, 1, 36088188)

--borrado de fila insertada
DELETE FROM Mesa WHERE IdEleccion = (SELECT TOP 1 [IdEleccion] FROM [Eleccion] WHERE [Fecha] = '05/05/2015') AND Numero = 1