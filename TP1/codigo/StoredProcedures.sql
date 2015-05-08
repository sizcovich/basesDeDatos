CREATE PROCEDURE GanadoresCargoUltimoAño
AS 
	SELECT todos.IdEleccion, todos.NumeroLista, todos.TotalVotos 
	FROM VotosPorListaPorEleccionDelAño() todos
	INNER JOIN
	(SELECT IdEleccion, max(TotalVotos) AS VotosGanador
	FROM VotosPorListaPorEleccionDelAño() 
	GROUP BY IdEleccion) ganador
	ON todos.IdEleccion = ganador.IdEleccion AND todos.TotalVotos = ganador.VotosGanador;
GO

CREATE PROCEDURE GanadoresOpcionUltimoAño
AS 
	SELECT todos.IdEleccion, todos.NombreOpcion, todos.TotalVotos 
	FROM VotosPorOpcionPorEleccionDelAño() todos
	INNER JOIN 
	(SELECT IdEleccion, max(TotalVotos) AS VotosGanador
	FROM VotosPorOpcionPorEleccionDelAño()
	GROUP BY IdEleccion) ganador
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
	SELECT TOP 5 e.IdEleccion, p.Nombre, v.TotalVotos
	FROM 
	(SELECT TOP 5 e.IdEleccion, e.Tipo, e.Fecha
	 FROM EleccionDeCargo ec
	 INNER JOIN Eleccion e ON e.IdEleccion = ec.IdEleccion
	 WHERE ec.Cargo = 'Gobernador'
	 ORDER BY Fecha DESC) e
	INNER JOIN VotosPorPartidoPorEleccion() v ON v.IdEleccion = e.IdEleccion
	INNER JOIN VeintePorCientoDeVotosPorEleccion() vp ON vp.IdEleccion = e.IdEleccion
	INNER JOIN Partido p ON p.IdPartido = v.IdPartido
	WHERE  v.TotalVotos > vp.VeintePorCientoDeVotos;
GO