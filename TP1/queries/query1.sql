--t1: [idElecc, numLista, cantVotos] por cada mesa en elecciones de 2015
--t2: [idElecc, numLIsta, totalVotos] votos acumulados en cada eleccion

--Query para Listas

SELECT t2.IdEleccion, t2.NumeroLista,  max(t2.TotalVotos) AS TotalVotos
FROM

(SELECT t1.IdEleccion, t1.NumeroLista, sum(t1.CantidadVotos) AS TotalVotos
FROM

(SELECT e.IdEleccion, NumeroLista, CantidadVotos
FROM Eleccion e INNER JOIN SeVotaLista s ON E.IdEleccion = S.IdEleccion
WHERE YEAR(e.Fecha) = YEAR(GETDATE())) t1

GROUP BY t1.IdEleccion, t1.NumeroLista) t2

GROUP BY t2.IdEleccion


--Query para Opciones

--t1: [idElecc, numLista, cantVotos] por cada mesa en elecciones de 2015
--t2: [idElecc, numLIsta, totalVotos] votos acumulados en cada eleccion

SELECT t2.IdEleccion, t2.NombreOpcion,  max(t2.TotalVotos) AS TotalVotos
FROM

(SELECT t1.IdEleccion, t1.NombreOpcion, sum(t1.CantidadVotos) AS TotalVotos
FROM

(SELECT e.IdEleccion, NombreOpcion, CantidadVotos
FROM Eleccion e INNER JOIN SeVotaOpcion s ON E.IdEleccion = S.IdEleccion
WHERE YEAR(e.Fecha) = YEAR(GETDATE())) t1

GROUP BY t1.IdEleccion, t1.NumeroLista) t2

GROUP BY t2.IdEleccion
