-- =====================================================
-- Inserts_COMPLETO.sql - Carga masiva de datos
-- =====================================================

USE FanHub;
GO

PRINT '========================================';
PRINT 'INICIANDO CARGA MASIVA DE DATOS';
PRINT '========================================';
GO

-- ==========================================
-- 1. USUARIOS (260)
-- ==========================================
PRINT 'Insertando 260 usuarios...';

DECLARE @i INT = 1;
WHILE @i <= 260
BEGIN
    INSERT INTO Usuario (email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo)
    VALUES (
        CONCAT('usuario', @i, '@gmail.com'),
        CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT('pass', @i)), 2),
        CONCAT('user', @i),
        DATEADD(DAY, -@i, GETDATE()),
        DATEADD(YEAR, -18 - (@i % 30), GETDATE()),
        CASE @i % 10 
            WHEN 0 THEN 'España'
            WHEN 1 THEN 'México'
            WHEN 2 THEN 'Argentina'
            WHEN 3 THEN 'Colombia'
            WHEN 4 THEN 'Chile'
            ELSE 'Perú'
        END,
        1
    );
    SET @i = @i + 1;
END;
PRINT '✅ 260 usuarios insertados';
GO

-- ==========================================
-- 2. CREADORES (26)
-- ==========================================
PRINT 'Insertando 26 creadores...';

INSERT INTO Creador (idUsuario, biografia, banco_nombre, banco_cuenta, es_nsfw, idCategoria)
SELECT 
    u.id,
    CASE (u.id % 10)
        WHEN 1 THEN 'Gamer profesional. Gameplays y streams diarios.'
        WHEN 2 THEN 'Entrenador personal. Rutinas de ejercicio y nutrición.'
        WHEN 3 THEN 'Tech reviewer. Análisis de gadgets y tecnología.'
        WHEN 4 THEN 'Artista digital. Ilustraciones y comisiones.'
        WHEN 5 THEN 'Músico. Covers y lecciones de guitarra.'
        WHEN 6 THEN 'Chef. Recetas fáciles y rápidas.'
        WHEN 7 THEN 'Viajero. Guías y tips de viajes.'
        WHEN 8 THEN 'Profesor. Clases de matemáticas y física.'
        WHEN 9 THEN 'Comediante. Sketches y stand-up.'
        ELSE 'Creador de contenido versátil.'
    END,
    CASE (u.id % 4)
        WHEN 0 THEN 'Banco Santander'
        WHEN 1 THEN 'BBVA'
        WHEN 2 THEN 'Banco de Chile'
        ELSE 'Bancolombia'
    END,
    CONCAT(
        CAST(1000000000 + FLOOR(RAND(CHECKSUM(NEWID())) * 900000000) AS VARCHAR),
        CAST(1000 + FLOOR(RAND(CHECKSUM(NEWID())) * 9000) AS VARCHAR)
    ),
    CASE WHEN u.id % 13 = 0 THEN 1 ELSE 0 END,
    (u.id % 10) + 1
FROM Usuario u
WHERE u.id <= 26;
PRINT '✅ 26 creadores insertados';
GO

-- ==========================================
-- 3. NIVELES DE SUSCRIPCIÓN
-- ==========================================
PRINT 'Insertando niveles de suscripción...';

DECLARE @creador_id INT;
DECLARE @num_niveles INT;
DECLARE @precio_base DECIMAL(10,2);
DECLARE @es_nsfw BIT;

DECLARE cursor_creadores CURSOR FOR 
    SELECT idUsuario, es_nsfw FROM Creador;

OPEN cursor_creadores;
FETCH NEXT FROM cursor_creadores INTO @creador_id, @es_nsfw;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @num_niveles = 1 + FLOOR(RAND()*3);
    SET @precio_base = CASE WHEN @es_nsfw = 1 THEN 14.99 ELSE 7.99 END;

    INSERT INTO NivelSuscripcion (idCreador, nombre, descripcion, precio_actual, orden)
    VALUES (@creador_id, 'Básico', 'Acceso a contenido general.', @precio_base, 1);

    IF @num_niveles >= 2
    BEGIN
        INSERT INTO NivelSuscripcion (idCreador, nombre, descripcion, precio_actual, orden)
        VALUES (@creador_id, 'Premium', 'Acceso a contenido exclusivo.', @precio_base * 2.5, 2);
    END;

    IF @num_niveles >= 3
    BEGIN
        INSERT INTO NivelSuscripcion (idCreador, nombre, descripcion, precio_actual, orden)
        VALUES (@creador_id, 'VIP', 'Acceso completo + personalizado.', @precio_base * 5, 3);
    END;

    FETCH NEXT FROM cursor_creadores INTO @creador_id, @es_nsfw;
END;

CLOSE cursor_creadores;
DEALLOCATE cursor_creadores;
PRINT '✅ Niveles de suscripción insertados';
GO

-- ==========================================
-- 4. PUBLICACIONES (850)
-- ==========================================
PRINT 'Insertando 850 publicaciones...';

DECLARE @pub_id INT = 1;
DECLARE @creador_rand INT;
DECLARE @tipo_pub VARCHAR(10);
DECLARE @titulo_pub VARCHAR(255);
DECLARE @es_publica BIT;

SELECT idUsuario INTO #TempCreadores FROM Creador;

WHILE @pub_id <= 850
BEGIN
    SELECT TOP 1 @creador_rand = idUsuario FROM #TempCreadores ORDER BY NEWID();

    SET @tipo_pub = CASE 
        WHEN @pub_id % 3 = 1 THEN 'VIDEO'
        WHEN @pub_id % 3 = 2 THEN 'TEXTO'
        ELSE 'IMAGEN'
    END;

    SET @es_publica = CASE WHEN RAND() < 0.7 THEN 1 ELSE 0 END;
    SET @titulo_pub = 'Publicación ' + CAST(@pub_id AS VARCHAR) + ' - ' + @tipo_pub;

    INSERT INTO Publicacion (idCreador, titulo, fecha_publicacion, es_publica, tipo_contenido)
    VALUES (
        @creador_rand,
        @titulo_pub,
        DATEADD(DAY, -FLOOR(RAND()*180), GETDATE()),
        @es_publica,
        @tipo_pub
    );

    SET @pub_id = @pub_id + 1;
END;

DROP TABLE #TempCreadores;
PRINT '✅ 850 publicaciones insertadas';
GO

-- ==========================================
-- 5. DETALLES POR TIPO
-- ==========================================
PRINT 'Insertando detalles de videos...';
INSERT INTO Video (idPublicacion, duracion_seg, resolucion, url_stream)
SELECT 
    p.id,
    60 + FLOOR(RAND()*3600),
    CASE FLOOR(RAND()*3) WHEN 0 THEN '720p' WHEN 1 THEN '1080p' ELSE '4K' END,
    'https://stream.fanhub.com/video/' + CONVERT(VARCHAR, p.id)
FROM Publicacion p WHERE p.tipo_contenido = 'VIDEO';
PRINT '✅ Videos insertados';

PRINT 'Insertando detalles de textos...';
INSERT INTO Texto (idPublicacion, contenido_html, resumen_gratuito)
SELECT 
    p.id,
    '<p>Contenido detallado de la publicación.</p>',
    CASE WHEN p.es_publica = 0 THEN 'Resumen gratuito' ELSE NULL END
FROM Publicacion p WHERE p.tipo_contenido = 'TEXTO';
PRINT '✅ Textos insertados';

PRINT 'Insertando detalles de imágenes...';
INSERT INTO Imagen (idPublicacion, ancho, alto, formato, alt_text, url_imagen)
SELECT 
    p.id,
    1920, 1080, 'JPEG', p.titulo,
    'https://images.fanhub.com/' + CONVERT(VARCHAR, p.id) + '.jpg'
FROM Publicacion p WHERE p.tipo_contenido = 'IMAGEN';
PRINT '✅ Imágenes insertadas';
GO

-- ==========================================
-- 6. ETIQUETAS
-- ==========================================
PRINT 'Insertando etiquetas...';

INSERT INTO Etiqueta (nombre)
SELECT nombre FROM (
    VALUES 
    ('Gaming'), ('PC'), ('PlayStation'), ('Xbox'), ('Nintendo'),
    ('Fitness'), ('Yoga'), ('Cardio'), ('Nutrición'),
    ('Tecnología'), ('IA'), ('Programación'), ('Hardware'),
    ('Música'), ('Rock'), ('Pop'), ('Electrónica'),
    ('Cocina'), ('Recetas'), ('Postres'),
    ('Viajes'), ('Aventura'), ('Playas'),
    ('Moda'), ('Streetwear'), ('Maquillaje'),
    ('Educación'), ('Tutorial'), ('Consejos'),
    ('Comedia'), ('Memes'), ('Humor'),
    ('Arte'), ('Digital'), ('Fotografía')
) AS nuevas(nombre)
WHERE NOT EXISTS (SELECT 1 FROM Etiqueta e WHERE e.nombre = nuevas.nombre);
PRINT '✅ Etiquetas insertadas';
GO

-- ==========================================
-- 7. ASOCIACIONES ETIQUETAS-PUBLICACIONES
-- ==========================================
PRINT 'Asociando etiquetas a publicaciones...';

INSERT INTO PublicacionEtiqueta (idPublicacion, idEtiqueta)
SELECT DISTINCT
    p.id,
    e.id
FROM Publicacion p
CROSS JOIN Etiqueta e
WHERE RAND(CHECKSUM(NEWID())) < 0.25
AND NOT EXISTS (
    SELECT 1 FROM PublicacionEtiqueta pe 
    WHERE pe.idPublicacion = p.id AND pe.idEtiqueta = e.id
);
PRINT '✅ Asociaciones insertadas';
GO

-- ==========================================
-- 8. MÉTODOS DE PAGO
-- ==========================================
PRINT 'Insertando métodos de pago...';

INSERT INTO MetodoPago (idUsuario, ultimos_4_digitos, marca, titular, fecha_expiracion, es_predeterminado)
SELECT 
    u.id,
    RIGHT('0000' + CAST(1000 + FLOOR(RAND(CHECKSUM(NEWID())) * 9000) AS VARCHAR), 4),
    CASE FLOOR(RAND(CHECKSUM(NEWID())) * 4)
        WHEN 0 THEN 'Visa'
        WHEN 1 THEN 'Mastercard'
        WHEN 2 THEN 'American Express'
        ELSE 'Discover'
    END,
    u.nickname,
    DATEADD(YEAR, 3, GETDATE()),
    CASE WHEN RAND(CHECKSUM(NEWID())) < 0.3 THEN 1 ELSE 0 END
FROM Usuario u
WHERE RAND(CHECKSUM(NEWID())) < 0.7;
PRINT '✅ Métodos de pago insertados';
GO

-- ==========================================
-- 9. SUSCRIPCIONES (550)
-- ==========================================
PRINT 'Insertando 550 suscripciones...';

DECLARE @sub_id INT = 1;
DECLARE @usuario_sub INT;
DECLARE @nivel_sub INT;
DECLARE @precio_sub DECIMAL(10,2);
DECLARE @fecha_inicio DATETIME;
DECLARE @estado VARCHAR(20);

WHILE @sub_id <= 550
BEGIN
    SELECT TOP 1 @usuario_sub = id FROM Usuario WHERE id > 26 ORDER BY NEWID();
    SELECT TOP 1 @nivel_sub = id, @precio_sub = precio_actual FROM NivelSuscripcion ORDER BY NEWID();

    SET @fecha_inicio = DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 365), GETDATE());
    SET @estado = CASE 
        WHEN RAND(CHECKSUM(NEWID())) < 0.6 THEN 'Activa'
        WHEN RAND(CHECKSUM(NEWID())) < 0.8 THEN 'Cancelada'
        ELSE 'Vencida'
    END;

    INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado)
    VALUES (
        @usuario_sub,
        @nivel_sub,
        @fecha_inicio,
        DATEADD(MONTH, 1, @fecha_inicio),
        CASE 
            WHEN @estado = 'Activa' THEN NULL
            ELSE DATEADD(MONTH, FLOOR(RAND(CHECKSUM(NEWID())) * 6), @fecha_inicio)
        END,
        @estado,
        @precio_sub
    );

    SET @sub_id = @sub_id + 1;
END;
PRINT '✅ 550 suscripciones insertadas';
GO

-- ==========================================
-- 10. FACTURAS
-- ==========================================
PRINT 'Insertando facturas...';

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total)
SELECT 
    s.id,
    CONCAT(
        FORMAT(GETDATE(), 'yyyyMMdd'), '-',
        s.idUsuario, '-',
        s.id, '-',
        FLOOR(RAND(CHECKSUM(NEWID())) * 10000)
    ),
    DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * 15), s.fecha_inicio),
    s.precio_pactado,
    s.precio_pactado * 0.16,
    s.precio_pactado * 1.16
FROM Suscripcion s
WHERE NOT EXISTS (SELECT 1 FROM Factura f WHERE f.idSuscripcion = s.id);
PRINT '✅ Facturas insertadas';
GO

-- ==========================================
-- 11. REACCIONES (1600)
-- ==========================================
PRINT 'Insertando 1600 reacciones...';

DECLARE @reaccion_id INT = 1;

WHILE @reaccion_id <= 1600
BEGIN
    INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion)
    SELECT TOP 1
        u.id,
        p.id,
        1 + FLOOR(RAND(CHECKSUM(NEWID())) * 7),
        DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 180), GETDATE())
    FROM Usuario u, Publicacion p
    WHERE NOT EXISTS (
        SELECT 1 FROM UsuarioReaccionPublicacion urp
        WHERE urp.idUsuario = u.id AND urp.idPublicacion = p.id
    )
    ORDER BY NEWID();

    SET @reaccion_id = @reaccion_id + 1;
END;
PRINT '✅ 1600 reacciones insertadas';
GO

-- ==========================================
-- 12. COMENTARIOS (950 principales)
-- ==========================================
PRINT 'Insertando 950 comentarios principales...';

DECLARE @comentario_id INT = 1;
DECLARE @textos TABLE (id INT, texto VARCHAR(200));
INSERT INTO @textos VALUES
(1, 'Excelente contenido! Sigue así 👏'),
(2, 'Me encantó este video, muy útil gracias'),
(3, 'Compartido con mis amigos'),
(4, '¿Cuándo subirás más contenido?'),
(5, 'El mejor creador de la plataforma');

WHILE @comentario_id <= 950
BEGIN
    INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
    SELECT TOP 1
        u.id,
        p.id,
        NULL,
        (SELECT TOP 1 texto FROM @textos ORDER BY NEWID()),
        DATEADD(DAY, -FLOOR(RAND(CHECKSUM(NEWID())) * 180), GETDATE())
    FROM Usuario u, Publicacion p
    WHERE NOT EXISTS (
        SELECT 1 FROM Comentario c 
        WHERE c.idUsuario = u.id AND c.idPublicacion = p.id
    )
    ORDER BY NEWID();

    SET @comentario_id = @comentario_id + 1;
END;
PRINT '✅ 950 comentarios principales insertados';

-- ==========================================
-- 13. HILOS DE CONVERSACIÓN (150)
-- ==========================================
PRINT 'Insertando 150 hilos de conversación...';

DECLARE @hilo_id INT = 1;

WHILE @hilo_id <= 150
BEGIN
    INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
    SELECT TOP 1
        u.id,
        c.idPublicacion,
        c.id,
        'Respuesta al comentario',
        DATEADD(DAY, FLOOR(RAND(CHECKSUM(NEWID())) * 7), c.fecha)
    FROM Usuario u, Comentario c
    WHERE c.idComentarioPadre IS NULL
    ORDER BY NEWID();

    SET @hilo_id = @hilo_id + 1;
END;
PRINT '✅ 150 hilos insertados';
GO

-- ==========================================
-- 14. VERIFICACIÓN FINAL
-- ==========================================
PRINT '========================================';
PRINT 'VERIFICACIÓN FINAL';
PRINT '========================================';

SELECT 
    'USUARIOS' as Tabla, COUNT(*) as Registros FROM Usuario
UNION ALL SELECT 'CREADORES', COUNT(*) FROM Creador
UNION ALL SELECT 'CATEGORIAS', COUNT(*) FROM Categoria
UNION ALL SELECT 'TIPOS_REACCION', COUNT(*) FROM TipoReaccion
UNION ALL SELECT 'METODOS_PAGO', COUNT(*) FROM MetodoPago
UNION ALL SELECT 'NIVELES_SUSCRIPCION', COUNT(*) FROM NivelSuscripcion
UNION ALL SELECT 'PUBLICACIONES', COUNT(*) FROM Publicacion
UNION ALL SELECT 'VIDEOS', COUNT(*) FROM Video
UNION ALL SELECT 'TEXTOS', COUNT(*) FROM Texto
UNION ALL SELECT 'IMAGENES', COUNT(*) FROM Imagen
UNION ALL SELECT 'SUSCRIPCIONES', COUNT(*) FROM Suscripcion
UNION ALL SELECT 'FACTURAS', COUNT(*) FROM Factura
UNION ALL SELECT 'REACCIONES', COUNT(*) FROM UsuarioReaccionPublicacion
UNION ALL SELECT 'COMENTARIOS', COUNT(*) FROM Comentario
UNION ALL SELECT 'ETIQUETAS', COUNT(*) FROM Etiqueta
UNION ALL SELECT 'PUBLICACIONES_ETIQUETAS', COUNT(*) FROM PublicacionEtiqueta
ORDER BY Tabla;
GO

PRINT '========================================';
PRINT '✅ CARGA MASIVA COMPLETADA EXITOSAMENTE';
PRINT '========================================';
GO