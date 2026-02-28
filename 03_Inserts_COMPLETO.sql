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

-- ==========================================
-- 2. CREADORES (26)
-- ==========================================


-- ==========================================
-- 3. NIVELES DE SUSCRIPCIÓN (57 registros reales)
-- ==========================================


-- ==========================================
-- 4. PUBLICACIONES (850)
-- ==========================================

-- ==========================================
-- 5. DETALLES POR TIPO
-- ==========================================

-- ==========================================
-- 6. ETIQUETAS
-- ==========================================

-- ==========================================
-- 7. ASOCIACIONES ETIQUETAS-PUBLICACIONES
-- ==========================================

-- ==========================================
-- 8. MÉTODOS DE PAGO
-- ==========================================

-- ==========================================
-- 9. SUSCRIPCIONES (550)
-- ==========================================

-- ==========================================
-- 10. FACTURAS
-- ==========================================

-- ==========================================
-- 11. REACCIONES (1600)
-- ==========================================

-- ==========================================
-- 12. COMENTARIOS (950 principales)
-- ==========================================


-- ==========================================
-- 13. HILOS DE CONVERSACIÓN (150)
-- ==========================================

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