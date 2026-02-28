-- ==========================================
-- 11. COMENTARIOS (1100 registros: 950 principales + 150 hilos)
-- ==========================================
USE FanHub;
GO

PRINT '========================================';
PRINT 'GENERANDO NUEVOS COMENTARIOS';
PRINT '========================================';
GO

-- ==========================================
-- 1. ELIMINAR COMENTARIOS EXISTENTES
-- ==========================================
PRINT 'Eliminando comentarios existentes...';
DELETE FROM Comentario;
PRINT '✅ Comentarios eliminados';
GO

-- ==========================================
-- 2. CREAR TABLA TEMPORAL (USANDO EL NUEVO NOMBRE)
-- ==========================================
PRINT 'Creando tabla temporal de textos...';

CREATE TABLE #TempTextosComentarios (
    id INT IDENTITY(1,1),
    texto VARCHAR(500)
);

INSERT INTO #TempTextosComentarios (texto) VALUES
('Excelente contenido! Sigue así 👏'),
('Me encantó este video, muy útil gracias'),
('Compartido con mis amigos, todos deberían ver esto'),
('¿Cuándo subirás más contenido?'),
('El mejor creador de la plataforma sin duda'),
('No sabía esto, gracias por la info'),
('Me reí mucho con este video'),
('Qué calidad de contenido, mereces más seguidores'),
('Ya me suscribí, vale totalmente la pena'),
('Esperando la siguiente parte con ansias'),
('Muy buen trabajo, sigue así'),
('Me encanta tu forma de explicar'),
('Compartido en mis redes sociales'),
('Esto es justo lo que necesitaba'),
('Gracias por el contenido gratuito'),
('Increíble, no me esperaba ese final'),
('Eres el mejor, gracias por existir'),
('Este video me salvó la vida'),
('Qué buen tutorial, lo entendí perfecto'),
('Me encanta tu canal, eres único'),
('Sos un capo, gracias por compartir'),
('Vine por el título y me quedé por el contenido'),
('Me suscribí al instante'),
('Calidad de contenido como siempre'),
('No puedo creer que sea gratis esto');

PRINT '✅ Tabla temporal creada';
GO

-- ==========================================
-- 3. GENERAR COMENTARIOS PRINCIPALES (950)
-- ==========================================
PRINT 'Generando 950 comentarios principales...';

DECLARE @comentario_id INT = 1;
DECLARE @idUsuario INT;
DECLARE @idPublicacion INT;
DECLARE @texto VARCHAR(500);
DECLARE @fecha DATETIME;

WHILE @comentario_id <= 950
BEGIN
    -- Seleccionar usuario aleatorio (que no sea creador, id > 26)
    SELECT TOP 1 @idUsuario = id 
    FROM Usuario 
    WHERE id > 26 AND esta_activo = 1
    ORDER BY NEWID();
    
    -- Seleccionar publicación aleatoria
    SELECT TOP 1 @idPublicacion = id 
    FROM Publicacion 
    ORDER BY NEWID();
    
    -- Seleccionar texto aleatorio desde la tabla temporal
    SELECT TOP 1 @texto = texto 
    FROM #TempTextosComentarios 
    ORDER BY NEWID();
    
    -- Generar fecha aleatoria en los últimos 6 meses
    SET @fecha = DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 180, GETDATE());
    
    -- Evitar múltiples comentarios del mismo usuario en la misma publicación
    IF NOT EXISTS (
        SELECT 1 FROM Comentario 
        WHERE idUsuario = @idUsuario 
        AND idPublicacion = @idPublicacion 
        AND idComentarioPadre IS NULL
    )
    BEGIN
        INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
        VALUES (@idUsuario, @idPublicacion, NULL, @texto, @fecha);
        
        SET @comentario_id = @comentario_id + 1;
    END;
    
    -- Mostrar progreso cada 100 comentarios
    IF @comentario_id % 100 = 0
        PRINT '  ✓ ' + CAST(@comentario_id AS VARCHAR) + ' comentarios principales insertados...';
END;

PRINT '✅ 950 comentarios principales insertados';
GO

-- ==========================================
-- 4. VERIFICAR QUE HAY COMENTARIOS PRINCIPALES
-- ==========================================
DECLARE @TotalPrincipales INT;
SELECT @TotalPrincipales = COUNT(*) FROM Comentario WHERE idComentarioPadre IS NULL;

IF @TotalPrincipales = 0
BEGIN
    PRINT 'ERROR: No hay comentarios principales para crear hilos.';
END
ELSE
BEGIN
    PRINT 'Hay ' + CAST(@TotalPrincipales AS VARCHAR) + ' comentarios principales para crear hilos.';
END
GO

-- ==========================================
-- 5. GENERAR HILOS DE CONVERSACIÓN (150 respuestas)
-- ==========================================
PRINT 'Generando 150 hilos de conversación...';

DECLARE @hilo_id INT = 1;
DECLARE @idUsuarioResp INT;
DECLARE @idComentarioPadre INT;
DECLARE @idPublicacionResp INT;
DECLARE @textoResp VARCHAR(500);
DECLARE @fechaResp DATETIME;

WHILE @hilo_id <= 150
BEGIN
    -- Seleccionar usuario aleatorio
    SELECT TOP 1 @idUsuarioResp = id 
    FROM Usuario 
    WHERE id > 26 AND esta_activo = 1
    ORDER BY NEWID();
    
    -- Seleccionar un comentario principal aleatorio para responder
    SELECT TOP 1 @idComentarioPadre = id, @idPublicacionResp = idPublicacion
    FROM Comentario 
    WHERE idComentarioPadre IS NULL  -- Solo comentarios principales
    ORDER BY NEWID();
    
    -- Verificar que se obtuvieron valores válidos
    IF @idComentarioPadre IS NOT NULL AND @idPublicacionResp IS NOT NULL
    BEGIN
        -- Seleccionar texto de respuesta
        SET @textoResp = CASE ABS(CHECKSUM(NEWID())) % 5
            WHEN 0 THEN 'Totalmente de acuerdo!'
            WHEN 1 THEN 'Yo también pienso igual 👍'
            WHEN 2 THEN 'Gracias por el comentario'
            WHEN 3 THEN 'Comparto tu opinión'
            ELSE 'Qué buena observación'
        END;
        
        -- Generar fecha unos días después del comentario padre
        SELECT @fechaResp = DATEADD(DAY, 1 + ABS(CHECKSUM(NEWID())) % 7, fecha)
        FROM Comentario WHERE id = @idComentarioPadre;
        
        -- Evitar respuestas duplicadas
        IF NOT EXISTS (
            SELECT 1 FROM Comentario 
            WHERE idComentarioPadre = @idComentarioPadre 
            AND idUsuario = @idUsuarioResp
        )
        BEGIN
            INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
            VALUES (@idUsuarioResp, @idPublicacionResp, @idComentarioPadre, @textoResp, @fechaResp);
            
            SET @hilo_id = @hilo_id + 1;
        END;
    END;
    
    -- Mostrar progreso cada 30 hilos
    IF @hilo_id % 30 = 0
        PRINT '  ✓ ' + CAST(@hilo_id AS VARCHAR) + ' hilos insertados...';
END;

PRINT '✅ 150 hilos de conversación insertados';
GO

-- ==========================================
-- 6. VERIFICAR ESTADÍSTICAS FINALES
-- ==========================================
PRINT '========================================';
PRINT 'VERIFICACIÓN DE COMENTARIOS:';
PRINT '========================================';

SELECT 
    'Total comentarios' as Concepto,
    COUNT(*) as Valor
FROM Comentario
UNION ALL
SELECT 
    'Comentarios principales',
    COUNT(*)
FROM Comentario
WHERE idComentarioPadre IS NULL
UNION ALL
SELECT 
    'Respuestas (hilos)',
    COUNT(*)
FROM Comentario
WHERE idComentarioPadre IS NOT NULL
UNION ALL
SELECT 
    'Usuarios que comentaron',
    COUNT(DISTINCT idUsuario)
FROM Comentario
UNION ALL
SELECT 
    'Publicaciones con comentarios',
    COUNT(DISTINCT idPublicacion)
FROM Comentario;

-- ==========================================
-- 7. LIMPIAR TABLA TEMPORAL
-- ==========================================
DROP TABLE #TempTextosComentarios;

-- ==========================================
-- 8. VER MUESTRA DE COMENTARIOS
-- ==========================================
PRINT 'Muestra de comentarios:';

SELECT TOP 20
    'ID: ' + CAST(c.id AS VARCHAR) as ComentarioID,
    u.nickname as Usuario,
    CASE 
        WHEN LEN(CAST(c.texto AS VARCHAR(MAX))) > 50 
        THEN LEFT(CAST(c.texto AS VARCHAR(MAX)), 50) + '...'
        ELSE CAST(c.texto AS VARCHAR(MAX))
    END as Texto,
    c.fecha as Fecha,
    CASE WHEN c.idComentarioPadre IS NULL THEN 'PRINCIPAL' ELSE 'RESPUESTA' END as Tipo
FROM Comentario c
JOIN Usuario u ON c.idUsuario = u.id
ORDER BY c.fecha DESC;

PRINT '========================================';
PRINT '✅ COMENTARIOS GENERADOS EXITOSAMENTE';
PRINT '========================================';
GO