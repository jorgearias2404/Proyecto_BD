-- ==========================================
-- 12.5. CREAR USUARIOS "LURKERS" (SUSCRIPTORES SIN INTERACCIONES)
-- ==========================================
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'CREANDO USUARIOS LURKERS (SIN INTERACCIONES)';
PRINT '========================================';
GO

-- ==========================================
-- 1. VERIFICAR CUÁNTOS LURKERS EXISTEN ACTUALMENTE
-- ==========================================
DECLARE @lurkers_actuales INT;

SELECT @lurkers_actuales = COUNT(*)
FROM Usuario u
JOIN Suscripcion s ON u.id = s.idUsuario
WHERE s.estado = 'Activa'
  AND NOT EXISTS (SELECT 1 FROM UsuarioReaccionPublicacion WHERE idUsuario = u.id)
  AND NOT EXISTS (SELECT 1 FROM Comentario WHERE idUsuario = u.id);

PRINT 'Lurkers actuales: ' + CAST(@lurkers_actuales AS VARCHAR);

IF @lurkers_actuales >= 3
BEGIN
    PRINT ' Ya existen ' + CAST(@lurkers_actuales AS VARCHAR) + ' lurkers. No es necesario crear más.';
    
    -- Mostrar los lurkers existentes
    SELECT 
        u.id,
        u.nickname,
        s.fecha_inicio,
        s.precio_pactado
    FROM Usuario u
    JOIN Suscripcion s ON u.id = s.idUsuario
    WHERE s.estado = 'Activa'
      AND NOT EXISTS (SELECT 1 FROM UsuarioReaccionPublicacion WHERE idUsuario = u.id)
      AND NOT EXISTS (SELECT 1 FROM Comentario WHERE idUsuario = u.id);
    
    RETURN;
END
GO

-- ==========================================
-- 2. CREAR NUEVOS USUARIOS LURKERS (IDs 101-110)
-- ==========================================
PRINT 'Creando 10 nuevos usuarios "lurkers"...';

-- Encontrar el máximo ID actual
DECLARE @max_id INT;
SELECT @max_id = ISNULL(MAX(id), 100) FROM Usuario;

INSERT INTO Usuario (id, email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo)
SELECT 
    @max_id + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'lurker' + CAST(@max_id + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR) + '@email.com',
    'hash_lurker_' + CAST(@max_id + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR),
    CASE ABS(CHECKSUM(NEWID())) % 10
        WHEN 0 THEN 'SilentWatcher'
        WHEN 1 THEN 'JustReading'
        WHEN 2 THEN 'NoComments'
        WHEN 3 THEN 'PassiveFan'
        WHEN 4 THEN 'GhostUser'
        WHEN 5 THEN 'StealthMode'
        WHEN 6 THEN 'Invisible'
        WHEN 7 THEN 'QuietObserver'
        WHEN 8 THEN 'BackgroundNoise'
        ELSE 'ShadowViewer'
    END + CAST(@max_id + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR),
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 30, GETDATE()), -- Últimos 30 días
    DATEADD(YEAR, -25 - ABS(CHECKSUM(NEWID())) % 20, GETDATE()), -- Edad 25-45 años
    CASE ABS(CHECKSUM(NEWID())) % 5
        WHEN 0 THEN 'MX'
        WHEN 1 THEN 'AR'
        WHEN 2 THEN 'ES'
        WHEN 3 THEN 'CO'
        ELSE 'CL'
    END,
    1 -- Activo
FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10)) AS numeros(n);

PRINT ' 10 usuarios lurkers creados';
GO

-- ==========================================
-- 3. CREAR SUSCRIPCIONES PARA LOS NUEVOS LURKERS
-- ==========================================
PRINT 'Creando suscripciones para lurkers...';

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_fin, precio_pactado, estado)
SELECT 
    u.id,
    1 + ABS(CHECKSUM(NEWID())) % 3, -- Niveles 1-3
    DATEADD(MONTH, -ABS(CHECKSUM(NEWID())) % 6, GETDATE()), -- Inicio hace 0-6 meses
    DATEADD(MONTH, 1, GETDATE()), -- Activas por 1 mes más
    CASE 1 + ABS(CHECKSUM(NEWID())) % 3
        WHEN 1 THEN 5.99
        WHEN 2 THEN 9.99
        ELSE 14.99
    END,
    'Activa'
FROM Usuario u
WHERE u.id > @max_id  -- Solo los nuevos lurkers
  AND NOT EXISTS (SELECT 1 FROM Suscripcion WHERE idUsuario = u.id);

PRINT ' Suscripciones para lurkers creadas';
GO

-- ==========================================
-- 4. VERIFICAR QUE AHORA HAY AL MENOS 3 LURKERS
-- ==========================================
PRINT '';
PRINT '========================================';
PRINT 'VERIFICACIÓN FINAL DE LURKERS:';
PRINT '========================================';

SELECT 
    u.nickname AS [Nickname],
    u.fecha_registro AS [Fecha Registro],
    s.fecha_inicio AS [Inicio Suscripción],
    s.precio_pactado AS [Precio],
    CASE 
        WHEN EXISTS (SELECT 1 FROM UsuarioReaccionPublicacion WHERE idUsuario = u.id) THEN '❌ TIENE REACCIONES'
        WHEN EXISTS (SELECT 1 FROM Comentario WHERE idUsuario = u.id) THEN '❌ TIENE COMENTARIOS'
        ELSE N'✅ LURKER PURO'
    END AS [Estado]
FROM Usuario u
JOIN Suscripcion s ON u.id = s.idUsuario
WHERE s.estado = 'Activa'
  AND NOT EXISTS (SELECT 1 FROM UsuarioReaccionPublicacion WHERE idUsuario = u.id)
  AND NOT EXISTS (SELECT 1 FROM Comentario WHERE idUsuario = u.id)
ORDER BY u.fecha_registro DESC;

-- Contar total
SELECT 
    COUNT(*) AS [Total Lurkers],
    'usuarios suscritos sin interacciones' AS [Descripción]
FROM Usuario u
JOIN Suscripcion s ON u.id = s.idUsuario
WHERE s.estado = 'Activa'
  AND NOT EXISTS (SELECT 1 FROM UsuarioReaccionPublicacion WHERE idUsuario = u.id)
  AND NOT EXISTS (SELECT 1 FROM Comentario WHERE idUsuario = u.id);

PRINT '========================================';
PRINT ' LURKERS CREADOS EXITOSAMENTE';
PRINT '========================================';
GO