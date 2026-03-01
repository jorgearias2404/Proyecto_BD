-- ==========================================
-- 5. DETALLES POR TIPO - TEXTOS
-- ==========================================
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'INSERTANDO DETALLES DE TEXTOS';
PRINT '========================================';
GO

-- Limpiar textos existentes
PRINT 'Eliminando textos anteriores...';
DELETE FROM Texto;
PRINT ' Textos anteriores eliminados';
GO

PRINT 'Insertando detalles de textos...';
GO

INSERT INTO Texto (idPublicacion, contenido_html, resumen_gratuito)
SELECT 
    p.id,
    CASE 
        -- Textos largos para contenido exclusivo
        WHEN p.es_publica = 0 THEN 
            '<div class="contenido-exclusivo">' +
            '<h1>' + p.titulo + '</h1>' +
            '<p class="intro">' + 
            CASE ABS(CHECKSUM(NEWID())) % 5
                WHEN 0 THEN 'En este artículo exclusivo para suscriptores, exploramos en profundidad los temas más relevantes que no encontrarás en ningún otro lugar.'
                WHEN 1 THEN 'Bienvenido al contenido premium. Aquí encontrarás análisis detallados, entrevistas exclusivas y material adicional.'
                WHEN 2 THEN 'Este contenido ha sido creado especialmente para nuestros suscriptores más fieles. Disfruta de esta experiencia única.'
                WHEN 3 THEN 'Accede a material inédito, detrás de cámaras y contenido extendido que solo nuestros suscriptores pueden ver.'
                ELSE 'Gracias por ser parte de nuestra comunidad. Como agradecimiento, te compartimos este contenido exclusivo.'
            END +
            '</p>' +
            '<p>' + REPLICATE('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ', 20) + '</p>' +
            '<h2>Puntos clave</h2>' +
            '<ul>' +
            '<li>Primer punto importante sobre ' + p.titulo + '</li>' +
            '<li>Segundo aspecto fundamental a considerar</li>' +
            '<li>Tercer elemento que no puedes perderte</li>' +
            '</ul>' +
            '<p>' + REPLICATE('Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris. ', 15) + '</p>' +
            '<div class="conclusion">' +
            '<h3>Conclusión</h3>' +
            '<p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>' +
            '</div>' +
            '</div>'
        -- Textos más cortos para contenido público
        ELSE
            '<div class="contenido-publico">' +
            '<h1>' + p.titulo + '</h1>' +
            '<p class="intro">' +
            CASE ABS(CHECKSUM(NEWID())) % 5
                WHEN 0 THEN 'En este artículo gratuito, compartimos contigo información valiosa y consejos prácticos.'
                WHEN 1 THEN 'Descubre los aspectos más interesantes de este tema que hemos preparado para ti.'
                WHEN 2 THEN 'Te presentamos una visión general y los puntos más destacados de este contenido.'
                WHEN 3 THEN 'Aprende los fundamentos y conceptos básicos de una manera sencilla y directa.'
                ELSE 'Explora este contenido abierto a toda la comunidad, diseñado para inspirarte.'
            END +
            '</p>' +
            '<p>' + REPLICATE('Contenido informativo y educativo. ', 10) + '</p>' +
            '<p><strong>¿Quieres acceder al contenido completo?</strong> Suscríbete para obtener análisis detallados, ejemplos prácticos y material exclusivo.</p>' +
            '</div>'
    END as contenido_html,
    -- Resumen gratuito (solo para contenido exclusivo)
    CASE 
        WHEN p.es_publica = 0 THEN
            ' RESUMEN GRATUITO: ' + 
            CASE ABS(CHECKSUM(NEWID())) % 4
                WHEN 0 THEN 'En este artículo exclusivo hablamos sobre ' + p.titulo + '. Los suscriptores acceden al análisis completo, ejemplos detallados y casos prácticos.'
                WHEN 1 THEN 'Descubre los secretos mejor guardados de ' + p.titulo + '. Suscríbete para leer el artículo completo.'
                WHEN 2 THEN 'Este contenido premium incluye información privilegiada sobre ' + p.titulo + '. Hazte suscriptor para acceder.'
                ELSE 'Accede al contenido completo de ' + p.titulo + ' haciéndote suscriptor. Incluye análisis profundo y material adicional.'
            END
        ELSE NULL
    END as resumen_gratuito
FROM Publicacion p
WHERE p.tipo_contenido = 'TEXTO'
AND NOT EXISTS (SELECT 1 FROM Texto t WHERE t.idPublicacion = p.id);

PRINT ' Textos insertados correctamente';
GO

-- ==========================================
-- VERIFICAR TEXTOS INSERTADOS (CORREGIDO - SIN LEFT EN TEXT)
-- ==========================================
PRINT '========================================';
PRINT 'VERIFICACIÓN DE TEXTOS:';
PRINT '========================================';

SELECT 
    COUNT(*) as TotalTextos,
    MIN(idPublicacion) as PrimerTexto,
    MAX(idPublicacion) as UltimoTexto,
    SUM(CASE WHEN resumen_gratuito IS NOT NULL THEN 1 ELSE 0 END) as TextosConResumen,
    SUM(CASE WHEN resumen_gratuito IS NULL THEN 1 ELSE 0 END) as TextosPublicos
FROM Texto;
GO

-- Ver muestra de textos insertados (CORREGIDO)
SELECT TOP 10
    t.idPublicacion,
    p.titulo,
    p.es_publica,
    -- Convertir TEXT a VARCHAR para poder usar LEFT
    CASE 
        WHEN LEN(CAST(t.contenido_html AS VARCHAR(MAX))) > 100 
        THEN LEFT(CAST(t.contenido_html AS VARCHAR(MAX)), 100) + '...'
        ELSE CAST(t.contenido_html AS VARCHAR(MAX))
    END as contenido_resumido,
    CASE 
        WHEN t.resumen_gratuito IS NOT NULL 
        THEN CASE 
                WHEN LEN(CAST(t.resumen_gratuito AS VARCHAR(MAX))) > 100 
                THEN LEFT(CAST(t.resumen_gratuito AS VARCHAR(MAX)), 100) + '...'
                ELSE CAST(t.resumen_gratuito AS VARCHAR(MAX))
             END
        ELSE 'SIN RESUMEN (CONTENIDO PÚBLICO)' 
    END as resumen
FROM Texto t
JOIN Publicacion p ON t.idPublicacion = p.id
ORDER BY t.idPublicacion;
GO

-- Estadísticas de longitud de contenido (CORREGIDO)
SELECT 
    'Longitud promedio contenido' as Concepto,
    AVG(LEN(CAST(contenido_html AS VARCHAR(MAX)))) as Valor
FROM Texto
UNION ALL
SELECT 
    'Longitud máxima contenido',
    MAX(LEN(CAST(contenido_html AS VARCHAR(MAX))))
FROM Texto
UNION ALL
SELECT 
    'Longitud mínima contenido',
    MIN(LEN(CAST(contenido_html AS VARCHAR(MAX))))
FROM Texto;

PRINT '========================================';
PRINT 'TEXTOS INSERTADOS CORRECTAMENTE';
PRINT '========================================';
GO