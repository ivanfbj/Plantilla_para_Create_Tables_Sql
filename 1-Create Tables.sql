--CREATE DATABASE Proyecto_base_de_datos_1;
GO
USE Proyecto_base_de_datos_1;
GO

CREATE TABLE [dbo].[tblDepartamento]
(
  [codigo] NVARCHAR(2) NOT NULL, 
  [nombre] NVARCHAR(100) NOT NULL, 
  CONSTRAINT [PK_tblDepartamento_codigo] PRIMARY KEY([codigo]));

CREATE TABLE [dbo].[tblCiudad]
(
  [codigo]                 NVARCHAR(10) NOT NULL, 
  [nombre]                 NVARCHAR(100) NOT NULL, 
  [tblDepartamento_codigo] NVARCHAR(2) NOT NULL, 
  CONSTRAINT [PK_tblCiudad_codigo] PRIMARY KEY([codigo]), 
  CONSTRAINT [FK_tblDepartamento_codigo_tblCiudad_tblDepartamento_codigo] FOREIGN KEY([tblDepartamento_codigo]) REFERENCES [tblDepartamento]([codigo]));

CREATE TABLE [dbo].[tblOficina]
(
  [codigo]           NVARCHAR(100) NOT NULL, 
  [nombre]           NVARCHAR(255) NOT NULL, 
  [direccion]        NVARCHAR(100) NOT NULL, 
  [telefono]         NVARCHAR(15) NOT NULL, 
  [codigoPostal]     NVARCHAR(15) NOT NULL, 
  [tblCiudad_codigo] NVARCHAR(10) NOT NULL, 
  [fechaCreacion]    DATETIME NOT NULL
						DEFAULT GETDATE(), 
  CONSTRAINT [PK_tblOficina_codigo] PRIMARY KEY([codigo]), 
  CONSTRAINT [FK_tblCiudad_codigo_tblOficina_tblCiudad_codigo] FOREIGN KEY([tblCiudad_codigo]) REFERENCES [tblCiudad]([codigo]));

CREATE TABLE [dbo].[tblMarca]
(
  [id]     INT NOT NULL IDENTITY, 
  [nombre] NVARCHAR(255) NOT NULL, 
  CONSTRAINT [PK_tblMarca_id] PRIMARY KEY([id]), 
  CONSTRAINT [UNIQUE_tblMarca_nombre] UNIQUE([nombre]));

--CREATE TABLE [dbo].[tblModelo]
--(
--  [id]          INT NOT NULL IDENTITY, 
--  [nombre]      NVARCHAR(255) NOT NULL, 
--  [tblMarca_id] INT NOT NULL, 
--  CONSTRAINT [PK_tblModelo_id] PRIMARY KEY([id]), 
--  CONSTRAINT [FK_tblMarca_id_tblModelo_tblMarca_id] FOREIGN KEY([tblMarca_id]) REFERENCES [tblMarca]([id]), 
--  CONSTRAINT [UNIQUE_tblModelo_nombre_tblMarca_id] UNIQUE([nombre], [tblMarca_id]));

CREATE TABLE [dbo].[tblGrupo]
(
  [codigo]  NVARCHAR(100) NOT NULL, 
  [tipo]    NVARCHAR(100) NOT NULL, 
  [tamanio] NVARCHAR(100) NOT NULL, 
  CONSTRAINT [PK_tblGrupo_codigo] PRIMARY KEY([codigo]));

CREATE TABLE [dbo].[tblVehiculo]
(
  [matricula]			NVARCHAR(10) NOT NULL,
  [numeroPlazas]		INT NOT NULL,
  [capacidadMaletero]	NVARCHAR(100) NOT NULL,
  [edadMinima]			INT NOT NULL,
  [numeroPuertas]		INT NOT NULL,
  [tblOficina_codigo]	NVARCHAR(100) NOT NULL,
  [anioModelo]			INT NOT NULL,
  [tblGrupo_codigo]		NVARCHAR(100),
  [tblMarca_id]			INT NOT NULL,
  [fechaCreacion]		DATETIME NOT NULL
							DEFAULT GETDATE(), 
  CONSTRAINT [PK_tblVehiculo_matricula] PRIMARY KEY([matricula]), 
  CONSTRAINT [FK_tblOficina_codigo_tblVehiculo_tblOficina_codigo] FOREIGN KEY([tblOficina_codigo]) REFERENCES [tblOficina]([codigo]), 
  CONSTRAINT [FK_tblGrupo_codigo_tblVehiculo_tblGrupo_codigo] FOREIGN KEY([tblGrupo_codigo]) REFERENCES [tblGrupo]([codigo]),
  CONSTRAINT [FK_tblMarca_id_tblVehiculo_tblMarca_id] FOREIGN KEY([tblMarca_id]) REFERENCES [tblMarca]([id]),
  );

CREATE TABLE [dbo].[tblCliente]
(
  [dni]                  NVARCHAR(10) NOT NULL, 
  [nombreConductor]      NVARCHAR(255) NOT NULL, 
  [direccion]            NVARCHAR(255) NOT NULL, 
  [telefono]             NVARCHAR(15) NOT NULL, 
  [numeroTarjetaCredito] NVARCHAR(16) NOT NULL, 
  [fechaCreacion]        DATETIME NOT NULL
						    DEFAULT GETDATE(), 
  CONSTRAINT [PK_tblCliente_dni] PRIMARY KEY([dni]));


  CREATE TABLE [dbo].[tblTipoSeguro]
(
  [codigo] NVARCHAR(50) NOT NULL, 
  [nombre] NVARCHAR(100) NOT NULL, 
  CONSTRAINT [PK_tblTipoSeguro_codigo] PRIMARY KEY([codigo]));

CREATE TABLE [dbo].[tblAlquiler]
(
  [id]                    INT NOT NULL IDENTITY, 
  [duracionAlquiler]      INT NOT NULL, 
  [tblTipoSeguro_codigo]  NVARCHAR(50) NOT NULL, 
  [precioTotal]           FLOAT NOT NULL, 
  [tblVehiculo_matricula] NVARCHAR(10) NOT NULL, 
  [tblCliente_dni]        NVARCHAR(10) NOT NULL, 
  [fechaAlquiler]          DATETIME NOT NULL
							DEFAULT GETDATE(), 
  CONSTRAINT [PK_tblAlquiler_id] PRIMARY KEY([id]), 
  CONSTRAINT [FK_tblVehiculo_matricula_tblAlquiler_tblVehiculo_matricula] FOREIGN KEY([tblVehiculo_matricula]) REFERENCES [tblVehiculo]([matricula]), 
  CONSTRAINT [FK_tblCliente_dni_tblAlquiler_tblCliente_dni] FOREIGN KEY([tblCliente_dni]) REFERENCES [tblCliente]([dni]),
  CONSTRAINT [FK_tblTipoSeguro_codigo_tblAlquiler_tblTipoSeguro_codigo] FOREIGN KEY([tblTipoSeguro_codigo]) REFERENCES [tblTipoSeguro]([codigo]),
  );
/*
drop table tblAlquiler
drop table tblTipoSeguro
drop table tblCliente
drop table tblVehiculo
drop table tblGrupo
drop table tblMarca
drop table tblOficina
drop table tblCiudad
drop table tblDepartamento
*/
/*
SELECT CONSTRAINT_NAME,
     TABLE_SCHEMA ,
     TABLE_NAME,
     CONSTRAINT_TYPE
     FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
   WHERE TABLE_NAME in ('tblAlquiler','tblCliente','tblVehiculo','tblGrupo','tblModelo','tblMarca','tblOficina','tblCiudad','tblDepartamento')
   order by 3
*/