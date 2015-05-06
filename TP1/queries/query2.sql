--t1: votos por centro por eleccion ordenados por IdEleccion, IdCentro y Hora


SELECT IdEleccion, IdCentro, TipoDocumento, NumeroDocumento, Hora
FROM 
(SELECT v.IdEleccion, m.IdCentro, v.TipoDocumento, v.NumeroDocumento, v.Hora, RANK() OVER(PARTITION BY m.IdEleccion, m.IdCentro ORDER BY m.IdEleccion, m.IdCentro, v.Hora DESC) as Orden
FROM Vota v INNER JOIN Mesa m ON v.numeroMesa = m.Numero AND v.IdEleccion = m.IdEleccion
WHERE v.Voto = 1
) t1
WHERE Orden <= 5

