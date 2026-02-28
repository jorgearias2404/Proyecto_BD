-- ==========================================
-- 5. DETALLES POR TIPO - VIDEOS
-- ==========================================
PRINT 'Insertando detalles de videos...';

-- Primero, limpiar videos existentes si los hay
DELETE FROM Video;
PRINT '✓ Videos anteriores eliminados';

-- Insertar videos SOLO para publicaciones que existen y son de tipo VIDEO
INSERT INTO Video (idPublicacion, duracion_seg, resolucion, url_stream)
SELECT 
    p.id,
    60 + ABS(CHECKSUM(NEWID())) % 3600, -- Duración entre 1 y 60 minutos
    CASE ABS(CHECKSUM(NEWID())) % 3
        WHEN 0 THEN '720p'
        WHEN 1 THEN '1080p'
        ELSE '4K'
    END,
    'https://stream.fanhub.com/video/' + CAST(p.id AS VARCHAR)
FROM Publicacion p
WHERE p.tipo_contenido = 'VIDEO'
AND NOT EXISTS (SELECT 1 FROM Video v WHERE v.idPublicacion = p.id);

PRINT '✅ Videos insertados correctamente';
GO

-- Verificar cuántos videos se insertaron
SELECT COUNT(*) as TotalVideos FROM Video;
GO