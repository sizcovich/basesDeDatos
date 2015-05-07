BEGIN TRANSACTION
--Eleccion de cargo 01: Lista 1 6000 votos, Lista 2 3000 votos
--Eleccion de cargo 03: Lista 1 5000 votos, Lista 2 6000 votos
INSERT INTO Ciudadano VALUES(1, 36827289, 'Federico')
INSERT INTO Ciudadano VALUES(1, 34445438, 'Santiago')
INSERT INTO Ciudadano VALUES(1, 36088188, 'German')
INSERT INTO Ciudadano VALUES(1, 93696263, 'Sabrina')
INSERT INTO Ciudadano VALUES(1, 35962842, 'Agustina')
INSERT INTO Ciudadano VALUES(1, 35962843, 'Romina')
INSERT INTO Ciudadano VALUES(1, 35962844, 'Marcelo')
INSERT INTO Ciudadano VALUES(1, 32637028, 'Juan')
INSERT INTO Ciudadano VALUES(1, 35685912, 'Pedro')
INSERT INTO Ciudadano VALUES(1, 31294576, 'Luis')
INSERT INTO Ciudadano VALUES(1, 38137462, 'Carolina')
INSERT INTO Ciudadano VALUES(1, 30285635, 'Sofia')
INSERT INTO Ciudadano VALUES(1, 37284867, 'Mercedes')

INSERT INTO	Centro VALUES ('00000000-0000-0000-0000-000000000001', 'Int. Guiraldes 2300')
INSERT INTO Centro VALUES('00000000-0000-0000-0000-000000000002', 'Av. Cabildo 1520')
INSERT INTO Centro VALUES('00000000-0000-0000-0000-000000000003', 'Av. C�rdoba 300')

INSERT INTO Camioneta VALUES('ABC-123')
INSERT INTO Camioneta VALUES('FFF-365')

INSERT INTO Partido VALUES('00000000-0000-0000-0000-000000000001', 'Partido Pobrero')
INSERT INTO Partido VALUES('00000000-0000-0000-0000-000000000002', 'ProK')

INSERT INTO Eleccion VALUES('00000000-0000-0000-0000-000000000001', 'Cargo', '01/05/2015', '08:00', '18:00')
INSERT INTO Eleccion VALUES('00000000-0000-0000-0000-000000000002', 'Cargo', '02/05/2015', '08:00', '18:00')
INSERT INTO Eleccion VALUES('00000000-0000-0000-0000-000000000003', 'Cargo', '03/05/2015', '08:00', '18:00')
INSERT INTO Eleccion VALUES('00000000-0000-0000-0000-000000000004', 'ConsultaPopular', '04/05/2015', '08:00', '18:00')
INSERT INTO Eleccion VALUES('00000000-0000-0000-0000-000000000005', 'Cargo', '05/05/2015', '08:00', '18:00')

INSERT INTO Conduce VALUES('00000000-0000-0000-0000-000000000001', 1, 31294576, 'ABC-123')
INSERT INTO EsFiscalDe VALUES('00000000-0000-0000-0000-000000000001', 1, 1, 35685912, (SELECT TOP 1 IdPartido FROM Partido WHERE Nombre = 'Partido Pobrero'))
--Data para query 1

INSERT INTO EleccionDeCargo VALUES ('00000000-0000-0000-0000-000000000001', 'Gobernador')
INSERT INTO Lista VALUES('00000000-0000-0000-0000-000000000001', 1, '00000000-0000-0000-0000-000000000001')
INSERT INTO Lista VALUES('00000000-0000-0000-0000-000000000001', 2, '00000000-0000-0000-0000-000000000002')
INSERT INTO Mesa VALUES ('00000000-0000-0000-0000-000000000001', 1, '00000000-0000-0000-0000-000000000001', 1, 36827289, 1, 34445438, 1, 36088188)
INSERT INTO Ciudadano VALUES (1, 17795560, 'Gerardo')
INSERT INTO Mesa VALUES ('00000000-0000-0000-0000-000000000001', 2, '00000000-0000-0000-0000-000000000001', 1, 93696263, 1, 35962842, 1, 17795560)
INSERT INTO SeVotaLista VALUES ('00000000-0000-0000-0000-000000000001', 1, 1, 2000)
INSERT INTO SeVotaLista VALUES ('00000000-0000-0000-0000-000000000001', 1, 2, 1000)
INSERT INTO SeVotaLista VALUES ('00000000-0000-0000-0000-000000000001', 2, 1, 4000)
INSERT INTO SeVotaLista VALUES ('00000000-0000-0000-0000-000000000001', 2, 2, 2000)

INSERT INTO EleccionDeCargo VALUES ('00000000-0000-0000-0000-000000000003', 'Presidente')
INSERT INTO Lista VALUES('00000000-0000-0000-0000-000000000003', 1, '00000000-0000-0000-0000-000000000001')
INSERT INTO Lista VALUES('00000000-0000-0000-0000-000000000003', 2, '00000000-0000-0000-0000-000000000002')
INSERT INTO Mesa VALUES ('00000000-0000-0000-0000-000000000003', 1, '00000000-0000-0000-0000-000000000001', 1, 36827289, 1, 34445438, 1, 36088188)
INSERT INTO Mesa VALUES ('00000000-0000-0000-0000-000000000003', 2, '00000000-0000-0000-0000-000000000001', 1, 93696263, 1, 35962842, 1, 17795560)
INSERT INTO SeVotaLista VALUES ('00000000-0000-0000-0000-000000000003', 1, 1, 2000)
INSERT INTO SeVotaLista VALUES ('00000000-0000-0000-0000-000000000003', 1, 2, 3000)
INSERT INTO SeVotaLista VALUES ('00000000-0000-0000-0000-000000000003', 2, 1, 3000)
INSERT INTO SeVotaLista VALUES ('00000000-0000-0000-0000-000000000003', 2, 2, 3000)

--Data para query 2

INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000001', 1, 1, 36827289, 1, '08:30')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000001', 1, 1, 36088188, 1, '12:00')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000001', 1, 1, 34445438, 1, '17:00')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000001', 2, 1, 93696263, 1, '17:20')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000001', 2, 1, 35962842, 1, '17:30')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000001', 2, 1, 35962843, 1, '17:40')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000001', 2, 1, 35962844, 1, '17:45')

INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000003', 1, 1, 36827289, 1, '08:30')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000003', 1, 1, 36088188, 1, '12:00')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000003', 1, 1, 34445438, 1, '17:00')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000003', 2, 1, 93696263, 1, '17:10')
INSERT INTO Vota VALUES ('00000000-0000-0000-0000-000000000003', 2, 1, 35962842, 1, '17:30')

COMMIT TRANSACTION
