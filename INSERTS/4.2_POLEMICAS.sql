-- ==========================================
-- PUBLICACIONES POLÉMICAS PARA CREADORES 27-30
-- ==========================================
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'CREANDO PUBLICACIONES POLÉMICAS';
PRINT '========================================';
GO

-- ==========================================
-- 1. VERIFICAR QUE LOS CREADORES POLÉMICOS EXISTEN
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id = 27)
BEGIN
    PRINT 'ERROR: Faltan los usuarios 27-30. Debes insertarlos primero.';
    RETURN;
END
GO

-- ==========================================
-- 2. CREAR PUBLICACIONES POLÉMICAS (3 cada uno = 12 publicaciones)
-- ==========================================
PRINT 'Creando publicaciones para creadores polémicos...';

DECLARE @creador_polemico INT;
DECLARE @pub_id INT;

DECLARE cursor_polemicos CURSOR FOR 
    SELECT idUsuario FROM Creador WHERE idUsuario BETWEEN 27 AND 30;

OPEN cursor_polemicos;
FETCH NEXT FROM cursor_polemicos INTO @creador_polemico;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Publicación 1: Muchos comentarios, pocas reacciones
    INSERT INTO Publicacion (idCreador, titulo, fecha_publicacion, es_publica, tipo_contenido)
    VALUES (@creador_polemico, 'Opinión: Lo que nadie se atreve a decir', DATEADD(DAY, -5, GETDATE()), 1, 'TEXTO');
    
    SET @pub_id = SCOPE_IDENTITY();
    
    -- Agregar 25 comentarios (muchos)
    INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
    SELECT TOP 25
        u.id,
        @pub_id,
        NULL,
        CASE ABS(CHECKSUM(NEWID())) % 5
            WHEN 0 THEN 'Totalmente en desacuerdo!'
            WHEN 1 THEN 'Qué estupidez acabo de leer'
            WHEN 2 THEN 'Esto es completamente falso'
            WHEN 3 THEN 'Fuente: de los deseos'
            ELSE 'No puedo creer que pienses así'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 5, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    -- Solo 2 reacciones (pocas)
    INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion)
    SELECT TOP 2
        u.id,
        @pub_id,
        CASE ABS(CHECKSUM(NEWID())) % 2 WHEN 0 THEN 5 ELSE 7 END, -- Me entristece o Me enfurece
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 5, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    -- Publicación 2: Muchos comentarios, cero reacciones
    INSERT INTO Publicacion (idCreador, titulo, fecha_publicacion, es_publica, tipo_contenido)
    VALUES (@creador_polemico, 'La verdad incómoda sobre...', DATEADD(DAY, -10, GETDATE()), 1, 'TEXTO');
    
    SET @pub_id = SCOPE_IDENTITY();
    
    -- Agregar 20 comentarios
    INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
    SELECT TOP 20
        u.id,
        @pub_id,
        NULL,
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Basado en qué evidencia?'
            WHEN 1 THEN 'Reportado por misinformation'
            WHEN 2 THEN 'Comparto pero no estoy de acuerdo'
            ELSE 'Necesitas leer más sobre el tema'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 8, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    -- NO agregar reacciones (0 reacciones) - ratio infinito
    
    -- Publicación 3: 15 comentarios, 1 reacción
    INSERT INTO Publicacion (idCreador, titulo, fecha_publicacion, es_publica, tipo_contenido)
    VALUES (@creador_polemico, 'Por qué todo el mundo está equivocado', DATEADD(DAY, -15, GETDATE()), 1, 'TEXTO');
    
    SET @pub_id = SCOPE_IDENTITY();
    
    -- Agregar 15 comentarios
    INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
    SELECT TOP 15
        u.id,
        @pub_id,
        NULL,
        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN 'Qué argumento tan pobre'
            WHEN 1 THEN 'Explícame tu lógica'
            ELSE 'No entiendo cómo puedes pensar eso'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 12, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    -- Agregar 1 reacción
    INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion)
    SELECT TOP 1
        u.id,
        @pub_id,
        5, -- Me entristece
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 12, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    FETCH NEXT FROM cursor_polemicos INTO @creador_polemico;
END;

CLOSE cursor_polemicos;
DEALLOCATE cursor_polemicos;

PRINT '✅ Publicaciones polémicas creadas (3 por cada creador)';
GO

-- ==========================================
-- 3. VERIFICACIÓN CON LOS NOMBRES CORRECTOS (CORREGIDO)
-- ==========================================
PRINT '';
PRINT 'RESUMEN DE PUBLICACIONES POLÉMICAS:';
SELECT 
    u.nickname,
    COUNT(p.id) AS total_publicaciones  -- Cambié idPublicacion por id
FROM Creador c
JOIN Usuario u ON c.idUsuario = u.id
LEFT JOIN Publicacion p ON c.idUsuario = p.idCreador
WHERE c.idUsuario BETWEEN 27 AND 30
GROUP BY u.nickname;
GO