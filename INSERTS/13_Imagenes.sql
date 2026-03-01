-- ==========================================
-- 13. DETALLES POR TIPO - IMÁGENES
-- ==========================================
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'INSERTANDO DETALLES DE IMÁGENES';
PRINT '========================================';
GO

-- Limpiar imágenes existentes
PRINT 'Eliminando imágenes anteriores...';
DELETE FROM Imagen;
PRINT ' Imágenes anteriores eliminadas';
GO

PRINT 'Insertando detalles de imágenes...';
GO

INSERT INTO Imagen (idPublicacion, ancho, alto, formato, alt_text, url_imagen)
SELECT 
    p.id,
    CASE ABS(CHECKSUM(NEWID())) % 4
        WHEN 0 THEN 640
        WHEN 1 THEN 1024
        WHEN 2 THEN 1920
        ELSE 3840
    END as ancho,
    CASE ABS(CHECKSUM(NEWID())) % 4
        WHEN 0 THEN 480
        WHEN 1 THEN 768
        WHEN 2 THEN 1080
        ELSE 2160
    END as alto,
    CASE ABS(CHECKSUM(NEWID())) % 3
        WHEN 0 THEN 'JPEG'
        WHEN 1 THEN 'PNG'
        ELSE 'WEBP'
    END as formato,
    LEFT(p.titulo, 100) as alt_text,
    'https://images.fanhub.com/' + CAST(p.id AS VARCHAR) + '/' + 
    REPLACE(CAST(NEWID() AS VARCHAR(36)), '-', '') + 
    CASE ABS(CHECKSUM(NEWID())) % 3
        WHEN 0 THEN '.jpg'
        WHEN 1 THEN '.png'
        ELSE '.webp'
    END as url_imagen
FROM Publicacion p
WHERE p.tipo_contenido = 'IMAGEN'
AND NOT EXISTS (SELECT 1 FROM Imagen i WHERE i.idPublicacion = p.id);

PRINT ' Imágenes insertadas correctamente';
GO

-- ==========================================
-- VERIFICAR IMÁGENES INSERTADAS
-- ==========================================
PRINT '========================================';
PRINT 'VERIFICACIÓN DE IMÁGENES:';
PRINT '========================================';

SELECT 
    COUNT(*) as TotalImagenes,
    MIN(idPublicacion) as PrimeraImagen,
    MAX(idPublicacion) as UltimaImagen,
    COUNT(DISTINCT formato) as FormatosDistintos,
    AVG(ancho) as AnchoPromedio,
    AVG(alto) as AltoPromedio
FROM Imagen;
GO

-- Ver muestra de imágenes insertadas
SELECT TOP 20
    i.idPublicacion,
    p.titulo,
    i.ancho,
    i.alto,
    i.formato,
    LEFT(i.url_imagen, 50) as url_resumida
FROM Imagen i
JOIN Publicacion p ON i.idPublicacion = p.id
ORDER BY i.idPublicacion;
GO

PRINT '========================================';
PRINT ' IMÁGENES INSERTADAS CORRECTAMENTE';
PRINT '========================================';
GO