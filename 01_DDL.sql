-- =====================================================
-- 01_DDL.sql - Creación de tablas FanHub (CORREGIDO)
-- =====================================================

-- BLOQUE DE REINICIO SEGURO
USE master;
GO
IF DB_ID('FanHub') IS NOT NULL
BEGIN
    ALTER DATABASE FanHub SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE FanHub;
END
GO
CREATE DATABASE FanHub;
GO
USE FanHub;
GO

-- Tabla Usuario
CREATE TABLE Usuario (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(255) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    nickname NVARCHAR(100) UNIQUE NOT NULL,
    fecha_registro DATETIME DEFAULT GETDATE(),
    fecha_nacimiento DATE NOT NULL,
    pais NVARCHAR(100) NOT NULL,
    esta_activo BIT DEFAULT 1,
    CONSTRAINT check_edad CHECK (fecha_nacimiento <= DATEADD(YEAR, -13, GETDATE())) -- Lógica exacta
);
GO

-- Tabla Categoria
CREATE TABLE Categoria (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) UNIQUE NOT NULL,
    descripcion NVARCHAR(MAX) -- Corregido: TEXT está deprecado
);
GO

-- Tabla Creador
CREATE TABLE Creador (
    idUsuario INT PRIMARY KEY,
    biografia NVARCHAR(MAX), -- Corregido
    banco_nombre NVARCHAR(100),
    banco_cuenta NVARCHAR(50),
    es_nsfw BIT DEFAULT 0,
    idCategoria INT NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (idCategoria) REFERENCES Categoria(id)
);
GO

-- Tabla MetodoPago
CREATE TABLE MetodoPago (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idUsuario INT NOT NULL,
    ultimos_4_digitos CHAR(4) NOT NULL,
    marca NVARCHAR(50) NOT NULL,
    titular NVARCHAR(200) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    es_predeterminado BIT DEFAULT 0,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id) ON DELETE CASCADE,
    CONSTRAINT check_fecha_expiracion CHECK (fecha_expiracion > GETDATE())
);
GO

-- Tabla NivelSuscripcion
CREATE TABLE NivelSuscripcion (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idCreador INT NOT NULL,
    nombre NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(MAX), -- Corregido
    precio_actual DECIMAL(10,2) NOT NULL,
    esta_activo BIT DEFAULT 1,
    orden INT NOT NULL,
    FOREIGN KEY (idCreador) REFERENCES Creador(idUsuario) ON DELETE CASCADE,
    CONSTRAINT check_precio_positivo CHECK (precio_actual >= 0),
    CONSTRAINT unique_orden_por_creador UNIQUE (idCreador, orden)
);
GO

-- Tabla Suscripcion
CREATE TABLE Suscripcion (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idUsuario INT NOT NULL,
    idNivel INT NOT NULL,
    fecha_inicio DATETIME DEFAULT GETDATE(),
    fecha_renovacion DATETIME,
    fecha_fin DATETIME,
    estado NVARCHAR(20) NOT NULL,
    precio_pactado DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
    FOREIGN KEY (idNivel) REFERENCES NivelSuscripcion(id),
    CONSTRAINT check_estado_suscripcion CHECK (estado IN ('Activa', 'Cancelada', 'Vencida')),
    CONSTRAINT check_precio_pactado_positivo CHECK (precio_pactado >= 0) -- Corregido: Regla B faltante
);
GO

-- Tabla Factura
CREATE TABLE Factura (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idSuscripcion INT NOT NULL,
    codigo_transaccion NVARCHAR(100) UNIQUE NOT NULL,
    fecha_emision DATETIME DEFAULT GETDATE(),
    sub_total DECIMAL(10,2) NOT NULL,
    monto_impuesto DECIMAL(10,2) NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (idSuscripcion) REFERENCES Suscripcion(id),
    CONSTRAINT check_montos_positivos CHECK (sub_total >= 0 AND monto_impuesto >= 0 AND monto_total >= 0)
);
GO

-- Tabla Publicacion
CREATE TABLE Publicacion (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idCreador INT NOT NULL,
    titulo NVARCHAR(255) NOT NULL,
    fecha_publicacion DATETIME DEFAULT GETDATE(),
    es_publica BIT DEFAULT 1,
    tipo_contenido NVARCHAR(10) NOT NULL,
    FOREIGN KEY (idCreador) REFERENCES Creador(idUsuario) ON DELETE CASCADE,
    CONSTRAINT check_tipo_contenido CHECK (tipo_contenido IN ('VIDEO', 'TEXTO', 'IMAGEN'))
);
GO

-- Tabla Video
CREATE TABLE Video (
    idPublicacion INT PRIMARY KEY,
    duracion_seg INT NOT NULL,
    resolucion NVARCHAR(10) NOT NULL,
    url_stream NVARCHAR(500) NOT NULL,
    FOREIGN KEY (idPublicacion) REFERENCES Publicacion(id) ON DELETE CASCADE,
    CONSTRAINT check_resolucion CHECK (resolucion IN ('720p', '1080p', '4K')),
    CONSTRAINT check_duracion CHECK (duracion_seg > 0)
);
GO

-- Tabla Texto
CREATE TABLE Texto (
    idPublicacion INT PRIMARY KEY,
    contenido_html NVARCHAR(MAX) NOT NULL, -- Corregido
    resumen_gratuito NVARCHAR(MAX), -- Corregido
    FOREIGN KEY (idPublicacion) REFERENCES Publicacion(id) ON DELETE CASCADE
);
GO

-- Tabla Imagen
CREATE TABLE Imagen (
    idPublicacion INT PRIMARY KEY,
    ancho INT NOT NULL,
    alto INT NOT NULL,
    formato NVARCHAR(10) NOT NULL,
    alt_text NVARCHAR(255),
    url_imagen NVARCHAR(500) NOT NULL,
    FOREIGN KEY (idPublicacion) REFERENCES Publicacion(id) ON DELETE CASCADE,
    CONSTRAINT check_dimensiones CHECK (ancho > 0 AND alto > 0)
);
GO

-- Tabla TipoReaccion
CREATE TABLE TipoReaccion (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(50) UNIQUE NOT NULL,
    emoji_code NVARCHAR(20) NOT NULL -- Corregido: Ahora soporta los emojis del profe
);
GO

-- Tabla UsuarioReaccionPublicacion
CREATE TABLE UsuarioReaccionPublicacion (
    idUsuario INT NOT NULL,
    idPublicacion INT NOT NULL,
    idTipoReaccion INT NOT NULL,
    fecha_reaccion DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (idUsuario, idPublicacion, idTipoReaccion),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
    FOREIGN KEY (idPublicacion) REFERENCES Publicacion(id) ON DELETE CASCADE,
    FOREIGN KEY (idTipoReaccion) REFERENCES TipoReaccion(id)
);
GO

-- Tabla Comentario
CREATE TABLE Comentario (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idUsuario INT NOT NULL,
    idPublicacion INT NOT NULL,
    idComentarioPadre INT NULL,
    texto NVARCHAR(MAX) NOT NULL, -- Corregido
    fecha DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
    FOREIGN KEY (idPublicacion) REFERENCES Publicacion(id) ON DELETE CASCADE,
    FOREIGN KEY (idComentarioPadre) REFERENCES Comentario(id)
);
GO

-- Tabla Etiqueta
CREATE TABLE Etiqueta (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) UNIQUE NOT NULL
);
GO

-- Tabla PublicacionEtiqueta
CREATE TABLE PublicacionEtiqueta (
    idPublicacion INT NOT NULL,
    idEtiqueta INT NOT NULL,
    PRIMARY KEY (idPublicacion, idEtiqueta),
    FOREIGN KEY (idPublicacion) REFERENCES Publicacion(id) ON DELETE CASCADE,
    FOREIGN KEY (idEtiqueta) REFERENCES Etiqueta(id) ON DELETE CASCADE
);
GO

-- Índices para optimización
CREATE INDEX idx_usuario_email ON Usuario(email);
CREATE INDEX idx_usuario_pais ON Usuario(pais);
CREATE INDEX idx_suscripcion_estado ON Suscripcion(estado);
CREATE INDEX idx_publicacion_fecha ON Publicacion(fecha_publicacion);
CREATE INDEX idx_comentario_publicacion ON Comentario(idPublicacion);
CREATE INDEX idx_reaccion_publicacion ON UsuarioReaccionPublicacion(idPublicacion);
GO

PRINT '========================================';
PRINT '✅ TABLAS CREADAS Y CORREGIDAS EXITOSAMENTE';
PRINT '========================================';
GO