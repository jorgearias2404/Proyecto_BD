-- =====================================================
-- Inserts_COMPLETO.sql - Carga masiva de datos
-- =====================================================

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
PRINT ' CARGA MASIVA COMPLETADA EXITOSAMENTE';
PRINT '========================================';
GO

USE FanHub_BD;
GO

PRINT '=======================================================';
PRINT ' CASOS DE PRUEBA PERFECTOS PARA LOS REPORTES';
PRINT '=======================================================';
GO

-- VERIFICACIÓN DE SEGURIDAD: ¿Están vacías las tablas?
IF NOT EXISTS (SELECT 1 FROM Publicacion) OR NOT EXISTS (SELECT 1 FROM NivelSuscripcion)
BEGIN
    PRINT ' ALERTA: Las tablas están vacías. El script de Inserts no cargó los datos reales.';
    RETURN; -- Detiene el script aquí sin dar errores rojos
END

PRINT '--- 1. Preparando Reporte 7 (Intereses Cruzados) ---';
INSERT INTO Usuario (email, password_hash, nickname, pais, fecha_nacimiento) 
VALUES ('techfit1@test.com', 'hash123', 'TechFitGurú', 'Chile', '1995-01-01'),
       ('techfit2@test.com', 'hash123', 'GymAndCode', 'México', '1998-05-05');
       
DECLARE @idU1 INT = (SELECT id FROM Usuario WHERE nickname = 'TechFitGurú');
DECLARE @idU2 INT = (SELECT id FROM Usuario WHERE nickname = 'GymAndCode');

-- Tomamos dos niveles de suscripción CUALQUIERA que ya existan para no depender del nombre de la categoría
DECLARE @idNivelTech INT = (SELECT TOP 1 id FROM NivelSuscripcion);
DECLARE @idNivelFit INT = (SELECT TOP 1 id FROM NivelSuscripcion WHERE id != @idNivelTech);

INSERT INTO Suscripcion (idUsuario, idNivel, estado, precio_pactado, fecha_inicio) 
VALUES (@idU1, @idNivelTech, 'Activa', 80.00, GETDATE()), (@idU1, @idNivelFit, 'Activa', 80.00, GETDATE()),
       (@idU2, @idNivelTech, 'Activa', 80.00, GETDATE()), (@idU2, @idNivelFit, 'Activa', 80.00, GETDATE());

PRINT '--- 2. Preparando Reporte 11 (Lurkers) ---';
INSERT INTO Usuario (email, password_hash, nickname, pais, fecha_nacimiento) 
VALUES ('lurker1@test.com', 'hash123', 'FantasmaSilencioso', 'Perú', '1990-10-10');
DECLARE @idL1 INT = (SELECT id FROM Usuario WHERE nickname = 'FantasmaSilencioso');
INSERT INTO Suscripcion (idUsuario, idNivel, estado, precio_pactado, fecha_inicio) 
VALUES (@idL1, @idNivelTech, 'Activa', 15.00, GETDATE());

PRINT '--- 3. Preparando Reporte 13 ---';
DECLARE @idPub INT = (SELECT TOP 1 id FROM Publicacion);

INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion) VALUES 
(@idU1, @idPub, 1, GETDATE()), (@idU1, @idPub, 2, GETDATE()), (@idU1, @idPub, 3, GETDATE()), 
(@idU1, @idPub, 4, GETDATE()), (@idU1, @idPub, 5, GETDATE()), (@idU1, @idPub, 6, GETDATE()), (@idU1, @idPub, 7, GETDATE());

PRINT ' CASOS DE PRUEBA LISTOS.';
GO

