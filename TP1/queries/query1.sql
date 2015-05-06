--t1: [idElecc, numLista, cantVotos] por cada mesa en elecciones de 2015
--t2: [idElecc, numLIsta, totalVotos] votos acumulados en cada eleccion

--Query para Listas


SELECT todos.IdEleccion, todos.NumeroLista, todos.TotalVotos FROM 
VotosPorListaPorEleccionDelAño() todos
INNER JOIN 
(SELECT IdEleccion, max(TotalVotos) AS VotosGanador
FROM
VotosPorListaPorEleccionDelAño() GROUP BY IdEleccion) ganador
ON todos.IdEleccion = ganador.IdEleccion AND todos.TotalVotos = ganador.VotosGanador




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


-- Funciones Auxiliares

CREATE FUNCTION VotosPorListaPorEleccionDelAño()
RETURNS TABLE AS RETURN(
	SELECT e.IdEleccion, s.NumeroLista, sum(s.CantidadVotos) AS TotalVotos
	FROM Eleccion e INNER JOIN SeVotaLista s ON e.IdEleccion = s.IdEleccion
	WHERE YEAR(e.Fecha) = YEAR(GETDATE())
	GROUP BY  e.IdEleccion, s.NumeroLista)
GO