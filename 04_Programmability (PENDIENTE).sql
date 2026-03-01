-- ==============================================================================================
-- Universidad Central de Venezuela - Facultad de Ciencias
-- Proyecto Fase 2: FanHub
-- Archivo: Programmability.sql (Parte 1: Funciones y Triggers)
-- ==============================================================================================
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'CREANDO FUNCIONES ESCALARES (UDF)';
PRINT '========================================';
GO

-- 1. Función: fn_calcular_impuesto
-- Retorna el 16% del monto.
CREATE OR ALTER FUNCTION dbo.fn_calcular_impuesto(@monto DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @monto * 0.16;
END;
GO

-- 2. Función: fn_clasificar_ingreso
-- Clasifica: Diamante (> $1000), Oro ($500-$1000), Plata (< $500).
CREATE OR ALTER FUNCTION dbo.fn_clasificar_ingreso(@monto DECIMAL(10,2))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @categoria NVARCHAR(20);
    IF @monto > 1000 
        SET @categoria = 'Diamante';
    ELSE IF @monto >= 500 
        SET @categoria = 'Oro';
    ELSE 
        SET @categoria = 'Plata';
        
    RETURN @categoria;
END;
GO

-- 3. Función: fn_calcular_reputacion
-- Fórmula: (Subs * 0.5) + (Reacciones Último Mes * 0.1) + (Meses Antigüedad * 2)
CREATE OR ALTER FUNCTION dbo.fn_calcular_reputacion(@idCreador INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @totalSubs INT = 0;
    DECLARE @reaccionesMes INT = 0;
    DECLARE @mesesAntiguedad INT = 0;
    DECLARE @puntaje DECIMAL(10,2) = 0;

    -- Calcular Suscriptores Activos
    SELECT @totalSubs = COUNT(*) 
    FROM Suscripcion s
    JOIN NivelSuscripcion n ON s.idNivel = n.id
    WHERE n.idCreador = @idCreador AND s.estado = 'Activa';

    -- Calcular Reacciones del último mes
    SELECT @reaccionesMes = COUNT(*) 
    FROM UsuarioReaccionPublicacion urp
    JOIN Publicacion p ON urp.idPublicacion = p.id
    WHERE p.idCreador = @idCreador AND urp.fecha_reaccion >= DATEADD(MONTH, -1, GETDATE());

    -- Calcular meses de antigüedad
    SELECT @mesesAntiguedad = DATEDIFF(MONTH, fecha_registro, GETDATE())
    FROM Usuario WHERE id = @idCreador;

    -- Aplicar fórmula
    SET @puntaje = (@totalSubs * 0.5) + (@reaccionesMes * 0.1) + (@mesesAntiguedad * 2);

    -- Tope máximo de 100 puntos
    IF @puntaje > 100 SET @puntaje = 100;

    RETURN @puntaje;
END;
GO

PRINT 'Funciones creadas exitosamente.';
GO

PRINT '========================================';
PRINT 'CREANDO TRIGGERS DE SEGURIDAD';
PRINT '========================================';
GO

-- 1. Trigger: Auditoría de Precios (Safety)
-- Evita cambios de precio mayores al 50%.
CREATE OR ALTER TRIGGER trg_auditoria_precios
ON NivelSuscripcion
AFTER UPDATE
AS
BEGIN
    -- Verifica si la columna precio_actual fue modificada
    IF UPDATE(precio_actual)
    BEGIN
        -- Compara los valores nuevos (inserted) contra los viejos (deleted)
        IF EXISTS (
            SELECT 1
            FROM inserted i
            JOIN deleted d ON i.id = d.id
            WHERE ABS(i.precio_actual - d.precio_actual) > (d.precio_actual * 0.5)
        )
        BEGIN
            -- Cancela la operación y lanza el error
            RAISERROR ('El cambio de precio supera el 50%% permitido. Operación cancelada por seguridad.', 16, 1);
            ROLLBACK TRANSACTION;
        END
    END
END;
GO

-- 2. Trigger: Protección de Menores (NSFW)
-- Bloquea la suscripción si el usuario es menor de 18 y el creador es NSFW.
CREATE OR ALTER TRIGGER trg_proteccion_menores_nsfw
ON Suscripcion
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN Usuario u ON i.idUsuario = u.id
        JOIN NivelSuscripcion n ON i.idNivel = n.id
        JOIN Creador c ON n.idCreador = c.idUsuario
        WHERE c.es_nsfw = 1 AND DATEDIFF(YEAR, u.fecha_nacimiento, GETDATE()) < 18
    )
    BEGIN
        -- Cancela la inserción y lanza la alerta exacta que pide el documento
        RAISERROR ('Contenido restringido por edad', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

PRINT 'Triggers de seguridad creados exitosamente.';
GO

PRINT '========================================';
PRINT 'CREANDO PROCEDIMIENTOS ALMACENADOS (SPs)';
PRINT '========================================';
GO

-- ====================================================================
-- SP 1: Procesar Nueva Suscripción y Generar Factura
-- Lógica: Crea la suscripción y su factura automáticamente en una sola transacción.
-- ====================================================================
CREATE OR ALTER PROCEDURE sp_nueva_suscripcion
    @idUsuario INT,
    @idNivel INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION; -- Iniciamos la transacción segura

        DECLARE @precio DECIMAL(10,2);
        DECLARE @idSuscripcion INT;
        DECLARE @impuesto DECIMAL(10,2);
        DECLARE @total DECIMAL(10,2);
        DECLARE @codigoTx NVARCHAR(100);

        -- 1. Validar que el nivel existe y está activo, y obtener su precio
        SELECT @precio = precio_actual 
        FROM NivelSuscripcion 
        WHERE id = @idNivel AND esta_activo = 1;

        IF @precio IS NULL
            THROW 51000, 'El nivel de suscripción no existe o está inactivo.', 1;

        -- 2. Crear la Suscripción
        INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, estado, precio_pactado)
        VALUES (@idUsuario, @idNivel, GETDATE(), DATEADD(MONTH, 1, GETDATE()), 'Activa', @precio);

        -- Capturar el ID que se acaba de generar
        SET @idSuscripcion = SCOPE_IDENTITY(); 

        -- 3. Calcular Impuestos usando la Función Escalar (UDF) que creamos en la Parte 1
        SET @impuesto = dbo.fn_calcular_impuesto(@precio);
        SET @total = @precio + @impuesto;

        -- Generar un código de transacción único usando la fecha y el ID
        SET @codigoTx = 'TXN-' + CAST(@idSuscripcion AS NVARCHAR(20)) + '-' + REPLACE(CONVERT(NVARCHAR, GETDATE(), 112), '/', '');

        -- 4. Generar la Factura
        INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total)
        VALUES (@idSuscripcion, @codigoTx, GETDATE(), @precio, @impuesto, @total);

        COMMIT TRANSACTION; -- Si todo salió bien, guardamos los cambios definitivamente
        PRINT 'Suscripción y factura creadas exitosamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION; -- Si algo falló, deshacemos todo para evitar datos huérfanos
        PRINT 'Error en la transacción. Se aplicó ROLLBACK de seguridad.';
        THROW; -- Relanza el error para verlo en pantalla
    END CATCH
END;
GO

-- ====================================================================
-- SP 2: Cancelar Suscripción
-- Lógica: Actualiza el estado a 'Cancelada' y corta las fechas de renovación.
-- ====================================================================
CREATE OR ALTER PROCEDURE sp_cancelar_suscripcion
    @idSuscripcion INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE Suscripcion
        SET estado = 'Cancelada', 
            fecha_fin = GETDATE(), 
            fecha_renovacion = NULL
        WHERE id = @idSuscripcion AND estado = 'Activa';

        -- Verificar si realmente se actualizó alguna fila
        IF @@ROWCOUNT = 0
            THROW 51001, 'Suscripción no encontrada o ya se encontraba inactiva.', 1;

        COMMIT TRANSACTION;
        PRINT 'Suscripción cancelada correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

PRINT 'Procedimientos Almacenados transaccionales creados exitosamente.';
GO