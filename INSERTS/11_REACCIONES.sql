-- ==========================================
-- 10. REACCIONES (1600 registros nuevos con distribución realista)
-- ==========================================
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'GENERANDO NUEVAS REACCIONES';
PRINT '========================================';
GO

-- ==========================================
-- 1. ELIMINAR REACCIONES EXISTENTES (OPCIONAL)
-- ==========================================
PRINT 'Eliminando reacciones existentes...';
DELETE FROM UsuarioReaccionPublicacion;
PRINT ' Reacciones eliminadas';
GO

-- ==========================================
-- 2. GENERAR 1600 NUEVAS REACCIONES
-- ==========================================
PRINT 'Generando 1600 nuevas reacciones...';

-- Crear tabla temporal con la distribución deseada
DECLARE @Reacciones TABLE (idTipoReaccion INT, peso INT);
INSERT INTO @Reacciones VALUES 
(1, 235),  -- Me gusta
(2, 222),  -- Me encanta
(3, 232),  -- Me divierte
(4, 228),  -- Fuego
(5, 233),  -- Me entristece
(6, 218),  -- Me asombra
(7, 232);  -- Me enfurece
-- Total: 1600

DECLARE @contador INT = 1;
DECLARE @idUsuario INT;
DECLARE @idPublicacion INT;
DECLARE @idTipoReaccion INT;
DECLARE @fecha DATETIME;

-- Generar las reacciones una por una para controlar la distribución
WHILE @contador <= 1600
BEGIN
    -- Seleccionar tipo de reacción basado en la distribución
    SELECT TOP 1 @idTipoReaccion = idTipoReaccion
    FROM @Reacciones
    WHERE peso > 0
    ORDER BY NEWID();
    
    -- Reducir el peso del tipo seleccionado
    UPDATE @Reacciones SET peso = peso - 1 WHERE idTipoReaccion = @idTipoReaccion;
    
    -- Seleccionar usuario aleatorio (que no sea creador, id > 26)
    SELECT TOP 1 @idUsuario = id 
    FROM Usuario 
    WHERE id > 26 AND esta_activo = 1
    ORDER BY NEWID();
    
    -- Seleccionar publicación aleatoria
    SELECT TOP 1 @idPublicacion = id 
    FROM Publicacion 
    ORDER BY NEWID();
    
    -- Generar fecha aleatoria en los últimos 6 meses
    SET @fecha = DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 180, GETDATE());
    
    -- Evitar duplicados (mismo usuario, misma publicación, mismo tipo)
    IF NOT EXISTS (
        SELECT 1 FROM UsuarioReaccionPublicacion 
        WHERE idUsuario = @idUsuario 
        AND idPublicacion = @idPublicacion 
        AND idTipoReaccion = @idTipoReaccion
    )
    BEGIN
        INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion)
        VALUES (@idUsuario, @idPublicacion, @idTipoReaccion, @fecha);
        
        SET @contador = @contador + 1;
    END;
    
    -- Mostrar progreso cada 200 reacciones
    IF @contador % 200 = 0
        PRINT '  ✓ ' + CAST(@contador AS VARCHAR) + ' reacciones insertadas...';
END;

PRINT ' 1600 reacciones insertadas correctamente';
GO

-- ==========================================
-- 3. VERIFICAR DISTRIBUCIÓN FINAL
-- ==========================================
PRINT '========================================';
PRINT 'VERIFICACIÓN DE DISTRIBUCIÓN:';
PRINT '========================================';

SELECT 
    tr.nombre as TipoReaccion,
    COUNT(*) as Cantidad,
    CAST(COUNT(*) * 100.0 / 1600 AS DECIMAL(10,2)) as Porcentaje
FROM UsuarioReaccionPublicacion urp
JOIN TipoReaccion tr ON urp.idTipoReaccion = tr.id
GROUP BY tr.nombre
ORDER BY Cantidad DESC;
GO

-- ==========================================
-- 4. ESTADÍSTICAS GENERALES
-- ==========================================
SELECT 
    'Total reacciones' as Concepto,
    COUNT(*) as Valor
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Usuarios que han reaccionado',
    COUNT(DISTINCT idUsuario)
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Publicaciones con reacciones',
    COUNT(DISTINCT idPublicacion)
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Tipos de reacción utilizados',
    COUNT(DISTINCT idTipoReaccion)
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Promedio reacciones por usuario',
    COUNT(*) / NULLIF(COUNT(DISTINCT idUsuario), 0)
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Promedio reacciones por publicación',
    COUNT(*) / NULLIF(COUNT(DISTINCT idPublicacion), 0)
FROM UsuarioReaccionPublicacion;
GO

PRINT '========================================';
PRINT ' REACCIONES GENERADAS EXITOSAMENTE';
PRINT '========================================';
GO