-- ==============================================================================================
-- Universidad Central de Venezuela - Facultad de Ciencias
-- Proyecto Fase 2: FanHub
-- Archivo: Queries.sql (Consultas de Reporting / BI)
-- ==============================================================================================
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'REPORTE 1: Clasificación de Ganancias';
PRINT '========================================';
-- Lista creadores por facturación del último mes usando la función fn_clasificar_ingreso.
SELECT 
    u.nickname AS [Nickname], 
    c.nombre AS [Categoria], 
    COUNT(DISTINCT CASE WHEN s.estado = 'Activa' THEN s.id END) AS [Total Suscriptores Activos],
    ISNULL(SUM(f.sub_total), 0) AS [Monto Facturado],
    dbo.fn_clasificar_ingreso(ISNULL(SUM(f.sub_total), 0)) AS [Clasificación]
FROM Creador cr
JOIN Usuario u ON cr.idUsuario = u.id
JOIN Categoria c ON cr.idCategoria = c.id
LEFT JOIN NivelSuscripcion n ON cr.idUsuario = n.idCreador
LEFT JOIN Suscripcion s ON n.id = s.idNivel
LEFT JOIN Factura f ON s.id = f.idSuscripcion AND f.fecha_emision >= DATEADD(MONTH, -1, GETDATE())
GROUP BY u.nickname, c.nombre;
GO

PRINT '========================================';
PRINT 'REPORTE 2: Viralidad por Categoría';
PRINT '========================================';
-- Top 1 publicación por categoría basado en (Reacciones*1.5) + (Comentarios*3).
WITH RankingViralidad AS (
    SELECT 
        c.nombre AS [Nombre Categoría],
        p.titulo AS [Título Publicación],
        u.nickname AS [Creador],
        ((SELECT COUNT(*) FROM UsuarioReaccionPublicacion WHERE idPublicacion = p.id) * 1.5) +
        ((SELECT COUNT(*) FROM Comentario WHERE idPublicacion = p.id) * 3) AS [Puntaje],
        ROW_NUMBER() OVER(PARTITION BY c.id ORDER BY 
            (((SELECT COUNT(*) FROM UsuarioReaccionPublicacion WHERE idPublicacion = p.id) * 1.5) +
            ((SELECT COUNT(*) FROM Comentario WHERE idPublicacion = p.id) * 3)) DESC
        ) as rn
    FROM Publicacion p
    JOIN Creador cr ON p.idCreador = cr.idUsuario
    JOIN Usuario u ON cr.idUsuario = u.id
    JOIN Categoria c ON cr.idCategoria = c.id
)
SELECT [Nombre Categoría], [Título Publicación], [Creador], [Puntaje]
FROM RankingViralidad
WHERE rn = 1;
GO

PRINT '========================================';
PRINT 'REPORTE 3: Análisis de Dominios de Correo';
PRINT '========================================';
-- Frecuencia de proveedores de correo con más de 10 usuarios.
SELECT 
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS [Dominio],
    COUNT(*) AS [Cantidad Usuarios]
FROM Usuario
GROUP BY SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email))
HAVING COUNT(*) > 10;
GO

PRINT '========================================';
PRINT 'REPORTE 4: Promedio de Retención (Churn)';
PRINT '========================================';
-- Promedio de días de suscripciones canceladas, ordenado por nivel.
SELECT 
    u.nickname AS [Nickname Creador],
    n.nombre AS [Nombre Nivel],
    AVG(DATEDIFF(DAY, s.fecha_inicio, s.fecha_fin)) AS [Promedio Días]
FROM Suscripcion s
JOIN NivelSuscripcion n ON s.idNivel = n.id
JOIN Creador cr ON n.idCreador = cr.idUsuario
JOIN Usuario u ON cr.idUsuario = u.id
WHERE s.estado = 'Cancelada'
GROUP BY u.nickname, n.nombre, n.orden
ORDER BY n.orden ASC;
GO

PRINT '========================================';
PRINT 'REPORTE 5: Tiempo y Peso de Contenido (Gaming)';
PRINT '========================================';
-- Cálculo de GB y formato de tiempo para videos de Gaming.
SELECT 
    u.nickname AS [Nickname],
    CAST(SUM(v.duracion_seg) / 3600 AS VARCHAR) + 'h ' + 
    CAST((SUM(v.duracion_seg) % 3600) / 60 AS VARCHAR) + 'm' AS [Tiempo Total Formateado],
    CAST(SUM(
        CASE 
            WHEN v.resolucion = '4K' THEN (v.duracion_seg / 60.0) * 0.5
            WHEN v.resolucion = '1080p' THEN (v.duracion_seg / 60.0) * 0.1
            ELSE (v.duracion_seg / 60.0) * 0.05
        END
    ) AS DECIMAL(10,2)) AS [Estimación GB]
FROM Video v
JOIN Publicacion p ON v.idPublicacion = p.id
JOIN Creador cr ON p.idCreador = cr.idUsuario
JOIN Usuario u ON cr.idUsuario = u.id
JOIN Categoria c ON cr.idCategoria = c.id
WHERE c.nombre = 'Gaming'
GROUP BY u.nickname;
GO

PRINT '========================================';
PRINT 'REPORTE 6: Mapa de Calor Financiero';
PRINT '========================================';
-- Total facturado por país y su % del total global.
WITH TotalGlobal AS (SELECT SUM(monto_total) AS gran_total FROM Factura)
SELECT 
    u.pais AS [País],
    SUM(f.monto_total) AS [Total Facturado],
    CAST((SUM(f.monto_total) / (SELECT gran_total FROM TotalGlobal)) * 100 AS DECIMAL(5,2)) AS [Share %]
FROM Factura f
JOIN Suscripcion s ON f.idSuscripcion = s.id
JOIN NivelSuscripcion n ON s.idNivel = n.id
JOIN Usuario u ON n.idCreador = u.id -- El país que genera el dinero es el del creador
GROUP BY u.pais;
GO

PRINT '========================================';
PRINT 'REPORTE 7: Intereses Cruzados';
PRINT '========================================';
-- Usuarios suscritos a Tecnología Y Fitness con gasto > $140.
SELECT 
    u.nickname AS [Nickname Usuario],
    SUM(s.precio_pactado) AS [Gasto Total Histórico]
FROM Usuario u
JOIN Suscripcion s ON u.id = s.idUsuario
JOIN NivelSuscripcion n ON s.idNivel = n.id
JOIN Creador cr ON n.idCreador = cr.idUsuario
JOIN Categoria c ON cr.idCategoria = c.id
WHERE u.id IN (
    -- Subconsulta: Usuarios que tienen al menos una sub en Tecnología
    SELECT s1.idUsuario FROM Suscripcion s1 JOIN NivelSuscripcion n1 ON s1.idNivel = n1.id JOIN Creador cr1 ON n1.idCreador = cr1.idUsuario JOIN Categoria c1 ON cr1.idCategoria = c1.id WHERE c1.nombre = 'Tecnología'
)
AND u.id IN (
    -- Subconsulta: Usuarios que tienen al menos una sub en Fitness
    SELECT s2.idUsuario FROM Suscripcion s2 JOIN NivelSuscripcion n2 ON s2.idNivel = n2.id JOIN Creador cr2 ON n2.idCreador = cr2.idUsuario JOIN Categoria c2 ON cr2.idCategoria = c2.id WHERE c2.nombre = 'Fitness'
)
GROUP BY u.nickname
HAVING SUM(s.precio_pactado) > 140;
GO

PRINT '========================================';
PRINT 'REPORTE 8: Generaciones';
PRINT '========================================';
-- Clasificación demográfica y gasto promedio de usuarios.
SELECT 
    CASE 
        WHEN YEAR(fecha_nacimiento) > 2000 THEN 'Gen Z'
        WHEN YEAR(fecha_nacimiento) BETWEEN 1981 AND 2000 THEN 'Millennials'
        ELSE 'X'
    END AS [Generación],
    COUNT(DISTINCT u.id) AS [Cantidad Usuarios Activos],
    ISNULL(SUM(f.monto_total) / NULLIF(COUNT(DISTINCT u.id), 0), 0) AS [Gasto Promedio Mensual]
FROM Usuario u
LEFT JOIN Suscripcion s ON u.id = s.idUsuario
LEFT JOIN Factura f ON s.id = f.idSuscripcion AND f.fecha_emision >= DATEADD(MONTH, -1, GETDATE())
WHERE u.esta_activo = 1
GROUP BY 
    CASE 
        WHEN YEAR(fecha_nacimiento) > 2000 THEN 'Gen Z'
        WHEN YEAR(fecha_nacimiento) BETWEEN 1981 AND 2000 THEN 'Millennials'
        ELSE 'X'
    END;
GO

PRINT '========================================';
PRINT 'REPORTE 9: Creadores Polémicos';
PRINT '========================================';
-- Creadores con Ratio (Comentarios/Reacciones) > 2.0.
WITH EstadisticasPosts AS (
    SELECT 
        p.idCreador,
        p.id AS idPublicacion,
        CAST((SELECT COUNT(*) FROM Comentario WHERE idPublicacion = p.id) AS DECIMAL(10,2)) / 
        NULLIF((SELECT COUNT(*) FROM UsuarioReaccionPublicacion WHERE idPublicacion = p.id), 0) AS Ratio
    FROM Publicacion p
)
SELECT 
    u.nickname AS [Nickname],
    COUNT(ep.idPublicacion) AS [Cantidad Posts Evaluados],
    AVG(ep.Ratio) AS [Ratio Promedio]
FROM EstadisticasPosts ep
JOIN Usuario u ON ep.idCreador = u.id
GROUP BY u.nickname
HAVING AVG(ep.Ratio) > 2.0;
GO

PRINT '========================================';
PRINT 'REPORTE 10: Ranking de Creadores (Reputación)';
PRINT '========================================';
-- Creadores multimedia sin NSFW, ordenados por reputación calculada.
SELECT 
    u.nickname AS [Nickname],
    (SELECT COUNT(*) FROM Suscripcion s JOIN NivelSuscripcion n ON s.idNivel = n.id WHERE n.idCreador = cr.idUsuario AND s.estado = 'Activa') AS [Total Suscriptores],
    dbo.fn_calcular_reputacion(cr.idUsuario) AS [Puntaje Reputación]
FROM Creador cr
JOIN Usuario u ON cr.idUsuario = u.id
WHERE cr.es_nsfw = 0 
  AND EXISTS (SELECT 1 FROM Publicacion p WHERE p.idCreador = cr.idUsuario AND p.tipo_contenido IN ('VIDEO', 'IMAGEN'))
ORDER BY [Puntaje Reputación] DESC;
GO

PRINT '========================================';
PRINT 'REPORTE 11: Usuarios "Lurkers"';
PRINT '========================================';
-- Suscritos pero que nunca interactúan.
SELECT 
    u.nickname AS [Nickname],
    MAX(s.fecha_inicio) AS [Fecha Última Suscripción],
    SUM(s.precio_pactado) AS [Monto Gastado (Estimado)]
FROM Usuario u
JOIN Suscripcion s ON u.id = s.idUsuario
WHERE s.estado = 'Activa'
  AND NOT EXISTS (SELECT 1 FROM UsuarioReaccionPublicacion WHERE idUsuario = u.id)
  AND NOT EXISTS (SELECT 1 FROM Comentario WHERE idUsuario = u.id)
GROUP BY u.nickname;
GO

PRINT '========================================';
PRINT 'REPORTE 12: Tendencias (Tags)';
PRINT '========================================';
-- Top 3 etiquetas del último mes.
SELECT TOP 3
    e.nombre AS [Nombre Etiqueta],
    COUNT(pe.idPublicacion) AS [Cantidad Publicaciones]
FROM Etiqueta e
JOIN PublicacionEtiqueta pe ON e.id = pe.idEtiqueta
JOIN Publicacion p ON pe.idPublicacion = p.id
WHERE p.fecha_publicacion >= DATEADD(MONTH, -1, GETDATE())
GROUP BY e.nombre
ORDER BY [Cantidad Publicaciones] DESC;
GO

PRINT '========================================';
PRINT 'REPORTE 13: Cobertura Total de Reacciones';
PRINT '========================================';
-- Usuarios que han usado TODOS los tipos de reacción.
SELECT 
    u.nickname AS [Nickname],
    COUNT(urp.idTipoReaccion) AS [Total Reacciones Realizadas]
FROM Usuario u
JOIN UsuarioReaccionPublicacion urp ON u.id = urp.idUsuario
GROUP BY u.nickname
HAVING COUNT(DISTINCT urp.idTipoReaccion) = (SELECT COUNT(*) FROM TipoReaccion);
GO

PRINT '========================================';
PRINT 'REPORTE 14: Reporte de Nómina (Liquidación)';
PRINT '========================================';
-- Liquidación del mes actual (80% para el creador, 20% FanHub).
SELECT 
    cr.banco_nombre AS [Nombre Banco],
    cr.banco_cuenta AS [Cuenta Bancaria],
    u.nickname AS [Beneficiario (Nickname)],
    SUM(f.sub_total) AS [Total Facturado (Bruto)],
    SUM(f.sub_total) * 0.20 AS [Comisión FanHub],
    SUM(f.sub_total) * 0.80 AS [Monto a Transferir (Neto)]
FROM Creador cr
JOIN Usuario u ON cr.idUsuario = u.id
JOIN NivelSuscripcion n ON cr.idUsuario = n.idCreador
JOIN Suscripcion s ON n.id = s.idNivel
JOIN Factura f ON s.id = f.idSuscripcion
WHERE MONTH(f.fecha_emision) = MONTH(GETDATE()) AND YEAR(f.fecha_emision) = YEAR(GETDATE())
GROUP BY cr.banco_nombre, cr.banco_cuenta, u.nickname;
GO