-- Eleccion
CREATE TABLE [dbo].[Eleccion](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[Tipo] [nvarchar](max) NOT NULL,
	[Fecha] [date] NOT NULL,
	[HoraDesde] [time](7) NOT NULL,
	[HoraHasta] [time](7) NOT NULL,
	CONSTRAINT [PK_Eleccion] PRIMARY KEY CLUSTERED ([IdEleccion]),
	CONSTRAINT [Eleccion_TIPO] CHECK (Tipo = 'Cargo' OR Tipo = 'ConsultaPopular')
)
GO

-- Ciudadano
CREATE TABLE [dbo].[Ciudadano](
	[TipoDocumento] [smallint] NOT NULL,
	[NumeroDocumento] [int] NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,	
	CONSTRAINT [PK_Ciudadano] PRIMARY KEY CLUSTERED ([TipoDocumento], [NumeroDocumento])
)
GO

-- EleccionDeCargo
CREATE TABLE [dbo].[EleccionDeCargo](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[Cargo] [nvarchar](max) NOT NULL,
	CONSTRAINT [PK_EleccionDeCargo] PRIMARY KEY CLUSTERED ([IdEleccion]),
	CONSTRAINT [FK_EleccionDeCargo_Eleccion] FOREIGN KEY([IdEleccion]) REFERENCES [dbo].[Eleccion] ([IdEleccion])
)
GO

-- ConsultaPopular
CREATE TABLE [dbo].[ConsultaPopular](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[Consulta] [nvarchar](max) NOT NULL,
	CONSTRAINT [PK_ConsultaPopular] PRIMARY KEY CLUSTERED ([IdEleccion]),
	CONSTRAINT [FK_ConsultaPopular_Eleccion] FOREIGN KEY([IdEleccion]) REFERENCES [dbo].[Eleccion] ([IdEleccion])
)
GO

-- Partido
CREATE TABLE [dbo].[Partido](
	[IdPartido] [uniqueidentifier] NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,	
	CONSTRAINT [PK_Partido] PRIMARY KEY CLUSTERED ([IdPartido])
)
GO

-- Lista
CREATE TABLE [dbo].[Lista](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[Numero] [int] NOT NULL,
	[IdPartido] [uniqueidentifier] NOT NULL,
	CONSTRAINT [PK_Lista] PRIMARY KEY CLUSTERED ([IdEleccion], [Numero]),
	CONSTRAINT [FK_Lista_EleccionDeCargo] FOREIGN KEY([IdEleccion]) REFERENCES [dbo].[EleccionDeCargo] ([IdEleccion])	
)

ALTER TABLE [dbo].[Lista]  WITH CHECK ADD CONSTRAINT [FK_Lista_Partido] FOREIGN KEY([IdPartido])
REFERENCES [dbo].[Partido] ([IdPartido])
GO

-- Opcion
CREATE TABLE [dbo].[Opcion](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[Nombre] [nvarchar](250) NOT NULL,
	CONSTRAINT [PK_Opcion] PRIMARY KEY CLUSTERED ([IdEleccion], [Nombre])
)

ALTER TABLE [dbo].[Opcion]  WITH CHECK ADD CONSTRAINT [FK_Opcion_ConsultaPopular] FOREIGN KEY([IdEleccion])
REFERENCES [dbo].[ConsultaPopular] ([IdEleccion])
GO

-- Centro
CREATE TABLE [dbo].[Centro](
	[IdCentro] [uniqueidentifier] NOT NULL,
	[Direccion] [nvarchar](max) NOT NULL,	
	CONSTRAINT [PK_Centro] PRIMARY KEY CLUSTERED ([IdCentro])
)
GO

-- Mesa
CREATE TABLE [dbo].[Mesa](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[Numero] [int] NOT NULL,
	[IdCentro] [uniqueidentifier] NOT NULL,
	[TipoDocumentoPresidente] [smallint] NOT NULL,
	[NumeroDocumentoPresidente] [int] NOT NULL,	
	[TipoDocumentoVicepresidente] [smallint] NOT NULL,
	[NumeroDocumentoVicepresidente] [int] NOT NULL,	
	[TipoDocumentoTecnico] [smallint] NOT NULL,
	[NumeroDocumentoTecnico] [int] NOT NULL,	
	CONSTRAINT [PK_Mesa] PRIMARY KEY CLUSTERED ([IdEleccion], [Numero]),
	CONSTRAINT [Mesa_PresidenteDistintoDeVicepresidente] CHECK ([TipoDocumentoPresidente] != [TipoDocumentoVicepresidente] OR [NumeroDocumentoPresidente] != [NumeroDocumentoVicepresidente]),
	CONSTRAINT [Mesa_PresidenteDistintoDeTecnico] CHECK ([TipoDocumentoPresidente] != [TipoDocumentoTecnico] OR [NumeroDocumentoPresidente] != [NumeroDocumentoTecnico]),
	CONSTRAINT [Mesa_VicepresidenteDistintoDeTecnico] CHECK ([TipoDocumentoVicepresidente] != [TipoDocumentoTecnico] OR [NumeroDocumentoVicepresidente] != [NumeroDocumentoTecnico])
)

ALTER TABLE [dbo].[Mesa]  WITH CHECK ADD CONSTRAINT [FK_Mesa_Eleccion] FOREIGN KEY([IdEleccion])
REFERENCES [dbo].[Eleccion] ([IdEleccion])

ALTER TABLE [dbo].[Mesa]  WITH CHECK ADD CONSTRAINT [FK_Mesa_Centro] FOREIGN KEY([IdCentro])
REFERENCES [dbo].[Centro] ([IdCentro])

ALTER TABLE [dbo].[Mesa] WITH CHECK ADD CONSTRAINT [FK_Mesa_Presidente] FOREIGN KEY([TipoDocumentoPresidente], [NumeroDocumentoPresidente])
REFERENCES [dbo].[Ciudadano] ([TipoDocumento], [NumeroDocumento])

ALTER TABLE [dbo].[Mesa] WITH CHECK ADD CONSTRAINT [FK_Mesa_Vicepresidente] FOREIGN KEY([TipoDocumentoVicepresidente], [NumeroDocumentoVicepresidente])
REFERENCES [dbo].[Ciudadano] ([TipoDocumento], [NumeroDocumento])

ALTER TABLE [dbo].[Mesa] WITH CHECK ADD CONSTRAINT [FK_Mesa_Tecnico] FOREIGN KEY([TipoDocumentoTecnico], [NumeroDocumentoTecnico])
REFERENCES [dbo].[Ciudadano] ([TipoDocumento], [NumeroDocumento])
GO

-- SeVotaLista
CREATE TABLE [dbo].[SeVotaLista](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[NumeroMesa] [int] NOT NULL,
	[NumeroLista] [int] NOT NULL,
	[CantidadVotos] [int] NOT NULL,
	CONSTRAINT [PK_SeVotaLista] PRIMARY KEY CLUSTERED ([IdEleccion], [NumeroMesa], [NumeroLista]),
	CONSTRAINT [SeVotaLista_VotosNoNegativos] CHECK ([CantidadVotos] >= 0)
)

ALTER TABLE [dbo].[SeVotaLista]  WITH CHECK ADD CONSTRAINT [FK_SeVotaLista_Mesa] FOREIGN KEY([IdEleccion], [NumeroMesa])
REFERENCES [dbo].[Mesa] ([IdEleccion], [Numero])

ALTER TABLE [dbo].[SeVotaLista]  WITH CHECK ADD CONSTRAINT [FK_SeVotaLista_Lista] FOREIGN KEY([IdEleccion], [NumeroLista])
REFERENCES [dbo].[Lista] ([IdEleccion], [Numero])
GO

-- SeVotaOpcion
CREATE TABLE [dbo].[SeVotaOpcion](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[NumeroMesa] [int] NOT NULL,
	[NombreOpcion] [nvarchar](250) NOT NULL,
	[CantidadVotos] [int] NOT NULL,
	CONSTRAINT [PK_SeVotaOpcion] PRIMARY KEY CLUSTERED ([IdEleccion], [NumeroMesa], [NombreOpcion]),
	CONSTRAINT [SeVotaOpcion_VotosNoNegativos] CHECK ([CantidadVotos] >= 0)
)

ALTER TABLE [dbo].[SeVotaOpcion]  WITH CHECK ADD CONSTRAINT [FK_SeVotaOpcion_Mesa] FOREIGN KEY([IdEleccion], [NumeroMesa])
REFERENCES [dbo].[Mesa] ([IdEleccion], [Numero])

ALTER TABLE [dbo].[SeVotaOpcion]  WITH CHECK ADD CONSTRAINT [FK_SeVotaOpcion_Opcion] FOREIGN KEY([IdEleccion], [NombreOpcion])
REFERENCES [dbo].[Opcion] ([IdEleccion], [Nombre])
GO

-- Camioneta
CREATE TABLE [dbo].[Camioneta](	
	[Patente] [nvarchar](10) NOT NULL,	
	CONSTRAINT [PK_Camioneta] PRIMARY KEY CLUSTERED ([Patente])
)
GO

-- Asignada
CREATE TABLE [dbo].[Asignada](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[IdCentro] [uniqueidentifier] NOT NULL,
	[Patente] [nvarchar](10) NOT NULL,	
	CONSTRAINT [PK_Asignada] PRIMARY KEY CLUSTERED ([IdEleccion], [IdCentro])
)

ALTER TABLE [dbo].[Asignada]  WITH CHECK ADD CONSTRAINT [FK_Asignada_Eleccion] FOREIGN KEY([IdEleccion])
REFERENCES [dbo].[Eleccion] ([IdEleccion])

ALTER TABLE [dbo].[Asignada]  WITH CHECK ADD CONSTRAINT [FK_Asignada_Centro] FOREIGN KEY([IdCentro])
REFERENCES [dbo].[Centro] ([IdCentro])

ALTER TABLE [dbo].[Asignada]  WITH CHECK ADD CONSTRAINT [FK_Asignada_Camioneta] FOREIGN KEY([Patente])
REFERENCES [dbo].[Camioneta] ([Patente])
GO

-- Conduce
CREATE TABLE [dbo].[Conduce](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[TipoDocumento] [smallint] NOT NULL,
	[NumeroDocumento] [int] NOT NULL,	
	[Patente] [nvarchar](10) NOT NULL,	
	CONSTRAINT [PK_Conduce] PRIMARY KEY CLUSTERED ([IdEleccion], [TipoDocumento], [NumeroDocumento])
)

ALTER TABLE [dbo].[Conduce]  WITH CHECK ADD CONSTRAINT [FK_Conduce_Eleccion] FOREIGN KEY([IdEleccion])
REFERENCES [dbo].[Eleccion] ([IdEleccion])

ALTER TABLE [dbo].[Conduce] WITH CHECK ADD CONSTRAINT [FK_Conduce_Ciudadano] FOREIGN KEY([TipoDocumento], [NumeroDocumento])
REFERENCES [dbo].[Ciudadano] ([TipoDocumento], [NumeroDocumento])

ALTER TABLE [dbo].[Conduce]  WITH CHECK ADD CONSTRAINT [FK_Conduce_Camioneta] FOREIGN KEY([Patente])
REFERENCES [dbo].[Camioneta] ([Patente])
GO

-- EsCandidatoEn
CREATE TABLE [dbo].[EsCandidatoEn](
	[TipoDocumento] [smallint] NOT NULL,
	[NumeroDocumento] [int] NOT NULL,
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[NumeroLista] [int] NOT NULL,
	CONSTRAINT [PK_EsCandidatoEn] PRIMARY KEY CLUSTERED ([TipoDocumento], [NumeroDocumento], [IdEleccion], [NumeroLista])
)

ALTER TABLE [dbo].[EsCandidatoEn] WITH CHECK ADD CONSTRAINT [FK_EsCandidatoEn_Ciudadano] FOREIGN KEY([TipoDocumento], [NumeroDocumento])
REFERENCES [dbo].[Ciudadano] ([TipoDocumento], [NumeroDocumento])

ALTER TABLE [dbo].[EsCandidatoEn] WITH CHECK ADD CONSTRAINT [FK_EsCandidatoEn_Lista] FOREIGN KEY([IdEleccion], [NumeroLista])
REFERENCES [dbo].[Lista] ([IdEleccion], [Numero])
GO

-- EsFiscalDe
CREATE TABLE [dbo].[EsFiscalDe](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[NumeroMesa] [int] NOT NULL,
	[TipoDocumento] [smallint] NOT NULL,
	[NumeroDocumento] [int] NOT NULL,	
	[IdPartido] [uniqueidentifier] NOT NULL,	
	CONSTRAINT [PK_EsFiscalDe] PRIMARY KEY CLUSTERED ([IdEleccion], [NumeroMesa], [TipoDocumento], [NumeroDocumento])
)

ALTER TABLE [dbo].[EsFiscalDe]  WITH CHECK ADD CONSTRAINT [FK_EsFiscalDe_Mesa] FOREIGN KEY([IdEleccion], [NumeroMesa])
REFERENCES [dbo].[Mesa] ([IdEleccion], [Numero])

ALTER TABLE [dbo].[EsFiscalDe] WITH CHECK ADD CONSTRAINT [FK_EsFiscalDe_Ciudadano] FOREIGN KEY([TipoDocumento], [NumeroDocumento])
REFERENCES [dbo].[Ciudadano] ([TipoDocumento], [NumeroDocumento])

ALTER TABLE [dbo].[EsFiscalDe]  WITH CHECK ADD CONSTRAINT [FK_EsFiscalDe_Partido] FOREIGN KEY([IdPartido])
REFERENCES [dbo].[Partido] ([IdPartido])
GO

-- Vota
CREATE TABLE [dbo].[Vota](
	[IdEleccion] [uniqueidentifier] NOT NULL,
	[NumeroMesa] [int] NOT NULL,
	[TipoDocumento] [smallint] NOT NULL,
	[NumeroDocumento] [int] NOT NULL,	
	[Voto] [bit] NOT NULL,
	[Hora] [time](7) NULL,
	CONSTRAINT [PK_Vota] PRIMARY KEY CLUSTERED ([IdEleccion], [NumeroMesa], [TipoDocumento], [NumeroDocumento]),
	CONSTRAINT [Vota_SiVotoTieneHora] CHECK (([Voto] = 0 AND [Hora] IS NULL) OR ([Voto] = 1 AND [Hora] IS NOT NULL))
)

ALTER TABLE [dbo].[Vota]  WITH CHECK ADD CONSTRAINT [FK_Vota_Mesa] FOREIGN KEY([IdEleccion], [NumeroMesa])
REFERENCES [dbo].[Mesa] ([IdEleccion], [Numero])

ALTER TABLE [dbo].[Vota] WITH CHECK ADD CONSTRAINT [FK_Vota_Ciudadano] FOREIGN KEY([TipoDocumento], [NumeroDocumento])
REFERENCES [dbo].[Ciudadano] ([TipoDocumento], [NumeroDocumento])
GO

-- Triggers

-- Restricciones sobre Elecciones
CREATE TRIGGER [ParaInsertarEleccionDeCargoLaEleccionTieneQueSerDeTipoCargo] ON [dbo].[EleccionDeCargo]
AFTER INSERT, UPDATE AS
IF EXISTS (SELECT *
           FROM [dbo].[EleccionDeCargo] c
		   INNER JOIN [dbo].[Eleccion] e ON c.IdEleccion = e.IdEleccion
		   WHERE e.Tipo != 'Cargo')
		   
BEGIN
RAISERROR ('La eleccion debe ser de tipo Cargo', 10, 1);
ROLLBACK TRANSACTION;
RETURN 
END;
GO

CREATE TRIGGER [ParaInsertarEleccionDeCargoNoTieneQueExistirConsultaPopular] ON [dbo].[EleccionDeCargo]
AFTER INSERT, UPDATE AS
IF EXISTS (SELECT *
           FROM [dbo].[EleccionDeCargo]
		   WHERE IdEleccion IN (SELECT IdEleccion FROM [dbo].[ConsultaPopular]))
		   
BEGIN
RAISERROR ('La eleccion ya es de tipo Consulta Popular', 10, 1);
ROLLBACK TRANSACTION;
RETURN 
END;
GO

CREATE TRIGGER [ParaInsertarEleccionDeConsultaPopularLaEleccionTieneQueSerDeTipoConsultaPopular] ON [dbo].[ConsultaPopular]
AFTER INSERT, UPDATE AS
IF EXISTS (SELECT *
           FROM [dbo].[ConsultaPopular] c
		   INNER JOIN [dbo].[Eleccion] e ON c.IdEleccion = e.IdEleccion
		   WHERE e.Tipo != 'ConsultaPopular')
		   
BEGIN
RAISERROR ('La eleccion debe ser de tipo ConsultaPopular', 10, 1);
ROLLBACK TRANSACTION;
RETURN 
END;
GO

CREATE TRIGGER [ParaInsertarEleccionDeConsultaPopularNoTieneQueExistirEleccionDeCargo] ON [dbo].[ConsultaPopular]
AFTER INSERT AS
IF EXISTS (SELECT *
           FROM [dbo].[ConsultaPopular]
		   WHERE IdEleccion IN (SELECT IdEleccion FROM [dbo].[EleccionDeCargo]))
		   
BEGIN
RAISERROR ('La eleccion ya es de tipo Cargo', 10, 1);
ROLLBACK TRANSACTION;
RETURN
END;
GO

-- Restricciones sobre los Cargos

CREATE TRIGGER [PresidenteNoTieneOtroCargoPorEleccion] ON [dbo].[Mesa]
AFTER INSERT, UPDATE AS
IF EXISTS (SELECT 1 FROM Mesa m1, Mesa m2
			WHERE m1.IdEleccion = m2.IdEleccion AND m1.Numero != m2.Numero AND (
			(m1.TipoDocumentoPresidente = m2.TipoDocumentoPresidente AND m1.NumeroDocumentoPresidente = m2.NumeroDocumentoPresidente) OR
			(m1.TipoDocumentoPresidente = m2.TipoDocumentoVicepresidente AND m1.NumeroDocumentoPresidente = m2.NumeroDocumentoVicepresidente) OR
			(m1.TipoDocumentoPresidente = m2.TipoDocumentoTecnico AND m1.NumeroDocumentoPresidente = m2.NumeroDocumentoTecnico)))
OR EXISTS (SELECT 1 FROM Mesa m INNER JOIN EsFiscalDe e
			ON m.IdEleccion = e.IdEleccion WHERE m.TipoDocumentoPresidente = e.TipoDocumento AND m.NumeroDocumentoPresidente = e.NumeroDocumento)
OR EXISTS (SELECT 1 FROM Mesa m INNER JOIN Conduce c
			ON m.IdEleccion = c.IdEleccion WHERE m.TipoDocumentoPresidente = c.TipoDocumento AND m.NumeroDocumentoPresidente = c.NumeroDocumento)
BEGIN
RAISERROR ('El presidente no puede tener otro cargo en una misma eleccion', 10, 1);
ROLLBACK TRANSACTION;
RETURN 
END;
GO

CREATE TRIGGER [FiscalNoTIeneOtroCargo] ON [dbo].[EsFiscalDe]
AFTER INSERT, UPDATE AS
IF EXISTS (SELECT 1 FROM Mesa m INNER JOIN EsFiscalDe e
			ON m.IdEleccion = e.IdEleccion WHERE (m.TipoDocumentoPresidente = e.TipoDocumento AND m.NumeroDocumentoPresidente = e.NumeroDocumento) OR
			(m.TipoDocumentoVicepresidente = e.TipoDocumento AND m.NumeroDocumentoVicepresidente = e.NumeroDocumento) OR
			(m.TipoDocumentoTecnico = e.TipoDocumento AND m.NumeroDocumentoTecnico = e.NumeroDocumento)
OR EXISTS (SELECT 1 FROM EsFiscalDe e INNER JOIN Conduce c
			ON e.IdEleccion = c.IdEleccion WHERE e.TipoDocumento = c.TipoDocumento AND e.NumeroDocumento = c.NumeroDocumento))
BEGIN
RAISERROR ('El fiscal no puede tener otro cargo en la misma eleccion', 10, 1);
ROLLBACK TRANSACTION;
RETURN 
END;
GO

CREATE TRIGGER [VicepresidenteNoTieneOtroCargoPorEleccion] ON [dbo].[Mesa]
AFTER INSERT, UPDATE AS
IF EXISTS (SELECT 1 FROM Mesa m1, Mesa m2
			WHERE m1.IdEleccion = m2.IdEleccion AND m1.Numero != m2.Numero AND (			
			(m1.TipoDocumentoVicepresidente = m2.TipoDocumentoVicepresidente AND m1.NumeroDocumentoVicepresidente = m2.NumeroDocumentoVicepresidente) OR
			(m1.TipoDocumentoVicepresidente = m2.TipoDocumentoTecnico AND m1.NumeroDocumentoVicepresidente = m2.NumeroDocumentoTecnico)))
OR EXISTS (SELECT 1 FROM Mesa m INNER JOIN EsFiscalDe e
			ON m.IdEleccion = e.IdEleccion WHERE m.TipoDocumentoVicepresidente = e.TipoDocumento AND m.NumeroDocumentoVicepresidente = e.NumeroDocumento)
OR EXISTS (SELECT 1 FROM Mesa m INNER JOIN Conduce c
			ON m.IdEleccion = c.IdEleccion WHERE m.TipoDocumentoVicepresidente = c.TipoDocumento AND m.NumeroDocumentoVicepresidente = c.NumeroDocumento)
BEGIN
RAISERROR ('El vicepresidente no puede tener otro cargo en la misma eleccion', 10, 1);
ROLLBACK TRANSACTION;
RETURN 
END;
GO

CREATE TRIGGER [TecnicoNoPuedeSerConductorDeCamionetaOFiscalPorEleccion] ON [dbo].[Mesa]
AFTER INSERT, UPDATE AS
IF EXISTS (SELECT 1 FROM Mesa m INNER JOIN Conduce c
			ON m.IdEleccion = c.IdEleccion WHERE (m.TipoDocumentoTecnico = c.TipoDocumento AND m.NumeroDocumentoTecnico = c.NumeroDocumento))
OR EXISTS (SELECT 1 FROM Mesa m INNER JOIN EsFiscalDe e
			ON m.IdEleccion = e.IdEleccion WHERE (m.TipoDocumentoTecnico = e.TipoDocumento AND m.NumeroDocumentoTecnico = e.NumeroDocumento)
)
BEGIN
RAISERROR ('El tecnico no puede ser conductor de camioneta o fiscal en la misma eleccion', 10, 1);
ROLLBACK TRANSACTION;
RETURN 
END;
GO

CREATE TRIGGER [ConductorNoPuedeTenerOtroCargo] ON [dbo].[Conduce]
AFTER INSERT, UPDATE AS
IF EXISTS (SELECT 1 FROM Mesa m INNER JOIN Conduce c
			ON m.IdEleccion = c.IdEleccion WHERE (m.TipoDocumentoPresidente = c.TipoDocumento AND m.NumeroDocumentoPresidente = c.NumeroDocumento) OR
			(m.TipoDocumentoVicepresidente = c.TipoDocumento AND m.NumeroDocumentoVicepresidente = c.NumeroDocumento) OR
			(m.TipoDocumentoTecnico = c.TipoDocumento AND m.NumeroDocumentoTecnico = c.NumeroDocumento)
OR EXISTS (SELECT 1 FROM Conduce c INNER JOIN EsFiscalDe e
			ON c.IdEleccion = e.IdEleccion WHERE (c.TipoDocumento = e.TipoDocumento AND c.NumeroDocumento = e.NumeroDocumento)))
BEGIN
RAISERROR ('El Conductor no puede tener otro cargo en la mima eleccion', 10, 1);
ROLLBACK TRANSACTION;
RETURN 
END;
GO

-- Restriccioners sobre Votacion

CREATE TRIGGER [VotaConHoraValida] ON [dbo].[Vota]
AFTER INSERT, UPDATE AS
IF EXISTS (SELECT 1 FROM Vota v INNER JOIN Eleccion e ON v.IdEleccion = e.IdEleccion 
			WHERE v.Hora < e.HoraDesde OR v.Hora > e.HoraHasta)
		   
BEGIN
RAISERROR ('La hora de votacion no es valida', 10, 1);
ROLLBACK TRANSACTION;
RETURN 
END;
GO