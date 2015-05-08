-- Funciones Auxiliares

CREATE FUNCTION VotosPorListaPorEleccion()
RETURNS TABLE AS RETURN(
	SELECT e.IdEleccion, s.NumeroLista, sum(s.CantidadVotos) AS TotalVotos
	FROM Eleccion e 
	INNER JOIN SeVotaLista s ON e.IdEleccion = s.IdEleccion	
	GROUP BY e.IdEleccion, s.NumeroLista)
GO

CREATE FUNCTION VotosPorPartidoPorEleccion()
RETURNS TABLE AS RETURN(
	SELECT v.IdEleccion, l.IdPartido, sum(v.TotalVotos) AS TotalVotos
	FROM VotosPorListaPorEleccion() v
	INNER JOIN Lista l ON l.IdEleccion = v.IdEleccion AND l.Numero = v.NumeroLista
	GROUP BY v.IdEleccion, l.IdPartido)
GO

CREATE FUNCTION VotosPorOpcionPorEleccion()
RETURNS TABLE AS RETURN(
	SELECT e.IdEleccion, s.NombreOpcion, sum(s.CantidadVotos) AS TotalVotos
	FROM Eleccion e 
	INNER JOIN SeVotaOpcion s ON e.IdEleccion = s.IdEleccion
	GROUP BY e.IdEleccion, s.NombreOpcion)
GO

CREATE FUNCTION VotosPorListaPorEleccionDelAño()
RETURNS TABLE AS RETURN(
	SELECT v.IdEleccion, v.NumeroLista, v.TotalVotos
	FROM VotosPorListaPorEleccion() v
	INNER JOIN Eleccion e ON e.IdEleccion = v.IdEleccion
	WHERE YEAR(e.Fecha) = YEAR(GETDATE()))
GO

CREATE FUNCTION VotosPorOpcionPorEleccionDelAño()
RETURNS TABLE AS RETURN(
	SELECT v.IdEleccion, v.NombreOpcion, v.TotalVotos
	FROM VotosPorOpcionPorEleccion() v
	INNER JOIN Eleccion e ON e.IdEleccion = v.IdEleccion
	WHERE YEAR(e.Fecha) = YEAR(GETDATE()))
GO

CREATE FUNCTION VeintePorCientoDeVotosPorEleccion()
RETURNS TABLE AS RETURN(
	SELECT m.IdEleccion, (COUNT(*)*0.2) AS VeintePorCientoDeVotos
	FROM Mesa m 
	INNER JOIN Vota v ON m.IdEleccion = v.IdEleccion AND m.Numero = v.NumeroMesa
	WHERE v.Voto = 1
	GROUP BY m.IdEleccion
)
GO