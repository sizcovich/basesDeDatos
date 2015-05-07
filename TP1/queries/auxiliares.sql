-- Funciones Auxiliares

CREATE FUNCTION VotosPorListaPorEleccionDelAño()
RETURNS TABLE AS RETURN(
	SELECT e.IdEleccion, s.NumeroLista, sum(s.CantidadVotos) AS TotalVotos
	FROM Eleccion e INNER JOIN SeVotaLista s ON e.IdEleccion = s.IdEleccion
	WHERE YEAR(e.Fecha) = YEAR(GETDATE())
	GROUP BY  e.IdEleccion, s.NumeroLista)
GO

CREATE FUNCTION VotosPorOpcionPorEleccionDelAño()
RETURNS TABLE AS RETURN(
	SELECT e.IdEleccion, s.NombreOpcion, sum(s.CantidadVotos) AS TotalVotos
	FROM Eleccion e INNER JOIN SeVotaOpcion s ON e.IdEleccion = s.IdEleccion
	WHERE YEAR(e.Fecha) = YEAR(GETDATE())
	GROUP BY  e.IdEleccion, s.NombreOpcion)
GO

CREATE FUNCTION VeintePorCientoDeVotosPorEleccion()
RETURNS TABLE AS RETURN(
	SELECT m.IdEleccion, (COUNT(*)*0.2) AS VeintePorCientoDeVotos
	FROM Mesa m 
	INNER JOIN 
	Vota v ON m.IdEleccion = v.IdEleccion AND m.Numero = v.NumeroMesa
	WHERE v.Voto = 1
	GROUP BY m.IdEleccion
)
GO
