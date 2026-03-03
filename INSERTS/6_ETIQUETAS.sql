-- ==========================================
-- 6. ETIQUETAS (37 registros) 
-- ==========================================
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'INSERTANDO ETIQUETAS (SOLO LAS QUE FALTAN)';
PRINT '========================================';
GO

PRINT 'Verificando etiquetas existentes...';

-- Verificar cuántas etiquetas hay actualmente
DECLARE @total_existente INT;
SELECT @total_existente = COUNT(*) FROM Etiqueta;
PRINT 'Etiquetas existentes: ' + CAST(@total_existente AS VARCHAR);
GO

-- Insertar solo las etiquetas que NO existen
PRINT 'Insertando etiquetas faltantes...';

INSERT INTO Etiqueta (nombre)
SELECT nombre FROM (
    VALUES 
    ('Arte'),
    ('Aventura'),
    ('Cardio'),
    ('Cocina'),
    ('Comedia'),
    ('Consejos'),
    ('Digital'),
    ('Educación'),
    ('Electrónica'),
    ('Fitness'),
    ('Fotografía'),
    ('Gaming'),
    ('Hardware'),
    ('Humor'),
    ('IA'),
    ('Maquillaje'),
    ('Memes'),
    ('Moda'),
    ('Montañas'),
    ('Música'),
    ('Nintendo'),
    ('Nutrición'),
    ('PC'),
    ('Playas'),
    ('PlayStation'),
    ('Pop'),
    ('Postres'),
    ('Programación'),
    ('Recetas'),
    ('Rock'),
    ('Streetwear'),
    ('Tecnología'),
    ('Tutorial'),
    ('Vegetariano'),
    ('Viajes'),
    ('Xbox'),
    ('Yoga')
) AS nuevas(nombre)
WHERE NOT EXISTS (
    SELECT 1 FROM Etiqueta e WHERE e.nombre = nuevas.nombre
);

PRINT '✅ Etiquetas faltantes insertadas correctamente';
GO

-- Mostrar el total final
DECLARE @total_final INT;
SELECT @total_final = COUNT(*) FROM Etiqueta;
PRINT 'Total de etiquetas ahora: ' + CAST(@total_final AS VARCHAR);
GO

-- Mostrar las etiquetas actuales
PRINT '';
PRINT 'Etiquetas actuales en la base de datos:';
SELECT id, nombre FROM Etiqueta ORDER BY nombre;
GO

PRINT '========================================';
PRINT ' PROCESO COMPLETADO EXITOSAMENTE';
PRINT '========================================';
GO