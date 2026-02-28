-- =====================================================
-- Verificacion.sql - Consultas para verificar los datos
-- =====================================================

USE FanHub;
GO

-- Verificar todas las tablas
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

-- Ver muestra de datos de cada tabla
PRINT '--- PRIMEROS 5 USUARIOS ---';
SELECT TOP 5 id, email, nickname, pais FROM Usuario;
GO

PRINT '--- PRIMEROS 5 CREADORES ---';
SELECT TOP 5 * FROM Creador;
GO

PRINT '--- PRIMERAS 5 PUBLICACIONES ---';
SELECT TOP 5 id, idCreador, titulo, tipo_contenido FROM Publicacion;
GO