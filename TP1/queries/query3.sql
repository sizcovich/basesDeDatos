

SELECT IdEleccion, (COUNT(*)*0,2) AS Piso
FROM Mesa m INNER JOIN Vota v ON m.IdEleccion = v.IdEleccion AND m.Numero = v.NumeroMesa
GROUP BY IdEleccion
WHERE v.Voto = True
AS 20PorCientoTotalPorElec

SELECT s.IdEleccion, l.Numero, l.Partido
FROM SeVotaLista s, Lista l
WHERE s.IdEleccion = l.IdEleccion AND l.Numero = s.NumeroLista
AS PartidoDeLista

SELECT v.IdEleccion, p.IdPartido, sum(Votos) AS Total
FROM PartidoDeLista p INNER JOIN
(SELECT IdEleccion, NumLista, sum(CantVotos) AS Votos
FROM SeVotaLista
GROUP BY IdEleccion, NumLista) v
GROUP BY v.IdEleccion, p.IdPartido
AS VotosPorPartido

SELECT v.IdEleccion, v.IdPartido
FROM VotosPorPartido v INNER JOIN 20PorCientoTotalPorElec t
WHERE v.Total > t.Piso
AS PartidosConMasDel20
