--t1: votos por centro por eleccion ordenados por IdEleccion, IdCentro y Hora

(SELECT v.IdEleccion, v.IdCentro, v.TipoDocumento, v.NumeroDocumento, v.Hora
FROM Vota v INNNER JOIN Mesa m ON v.numeroMesa = m.Numero AND v.IdEleccion = m.IdEleccion
WHERE v.Voto = 1
ORDER BY v.IdEleccion, m.IdCentro, v.Hora DESC) t1

