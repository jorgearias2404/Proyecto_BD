-- ==========================================
-- 11. COMENTARIOS (1100 registros: 950 principales + 150 hilos)
-- ==========================================
USE FanHub_BD;
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
PRINT ' Comentarios eliminados';
GO

-- ==========================================
-- 2. CREAR TABLA TEMPORAL (VERIFICAR QUE NO EXISTA)
-- ==========================================
PRINT 'Creando tabla temporal de textos...';

-- Eliminar si existe
IF OBJECT_ID('tempdb..#TempTextosComentarios') IS NOT NULL
    DROP TABLE #TempTextosComentarios;

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

PRINT ' Tabla temporal creada';
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
    WHERE (id BETWEEN 27 AND 50 OR id > 60) AND esta_activo = 1
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

PRINT ' 950 comentarios principales insertados';
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
    WHERE (id BETWEEN 27 AND 50 OR id > 60) AND esta_activo = 1
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

PRINT ' 150 hilos de conversación insertados';
GO

-- ==========================================
-- 5B. AGREGAR COMENTARIOS ADICIONALES PARA CREADORES POLÉMICOS (27-30)
-- ==========================================
PRINT '========================================';
PRINT 'AGREGANDO COMENTARIOS A PUBLICACIONES POLÉMICAS';
PRINT '========================================';

-- Declarar todas las variables al inicio del bloque
DECLARE @comentarios_polemicos TABLE (texto VARCHAR(500));
DECLARE @polemico_id INT;
DECLARE @pub_polemica_id INT;
DECLARE @usuario_random INT;
DECLARE @texto_polemico VARCHAR(500);
DECLARE @fecha_polemica DATETIME;
DECLARE @comentario_count INT = 0;
DECLARE @objetivo_comentarios INT = 100;
DECLARE @i INT;
DECLARE @temp_id INT;
DECLARE @comentarios_por_pub INT;

INSERT INTO @comentarios_polemicos VALUES
-- Comentarios negativos/confrontativos
('Esto es completamente falso, haz tu investigación'),
('No puedo creer que alguien piense así'),
('Qué ridículo, mejor dedícate a otra cosa'),
('Basado en ninguna evidencia científica'),
('Reportado por desinformación'),
('Deberían eliminar este contenido'),
('Eres parte del problema que criticas'),
('Qué ignorancia por favor'),
('Vete de la plataforma con estas ideas'),
('Este tipo de contenido daña a la comunidad'),
-- Comentarios de apoyo
('Finalmente alguien con valor para decirlo!'),
('Comparto 100% tu opinión, gracias por hablar'),
('Me alegra que alguien diga esto abiertamente'),
('Tienes todo mi respeto y apoyo'),
('Es valiente publicar esto, te admiro'),
-- Comentarios de debate/preguntas
('¿Puedes compartir tus fuentes? Me interesa'),
('No estoy de acuerdo pero respeto tu opinión'),
('Explícame tu punto con más detalle'),
('Desde otra perspectiva, podría ser que...'),
('Interesante punto, pero qué opinas de...'),
-- Comentarios sarcásticos/burlas
('Claro, y yo soy el rey de Inglaterra'),
('Fuente: Arial 12'),
('Ya salió el experto en temas que no sabe'),
('Todo lo que no entiendo es falso, básicamente');

PRINT 'Agregando comentarios a publicaciones polémicas...';

-- Cursor para cada publicación polémica
DECLARE cursor_pubs_polemicas CURSOR FOR 
    SELECT p.id, p.idCreador
    FROM Publicacion p
    WHERE p.idCreador BETWEEN 27 AND 30;

OPEN cursor_pubs_polemicas;
FETCH NEXT FROM cursor_pubs_polemicas INTO @pub_polemica_id, @polemico_id;

WHILE @@FETCH_STATUS = 0 AND @comentario_count < @objetivo_comentarios
BEGIN
    -- Agregar entre 5 y 15 comentarios por publicación polémica
    SET @comentarios_por_pub = 5 + ABS(CHECKSUM(NEWID())) % 11;
    SET @i = 1;
    
    WHILE @i <= @comentarios_por_pub AND @comentario_count < @objetivo_comentarios
    BEGIN
        -- Seleccionar usuario (puede ser cualquier usuario activo, incluso el propio creador)
        SELECT TOP 1 @usuario_random = id 
        FROM Usuario 
        WHERE (id BETWEEN 27 AND 50 OR id > 60) AND esta_activo = 1
        ORDER BY NEWID();
        
        -- Seleccionar texto aleatorio de los comentarios polémicos
        SELECT TOP 1 @texto_polemico = texto 
        FROM @comentarios_polemicos 
        ORDER BY NEWID();
        
        -- Fecha aleatoria más reciente (últimos 15 días)
        SET @fecha_polemica = DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 15, GETDATE());
        
        -- Insertar comentario
        INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
        VALUES (@usuario_random, @pub_polemica_id, NULL, @texto_polemico, @fecha_polemica);
        
        SET @temp_id = SCOPE_IDENTITY();
        SET @comentario_count = @comentario_count + 1;
        
        -- 30% de probabilidad de agregar una respuesta a este comentario
        IF ABS(CHECKSUM(NEWID())) % 10 < 3 AND @comentario_count < @objetivo_comentarios
        BEGIN
            -- Seleccionar otro usuario diferente
            SELECT TOP 1 @usuario_random = id 
            FROM Usuario 
            WHERE esta_activo = 1 AND id != @usuario_random
            ORDER BY NEWID();
            
            SET @texto_polemico = CASE ABS(CHECKSUM(NEWID())) % 4
                WHEN 0 THEN 'Exacto! Eso mismo pienso'
                WHEN 1 THEN 'No estoy de acuerdo con tu comentario'
                WHEN 2 THEN 'Gracias por aportar al debate'
                ELSE 'Jajaja buen punto'
            END;
            
            SET @fecha_polemica = DATEADD(HOUR, 1 + ABS(CHECKSUM(NEWID())) % 24, @fecha_polemica);
            
            INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
            VALUES (@usuario_random, @pub_polemica_id, @temp_id, @texto_polemico, @fecha_polemica);
            
            SET @comentario_count = @comentario_count + 1;
        END;
        
        -- Mostrar progreso
        IF @comentario_count % 20 = 0
            PRINT '  ✓ ' + CAST(@comentario_count AS VARCHAR) + ' comentarios polémicos agregados...';
        
        SET @i = @i + 1;
    END;
    
    FETCH NEXT FROM cursor_pubs_polemicas INTO @pub_polemica_id, @polemico_id;
END;

CLOSE cursor_pubs_polemicas;
DEALLOCATE cursor_pubs_polemicas;

PRINT '✅ ' + CAST(@comentario_count AS VARCHAR) + ' comentarios adicionales agregados a publicaciones polémicas';
GO

-- ==========================================
-- 5C. CREAR HILOS DE DISCUSIÓN EN PUBLICACIONES POLÉMICAS
-- ==========================================
PRINT 'Creando hilos de discusión en publicaciones polémicas...';

-- Declarar variables para este bloque
DECLARE @hilo_polemico_id INT = 1;
DECLARE @hilos_objetivo INT = 40;
DECLARE @comentario_base INT;
DECLARE @respuesta_texto VARCHAR(500);
DECLARE @idPublicacionRespTemp INT;
DECLARE @ultimo_comentario_id INT;
DECLARE @cadena_count INT;
DECLARE @respuestas_en_cadena INT;
DECLARE @usuario_random_hilo INT;
DECLARE @fechaResp_hilo DATETIME;

WHILE @hilo_polemico_id <= @hilos_objetivo
BEGIN
    -- Seleccionar un comentario de una publicación polémica
    SELECT TOP 1 @comentario_base = c.id, @idPublicacionRespTemp = c.idPublicacion
    FROM Comentario c
    JOIN Publicacion p ON c.idPublicacion = p.id
    WHERE p.idCreador BETWEEN 27 AND 30
    AND c.idComentarioPadre IS NULL
    ORDER BY NEWID();
    
    IF @comentario_base IS NOT NULL
    BEGIN
        -- Crear una respuesta en cadena
        SET @respuestas_en_cadena = 2 + ABS(CHECKSUM(NEWID())) % 4;
        SET @ultimo_comentario_id = @comentario_base;
        SET @cadena_count = 1;
        
        WHILE @cadena_count <= @respuestas_en_cadena AND @hilo_polemico_id <= @hilos_objetivo
        BEGIN
            -- Seleccionar usuario diferente
            SELECT TOP 1 @usuario_random_hilo = id 
            FROM Usuario 
            WHERE (id BETWEEN 27 AND 50 OR id > 60) AND esta_activo = 1
            ORDER BY NEWID();
            
            -- Texto según posición en la cadena
            SET @respuesta_texto = CASE @cadena_count
                WHEN 1 THEN 'Totalmente de acuerdo con el comentario original'
                WHEN 2 THEN 'Yo también pienso igual, pero habría que considerar...'
                WHEN 3 THEN 'Exacto! Por eso este post es tan polémico'
                ELSE 'Esta discusión es muy interesante'
            END;
            
            -- Fecha progresiva
            SELECT @fechaResp_hilo = DATEADD(HOUR, 2 + @cadena_count * 3, fecha)
            FROM Comentario WHERE id = @ultimo_comentario_id;
            
            INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
            VALUES (@usuario_random_hilo, @idPublicacionRespTemp, @ultimo_comentario_id, @respuesta_texto, @fechaResp_hilo);
            
            SET @ultimo_comentario_id = SCOPE_IDENTITY();
            SET @hilo_polemico_id = @hilo_polemico_id + 1;
            SET @cadena_count = @cadena_count + 1;
        END;
    END;
END;

PRINT '✅ ' + CAST(@hilo_polemico_id - 1 AS VARCHAR) + ' hilos de discusión creados';
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

PRINT '';
PRINT '========================================';
PRINT 'ESTADÍSTICAS DE PUBLICACIONES POLÉMICAS:';
PRINT '========================================';

SELECT 
    u.nickname AS Creador,
    COUNT(DISTINCT p.id) AS Publicaciones,
    COUNT(c.id) AS TotalComentarios,
    ISNULL(AVG(comentarios_por_pub.cantidad), 0) AS PromedioComentarios,
    ISNULL(MIN(comentarios_por_pub.cantidad), 0) AS MinComentarios,
    ISNULL(MAX(comentarios_por_pub.cantidad), 0) AS MaxComentarios
FROM Creador cr
JOIN Usuario u ON cr.idUsuario = u.id
LEFT JOIN Publicacion p ON cr.idUsuario = p.idCreador
LEFT JOIN Comentario c ON p.id = c.idPublicacion
LEFT JOIN (
    SELECT idPublicacion, COUNT(*) AS cantidad
    FROM Comentario
    GROUP BY idPublicacion
) comentarios_por_pub ON p.id = comentarios_por_pub.idPublicacion
WHERE cr.idUsuario BETWEEN 27 AND 30
GROUP BY u.nickname
ORDER BY TotalComentarios DESC;

PRINT '';
PRINT 'MUESTRA DE COMENTARIOS EN PUBLICACIONES POLÉMICAS:';
SELECT TOP 15
    u.nickname AS Creador,
    p.titulo,
    cu.nickname AS Comentarista,
    LEFT(c.texto, 60) AS Comentario,
    c.fecha,
    CASE WHEN c.idComentarioPadre IS NULL THEN 'PRINCIPAL' ELSE 'RESPUESTA' END AS Tipo
FROM Comentario c
JOIN Publicacion p ON c.idPublicacion = p.id
JOIN Creador cr ON p.idCreador = cr.idUsuario
JOIN Usuario u ON cr.idUsuario = u.id
JOIN Usuario cu ON c.idUsuario = cu.id
WHERE cr.idUsuario BETWEEN 27 AND 30
ORDER BY c.fecha DESC;
GO

-- ==========================================
-- 7. LIMPIAR TABLA TEMPORAL
-- ==========================================
IF OBJECT_ID('tempdb..#TempTextosComentarios') IS NOT NULL
    DROP TABLE #TempTextosComentarios;

PRINT '========================================';
PRINT 'COMENTARIOS GENERADOS EXITOSAMENTE';
PRINT '========================================';
GO