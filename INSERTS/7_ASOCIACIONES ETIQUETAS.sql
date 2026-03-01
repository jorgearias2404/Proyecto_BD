-- ==========================================
-- 7. ASOCIACIONES ETIQUETAS-PUBLICACIONES 
-- ==========================================
USE FanHub;
GO

PRINT '========================================';
PRINT 'REFRESH DE PUBLICACIONETIQUETA - VERSIÓN ALTA';
PRINT '========================================';
GO

-- ==========================================
-- 1. ELIMINAR REGISTROS EXISTENTES
-- ==========================================
PRINT 'Eliminando asociaciones existentes...';
DELETE FROM PublicacionEtiqueta;
PRINT '✅ Asociaciones eliminadas';
GO

-- ==========================================
-- 2. GENERAR NUEVAS ASOCIACIONES (MUCHAS)
-- ==========================================
PRINT 'Generando asociaciones masivas...';

-- Insertar asociaciones para TODAS las combinaciones posibles
INSERT INTO PublicacionEtiqueta (idPublicacion, idEtiqueta)
SELECT DISTINCT
    p.id,
    e.id
FROM Publicacion p
JOIN Creador c ON p.idCreador = c.idUsuario
JOIN Categoria cat ON c.idCategoria = cat.id
CROSS JOIN Etiqueta e
WHERE 
    -- Asociaciones por categoría
    (
        (cat.nombre = 'Gaming' AND e.nombre IN ('Gaming', 'PC', 'PlayStation', 'Xbox', 'Nintendo', 'Hardware', 'IA', 'Tecnología')) OR
        (cat.nombre = 'Fitness' AND e.nombre IN ('Fitness', 'Cardio', 'Yoga', 'Nutrición')) OR
        (cat.nombre = 'Tecnología' AND e.nombre IN ('Tecnología', 'IA', 'Programación', 'Hardware', 'Electrónica', 'Gaming', 'PC')) OR
        (cat.nombre = 'Arte' AND e.nombre IN ('Arte', 'Digital', 'Fotografía')) OR
        (cat.nombre = 'Música' AND e.nombre IN ('Música', 'Rock', 'Pop', 'Electrónica')) OR
        (cat.nombre = 'Cocina' AND e.nombre IN ('Cocina', 'Recetas', 'Postres', 'Vegetariano')) OR
        (cat.nombre = 'Viajes' AND e.nombre IN ('Viajes', 'Aventura', 'Playas', 'Montañas')) OR
        (cat.nombre = 'Educación' AND e.nombre IN ('Educación', 'Tutorial', 'Consejos')) OR
        (cat.nombre = 'Comedia' AND e.nombre IN ('Comedia', 'Humor', 'Memes')) OR
        (cat.nombre = 'Moda' AND e.nombre IN ('Moda', 'Streetwear', 'Maquillaje'))
    )
    -- Alta probabilidad para generar muchas asociaciones
    AND RAND(CHECKSUM(NEWID())) < 0.95
    -- Evitar duplicados
    AND NOT EXISTS (
        SELECT 1 FROM PublicacionEtiqueta pe 
        WHERE pe.idPublicacion = p.id AND pe.idEtiqueta = e.id
    );

PRINT '✅ Asociaciones principales generadas';
GO

-- ==========================================
-- 3. AGREGAR ASOCIACIONES ADICIONALES ALEATORIAS
-- ==========================================
PRINT 'Agregando asociaciones adicionales aleatorias...';

-- Segunda pasada: usar TOP sin ORDER BY problemático
INSERT INTO PublicacionEtiqueta (idPublicacion, idEtiqueta)
SELECT TOP 15000
    p.id,
    e.id
FROM Publicacion p
CROSS JOIN Etiqueta e
WHERE NOT EXISTS (
    SELECT 1 FROM PublicacionEtiqueta pe 
    WHERE pe.idPublicacion = p.id AND pe.idEtiqueta = e.id
)
AND RAND(CHECKSUM(NEWID())) < 0.3
ORDER BY NEWID();  -- El ORDER BY ahora funciona porque no hay SELECT DISTINCT

PRINT '✅ Asociaciones adicionales agregadas';
GO

-- ==========================================
-- 4. TERCERA PASADA: COMPLETAR HASTA LLEGAR A ~31,450
-- ==========================================
PRINT 'Completando hasta alcanzar volumen deseado...';

DECLARE @TotalActual INT;
SELECT @TotalActual = COUNT(*) FROM PublicacionEtiqueta;

WHILE @TotalActual < 31000
BEGIN
    INSERT INTO PublicacionEtiqueta (idPublicacion, idEtiqueta)
    SELECT TOP 1000
        p.id,
        e.id
    FROM Publicacion p
    CROSS JOIN Etiqueta e
    WHERE NOT EXISTS (
        SELECT 1 FROM PublicacionEtiqueta pe 
        WHERE pe.idPublicacion = p.id AND pe.idEtiqueta = e.id
    )
    ORDER BY NEWID();
    
    SELECT @TotalActual = COUNT(*) FROM PublicacionEtiqueta;
END;

PRINT '✅ Volumen completado';
GO

-- ==========================================
-- 5. VERIFICAR RESULTADO FINAL
-- ==========================================
PRINT '========================================';
PRINT 'RESULTADO FINAL:';
PRINT '========================================';

DECLARE @TotalAsociaciones INT;
DECLARE @PublicacionesConEtiquetas INT;

SELECT @TotalAsociaciones = COUNT(*) FROM PublicacionEtiqueta;
SELECT @PublicacionesConEtiquetas = COUNT(DISTINCT idPublicacion) FROM PublicacionEtiqueta;

SELECT @TotalAsociaciones as TotalAsociaciones;

SELECT 
    'Estadísticas' as Concepto,
    CAST(@TotalAsociaciones AS VARCHAR) as Valor
UNION ALL
SELECT 
    'Publicaciones con etiquetas',
    CAST(@PublicacionesConEtiquetas AS VARCHAR)
UNION ALL
SELECT 
    'Etiquetas utilizadas',
    CAST(COUNT(DISTINCT idEtiqueta) AS VARCHAR)
FROM PublicacionEtiqueta
UNION ALL
SELECT 
    'Promedio etiquetas por publicación',
    CASE 
        WHEN @PublicacionesConEtiquetas > 0 
        THEN CAST(@TotalAsociaciones / @PublicacionesConEtiquetas AS VARCHAR)
        ELSE '0'
    END;
GO

-- ==========================================
-- 6. VER DISTRIBUCIÓN POR CATEGORÍA
-- ==========================================
SELECT 
    cat.nombre as Categoria,
    COUNT(DISTINCT pe.idPublicacion) as Publicaciones,
    COUNT(pe.idEtiqueta) as TotalEtiquetas,
    COUNT(pe.idEtiqueta) / NULLIF(COUNT(DISTINCT pe.idPublicacion), 0) as Promedio
FROM PublicacionEtiqueta pe
JOIN Publicacion p ON pe.idPublicacion = p.id
JOIN Creador c ON p.idCreador = c.idUsuario
JOIN Categoria cat ON c.idCategoria = cat.id
GROUP BY cat.nombre
ORDER BY cat.nombre;
GO

PRINT '========================================';
PRINT ' REFRESH COMPLETADO EXITOSAMENTE';
PRINT '========================================';
GO