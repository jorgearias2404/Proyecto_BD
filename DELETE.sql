-- ==========================================
-- SCRIPT PARA ELIMINAR TODAS LAS TABLAS Y LA BASE DE DATOS
-- ==========================================
USE master;
GO

PRINT '========================================';
PRINT 'ELIMINANDO BASE DE DATOS FANHUB_BD';
PRINT '========================================';
GO

-- ==========================================
-- 1. CAMBIAR A MASTER Y FORZAR CIERRE DE CONEXIONES
-- ==========================================
PRINT 'Forzando cierre de conexiones a la base de datos...';

-- Poner la base de datos en modo SINGLE_USER para desconectar todas las conexiones
ALTER DATABASE FanHub_BD SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
PRINT '✓ Conexiones cerradas';
GO

-- ==========================================
-- 2. ELIMINAR LA BASE DE DATOS
-- ==========================================
PRINT 'Eliminando base de datos FanHub_BD...';

DROP DATABASE IF EXISTS FanHub_BD;
PRINT '✓ Base de datos eliminada';
GO

-- ==========================================
-- 3. VERIFICAR QUE LA BASE DE DATOS YA NO EXISTE
-- ==========================================
PRINT '========================================';
PRINT 'VERIFICANDO BASES DE DATOS RESTANTES:';
PRINT '========================================';

SELECT 
    name AS BasesDeDatosRestantes
FROM sys.databases
WHERE name LIKE '%FanHub%'
ORDER BY name;

IF @@ROWCOUNT = 0
    PRINT '✓ No quedan bases de datos con el nombre FanHub';
ELSE
    PRINT '⚠️ Aún existen bases de datos con ese nombre';
GO

PRINT '========================================';
PRINT '✅ PROCESO DE ELIMINACIÓN COMPLETADO';
PRINT '========================================';
GO