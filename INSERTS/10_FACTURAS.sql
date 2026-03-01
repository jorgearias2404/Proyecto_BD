-- ==========================================
-- 9. FACTURAS (550 registros reales)
-- ==========================================
USE FanHub_BD;
GO

PRINT 'Limpiando facturas viejas (por si acaso)...';
DELETE FROM Factura;
GO

PRINT 'Generando Facturas dinámicas para las suscripciones existentes...';

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total)
SELECT 
    id, -- Toma el ID real de la suscripción que sí existe en tu BD
    'TXN-' + CAST(id AS NVARCHAR(20)) + '-' + REPLACE(CONVERT(NVARCHAR, fecha_inicio, 112), '/', ''),
    fecha_inicio,
    precio_pactado,
    precio_pactado * 0.16, -- 16% impuesto
    precio_pactado * 1.16  -- Total
FROM Suscripcion;

PRINT ' Facturas generadas exitosamente.';
GO