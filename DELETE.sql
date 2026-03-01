-- ==========================================
-- SCRIPT PARA ELIMINAR TODAS LAS TABLAS DE FANHUB
-- ==========================================
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'ELIMINANDO TODAS LAS TABLAS DE FANHUB';
PRINT '========================================';
GO

-- ==========================================
-- 1. DESHABILITAR RESTRICCIONES DE LLAVES FORÁNEAS TEMPORALMENTE
-- ==========================================
PRINT 'Deshabilitando restricciones de claves foráneas...';
EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT ALL";
PRINT ' Restricciones deshabilitadas';
GO

-- ==========================================
-- 2. ELIMINAR TABLAS EN ORDEN INVERSO DE DEPENDENCIAS
-- ==========================================
PRINT 'Eliminando tablas en orden inverso...';

-- Tablas de relaciones muchos a muchos y dependientes
DROP TABLE IF EXISTS UsuarioReaccionPublicacion;
PRINT '✓ Eliminada: UsuarioReaccionPublicacion';

DROP TABLE IF EXISTS PublicacionEtiqueta;
PRINT '✓ Eliminada: PublicacionEtiqueta';

DROP TABLE IF EXISTS Comentario;
PRINT '✓ Eliminada: Comentario';

DROP TABLE IF EXISTS Video;
PRINT '✓ Eliminada: Video';

DROP TABLE IF EXISTS Texto;
PRINT '✓ Eliminada: Texto';

DROP TABLE IF EXISTS Imagen;
PRINT '✓ Eliminada: Imagen';

DROP TABLE IF EXISTS Factura;
PRINT '✓ Eliminada: Factura';

DROP TABLE IF EXISTS Suscripcion;
PRINT '✓ Eliminada: Suscripcion';

DROP TABLE IF EXISTS NivelSuscripcion;
PRINT '✓ Eliminada: NivelSuscripcion';

DROP TABLE IF EXISTS MetodoPago;
PRINT '✓ Eliminada: MetodoPago';

DROP TABLE IF EXISTS Publicacion;
PRINT '✓ Eliminada: Publicacion';

DROP TABLE IF EXISTS Creador;
PRINT '✓ Eliminada: Creador';

DROP TABLE IF EXISTS Etiqueta;
PRINT '✓ Eliminada: Etiqueta';

DROP TABLE IF EXISTS TipoReaccion;
PRINT '✓ Eliminada: TipoReaccion';

DROP TABLE IF EXISTS Categoria;
PRINT '✓ Eliminada: Categoria';

DROP TABLE IF EXISTS Usuario;
PRINT '✓ Eliminada: Usuario';

PRINT ' Todas las tablas eliminadas';
GO

-- ==========================================
-- 3. REHABILITAR RESTRICCIONES (OPCIONAL)
-- ==========================================
PRINT 'Rehabilitando restricciones de claves foráneas...';
EXEC sp_MSforeachtable "ALTER TABLE ? CHECK CONSTRAINT ALL";
PRINT ' Restricciones rehabilitadas';
GO

-- ==========================================
-- 4. VERIFICAR QUE NO QUEDAN TABLAS
-- ==========================================
PRINT '========================================';
PRINT 'VERIFICANDO TABLAS RESTANTES:';
PRINT '========================================';

SELECT 
    TABLE_NAME as TablasRestantes
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

IF @@ROWCOUNT = 0
    PRINT ' No quedan tablas en la base de datos';
ELSE
    PRINT ' Aún existen tablas en la base de datos';
GO

PRINT '========================================';
PRINT ' PROCESO DE ELIMINACIÓN COMPLETADO';
PRINT '========================================';
GO