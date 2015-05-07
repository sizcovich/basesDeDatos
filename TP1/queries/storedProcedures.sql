CREATE PROCEDURE GanadoresCargoUltimoAño
AS 
	SELECT todos.IdEleccion, todos.NumeroLista, todos.TotalVotos FROM 
	VotosPorListaPorEleccionDelAño() todos
	INNER JOIN 
	(SELECT IdEleccion, max(TotalVotos) AS VotosGanador
	FROM
	VotosPorListaPorEleccionDelAño() GROUP BY IdEleccion) ganador
	ON todos.IdEleccion = ganador.IdEleccion AND todos.TotalVotos = ganador.VotosGanador;
GO

CREATE PROCEDURE GanadoresOpcionUltimoAño
AS 
	SELECT todos.IdEleccion, todos.NombreOpcion, todos.TotalVotos FROM 
	VotosPorOpcionPorEleccionDelAño() todos
	INNER JOIN 
	(SELECT IdEleccion, max(TotalVotos) AS VotosGanador
	FROM
	VotosPorOpcionPorEleccionDelAño() GROUP BY IdEleccion) ganador
	ON todos.IdEleccion = ganador.IdEleccion AND todos.TotalVotos = ganador.VotosGanador;
GO

CREATE PROCEDURE UltimosCincoEnVotarPorCentro
AS 
	SELECT IdEleccion, IdCentro, TipoDocumento, NumeroDocumento, Hora
	FROM 
	(SELECT v.IdEleccion, m.IdCentro, v.TipoDocumento, v.NumeroDocumento, v.Hora, RANK() OVER(PARTITION BY m.IdEleccion, m.IdCentro ORDER BY m.IdEleccion, m.IdCentro, v.Hora DESC) as Orden
	FROM Vota v INNER JOIN Mesa m ON v.numeroMesa = m.Numero AND v.IdEleccion = m.IdEleccion
	WHERE v.Voto = 1
	) t1
	WHERE Orden <= 5;
GO

CREATE PROCEDURE PartidosConMasDel20EnLasUltimas5ParaGobernador
AS 
	SELECT DISTINCT v.IdEleccion, p.Nombre  FROM
	(SELECT s.IdEleccion, s.NumeroLista, sum(s.CantidadVotos) AS Votos
	FROM SeVotaLista s
	GROUP BY s.IdEleccion, s.NumeroLista) v
	INNER JOIN Lista l ON v.NumeroLista = l.Numero
	INNER JOIN Partido p ON l.IdPartido = p.IdPartido
	INNER JOIN VeintePorCientoDeVotosPorEleccion() vp ON vp.IdEleccion = v.IdEleccion
	WHERE  v.Votos > vp.VeintePorCientoDeVotos;
GO
