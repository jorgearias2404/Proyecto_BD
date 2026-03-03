USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'CREANDO 10 USUARIOS LURKERS';
PRINT '========================================';
GO

-- 1. CREAR NUEVOS USUARIOS LURKERS (Dejamos que SQL asigne el ID solo)
PRINT 'Insertando 10 usuarios fantasma...';
INSERT INTO Usuario (email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo)
SELECT 
    'lurker_pro_' + CAST(NEWID() AS NVARCHAR(36)) + '@email.com',
    'hash_seguro_123',
    'Fantasma_' + LEFT(CAST(NEWID() AS NVARCHAR(36)), 8),
    DATEADD(DAY, -20, GETDATE()), 
    '1995-05-05', 
    'MX', 
    1 
FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10)) AS numeros(n);
GO

-- 2. CREAR SUSCRIPCIONES (Usamos un ID de Nivel que SÍ exista en tu tabla)
PRINT 'Asignando suscripciones a los lurkers...';
DECLARE @idNivelReal INT = (SELECT TOP 1 id FROM NivelSuscripcion);

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_fin, precio_pactado, estado)
SELECT 
    u.id,
    @idNivelReal,
    DATEADD(MONTH, -2, GETDATE()), 
    DATEADD(MONTH, 1, GETDATE()), 
    10.00,
    'Activa'
FROM Usuario u
WHERE u.email LIKE 'lurker_pro_%'  -- Filtramos solo a los que acabamos de crear
  AND NOT EXISTS (SELECT 1 FROM Suscripcion WHERE idUsuario = u.id);
GO

-- 3. VERIFICACIÓN
PRINT '========================================';
PRINT '✅ LURKERS INYECTADOS EXITOSAMENTE.';
PRINT '========================================';

SELECT 
    u.nickname AS [Nickname Lurker],
    s.estado AS [Estado Suscripción],
    'Sin interacciones' AS [Estatus]
FROM Usuario u
JOIN Suscripcion s ON u.id = s.idUsuario
WHERE u.email LIKE 'lurker_pro_%';
GO