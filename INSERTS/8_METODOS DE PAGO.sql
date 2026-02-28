-- ==========================================
-- 8. MÉTODOS DE PAGO (260 registros con variedad de tarjetas)
-- ==========================================
PRINT '========================================';
PRINT 'LIMPIANDO Y REGENERANDO MÉTODOS DE PAGO';
PRINT '========================================';
GO

-- ==========================================
-- 1. LIMPIAR MÉTODOS DE PAGO EXISTENTES
-- ==========================================
PRINT 'Eliminando métodos de pago existentes...';
DELETE FROM MetodoPago;
PRINT '✅ Métodos de pago eliminados';
GO

-- ==========================================
-- 2. INSERTAR NUEVOS MÉTODOS DE PAGO CON VARIEDAD
-- ==========================================
PRINT 'Insertando 260 métodos de pago con variedad de tarjetas...';

INSERT INTO MetodoPago (idUsuario, ultimos_4_digitos, marca, titular, fecha_expiracion, es_predeterminado)
SELECT 
    u.id,
    RIGHT('0000' + CAST(1000 + ABS(CHECKSUM(NEWID())) % 9000 AS VARCHAR), 4),
    CASE ABS(CHECKSUM(NEWID())) % 6
        WHEN 0 THEN 'Visa'
        WHEN 1 THEN 'Mastercard'
        WHEN 2 THEN 'American Express'
        WHEN 3 THEN 'Discover'
        WHEN 4 THEN 'Maestro'
        ELSE 'Visa' -- Un poco más de Visa para mantener equilibrio
    END,
    u.nickname,
    DATEFROMPARTS(
        2027 + ABS(CHECKSUM(NEWID())) % 4, -- Años 2027-2030
        1 + ABS(CHECKSUM(NEWID())) % 12,   -- Meses 1-12
        1                                   -- Primer día del mes
    ),
    CASE ABS(CHECKSUM(NEWID())) % 10 
        WHEN 0 THEN 1  -- 10% son predeterminados
        ELSE 0
    END
FROM Usuario u
WHERE u.esta_activo = 1
ORDER BY u.id;

PRINT '✅ 260 métodos de pago insertados correctamente';
GO

-- ==========================================
-- 3. VERIFICAR LA DISTRIBUCIÓN DE TARJETAS
-- ==========================================
PRINT '========================================';
PRINT 'DISTRIBUCIÓN DE TIPOS DE TARJETA:';
PRINT '========================================';

SELECT 
    marca,
    COUNT(*) as Cantidad,
    CAST(COUNT(*) * 100.0 / 260 AS DECIMAL(5,2)) as Porcentaje
FROM MetodoPago
GROUP BY marca
ORDER BY Cantidad DESC;
GO

-- ==========================================
-- 4. VER MUESTRA DE LOS NUEVOS MÉTODOS DE PAGO
-- ==========================================
PRINT 'Muestra de los nuevos métodos de pago:';
SELECT TOP 20
    id,
    idUsuario,
    ultimos_4_digitos,
    marca,
    titular,
    fecha_expiracion,
    es_predeterminado
FROM MetodoPago
ORDER BY idUsuario;
GO

PRINT '========================================';
PRINT '✅ MÉTODOS DE PAGO REGENERADOS EXITOSAMENTE';
PRINT '========================================';
GO