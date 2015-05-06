SELECT DISTINCT v.IdEleccion, p.Nombre  FROM
(SELECT s.IdEleccion, s.NumeroLista, sum(s.CantidadVotos) AS Votos
FROM SeVotaLista s
GROUP BY s.IdEleccion, s.NumeroLista) v
INNER JOIN Lista l ON v.NumeroLista = l.Numero
INNER JOIN Partido p ON l.IdPartido = p.IdPartido
INNER JOIN VeintePorCientoDeVotosPorEleccion() vp ON vp.IdEleccion = v.IdEleccion
WHERE  v.Votos > vp.VeintePorCientoDeVotos

--Funciones auxiliares
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

