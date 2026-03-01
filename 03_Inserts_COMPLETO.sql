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
PRINT 'CASOS DE PRUEBA PARA LOS REPORTES';
PRINT '=======================================================';
GO

PRINT '--- 1. Preparando Reporte 7 (Intereses Cruzados) ---';
-- Necesitamos 2 usuarios que gasten más de $140 sumando suscripciones de Tecnología y Fitness.
INSERT INTO Usuario (email, password_hash, nickname, pais, fecha_nacimiento) 
VALUES ('techfit1@test.com', 'hash123', 'TechFitGurú', 'Chile', '1995-01-01'),
       ('techfit2@test.com', 'hash123', 'GymAndCode', 'México', '1998-05-05');
       
DECLARE @idU1 INT = (SELECT id FROM Usuario WHERE nickname = 'TechFitGurú');
DECLARE @idU2 INT = (SELECT id FROM Usuario WHERE nickname = 'GymAndCode');

-- Buscamos un nivel que pertenezca a Tecnología y otro a Fitness
DECLARE @idNivelTech INT = (SELECT TOP 1 n.id FROM NivelSuscripcion n JOIN Creador cr ON n.idCreador = cr.idUsuario JOIN Categoria c ON cr.idCategoria = c.id WHERE c.nombre = 'Tecnología');
DECLARE @idNivelFit INT = (SELECT TOP 1 n.id FROM NivelSuscripcion n JOIN Creador cr ON n.idCreador = cr.idUsuario JOIN Categoria c ON cr.idCategoria = c.id WHERE c.nombre = 'Fitness');

-- Les creamos suscripciones caras ($80 cada una = $160 en total) a ambos
INSERT INTO Suscripcion (idUsuario, idNivel, estado, precio_pactado, fecha_inicio) 
VALUES (@idU1, @idNivelTech, 'Activa', 80.00, GETDATE()),
       (@idU1, @idNivelFit, 'Activa', 80.00, GETDATE()),
       (@idU2, @idNivelTech, 'Activa', 80.00, GETDATE()),
       (@idU2, @idNivelFit, 'Activa', 80.00, GETDATE());

PRINT '--- 2. Preparando Reporte 11 (Lurkers) ---';
-- Necesitamos 2 usuarios con suscripción activa que NUNCA hayan comentado o reaccionado.
INSERT INTO Usuario (email, password_hash, nickname, pais, fecha_nacimiento) 
VALUES ('lurker1@test.com', 'hash123', 'FantasmaSilencioso', 'Perú', '1990-10-10'),
       ('lurker2@test.com', 'hash123', 'SoloMiroNoToco', 'Colombia', '1992-02-02');

DECLARE @idL1 INT = (SELECT id FROM Usuario WHERE nickname = 'FantasmaSilencioso');
DECLARE @idL2 INT = (SELECT id FROM Usuario WHERE nickname = 'SoloMiroNoToco');

-- Les damos 1 suscripción activa a cualquier nivel
DECLARE @idNivelRandom INT = (SELECT TOP 1 id FROM NivelSuscripcion);
INSERT INTO Suscripcion (idUsuario, idNivel, estado, precio_pactado, fecha_inicio) 
VALUES (@idL1, @idNivelRandom, 'Activa', 15.00, GETDATE()),
       (@idL2, @idNivelRandom, 'Activa', 20.00, GETDATE());

PRINT '--- 3. Preparando Reporte 13 (Cobertura Total) ---';
-- Necesitamos 2 usuarios que hayan usado EXACTAMENTE los 7 tipos de reacciones.
-- Vamos a usar a TechFitGurú y GymAndCode que ya creamos arriba para no ensuciar tanto la tabla.
DECLARE @idPub INT = (SELECT TOP 1 id FROM Publicacion);

-- Inyectamos las 7 reacciones exactas (Del ID 1 al 7) para el Usuario 1
INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion) VALUES 
(@idU1, @idPub, 1, GETDATE()), (@idU1, @idPub, 2, GETDATE()), (@idU1, @idPub, 3, GETDATE()), 
(@idU1, @idPub, 4, GETDATE()), (@idU1, @idPub, 5, GETDATE()), (@idU1, @idPub, 6, GETDATE()), (@idU1, @idPub, 7, GETDATE());

-- Inyectamos las 7 reacciones exactas (Del ID 1 al 7) para el Usuario 2
INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion) VALUES 
(@idU2, @idPub, 1, GETDATE()), (@idU2, @idPub, 2, GETDATE()), (@idU2, @idPub, 3, GETDATE()), 
(@idU2, @idPub, 4, GETDATE()), (@idU2, @idPub, 5, GETDATE()), (@idU2, @idPub, 6, GETDATE()), (@idU2, @idPub, 7, GETDATE());

PRINT ' CASOS DE PRUEBA LISTOS.';
GO

