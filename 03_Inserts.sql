-- =====================================================
-- Lookups.sql - Datos de catálogos
-- =====================================================

-- ==============================================================================================
-- Universidad Central de Venezuela
-- Proyecto Fase 2: FanHub
-- Archivo: Lookups.sql
-- Descripción: Script de inicialización de datos maestros (Catálogos).
-- Instrucciones: Ejecutar este script DESPUÉS de crear las tablas y ANTES de insertar 
--                usuarios, creadores o publicaciones.
-- ==============================================================================================

USE FanHub_BD; 
GO

PRINT 'Iniciando carga de datos de Catálogos...';

-- ==========================================
-- 1. Inserción de CATEGORÍAS
-- ==========================================
-- Nota: Se desactiva la propiedad IDENTITY temporalmente para forzar los IDs exactos.
-- Esto es importante para mantener la integridad referencial con otras tablas que usarán estos IDs como FK.
-- No necesitan hacer esto si no les importa el orden específico de los IDs, pero es una buena práctica para datos maestros como estos.
IF OBJECT_ID('Categoria', 'U') IS NOT NULL
BEGIN
    -- Intentar encender el IDENTITY_INSERT (fallará silenciosamente si la columna no es identity, lo cual está bien)
    BEGIN TRY SET IDENTITY_INSERT Categoria ON; END TRY BEGIN CATCH END CATCH;

    INSERT INTO Categoria (id, nombre, descripcion) VALUES
    (1, 'Gaming', 'Transmisiones en vivo de videojuegos, eSports y speedruns.'),
    (2, 'Fitness', 'Rutinas de ejercicio, nutrición, dietas y bienestar físico.'),
    (3, 'Tecnología', 'Reseñas de gadgets, tutoriales de programación y software.'),
    (4, 'Arte Digital', 'Ilustraciones, diseño gráfico, modelado 3D y animación.'),
    (5, 'Música', 'Covers, composiciones originales, partituras y clases de instrumentos.'),
    (6, 'Cocina', 'Recetas paso a paso, técnicas culinarias y repostería.'),
    (7, 'Vlogs', 'Blogs en video sobre estilo de vida, moda y viajes alrededor del mundo.'),
    (8, 'Educación', 'Cursos, apoyo académico, idiomas y divulgación científica.'),
    (9, 'ASMR', 'Contenido auditivo y visual relajante (respuestas meridianas sensoriales).'),
    (10, 'Comedia', 'Sketches, stand-up, parodias y contenido humorístico en general.'),
    (11, 'Moda y Belleza', 'Maquillaje, cuidado de la piel, outfits y reseñas de productos.'),
    (12, 'Viajes', 'Turismo, guías de ciudades, mochileros y reseñas de hoteles.'),
    (13, 'Finanzas Personales', 'Inversiones, criptomonedas, ahorro y educación financiera.'),
    (14, 'Deportes', 'Análisis de partidos, noticias deportivas y entrevistas a atletas.'),
    (15, 'Cine y TV', 'Reseñas de películas, análisis de series y noticias de Hollywood.'),
    (16, 'Literatura', 'Reseñas de libros, clubes de lectura y consejos de escritura.'),
    (17, 'Manualidades', 'DIY, costura, carpintería y proyectos para el hogar.'),
    (18, 'Política y Noticias', 'Análisis de actualidad, debates y reportajes de investigación.'),
    (19, 'Mascotas', 'Adiestramiento canino, cuidados, acuarios y veterinaria básica.'),
    (20, 'Astrología y Esoterismo', 'Horóscopos, tarot, espiritualidad y meditación.'),
    (21, 'Cosplay', 'Creación de trajes, props, maquillaje FX y sesiones fotográficas temáticas.'),
    (22, 'Fotografía y Modelaje', 'Sesiones de fotos profesionales, detrás de cámaras y poses.'),
    (23, 'Anime y Manga', 'Reseñas, teorías, fan-fiction y discusión sobre cultura otaku.'),
    (24, 'Podcasts', 'Programas de audio, entrevistas, storytelling y charlas en formato episódico.');

    BEGIN TRY SET IDENTITY_INSERT Categoria OFF; END TRY BEGIN CATCH END CATCH;
    PRINT 'Catálogo [Categoria] insertado correctamente (24 registros).';
END
ELSE
BEGIN
    PRINT 'ERROR: La tabla Categoria no existe. Verifique su DDL.';
END
GO

-- ==========================================
-- 2. Inserción de TIPOS DE REACCIÓN
-- ==========================================
IF OBJECT_ID('TipoReaccion', 'U') IS NOT NULL
BEGIN
    BEGIN TRY SET IDENTITY_INSERT TipoReaccion ON; END TRY BEGIN CATCH END CATCH;

    INSERT INTO TipoReaccion (id, nombre, emoji_code) VALUES
    (1, 'Me gusta', N'👍'),
    (2, 'Me encanta', N'❤️'),
    (3, 'Me divierte', N'😂'),
    (4, 'Fuego', N'🔥'),
    (5, 'Me entristece', N'😢'),
    (6, 'Me asombra', N'😲'),
    (7, 'Me enfurece', N'😡');

    BEGIN TRY SET IDENTITY_INSERT TipoReaccion OFF; END TRY BEGIN CATCH END CATCH;
    PRINT 'Catálogo [TipoReaccion] insertado correctamente (7 registros).';
END
ELSE
BEGIN
    PRINT 'ERROR: La tabla TipoReaccion no existe. Verifique su DDL.';
END
GO

PRINT 'Carga de Catálogos finalizada exitosamente.';


-- ==========================================
-- 1. USUARIOS (260 registros reales)
-- ==========================================
PRINT 'Insertando 260 usuarios reales...';

INSERT INTO Usuario (email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo) VALUES 
('lorena.garcía.romero1@icloud.com', '56AC9000531BE734636C7ED09AE7B82A834C58B065FC13264789B8CB9AD89F07', 'lorgarero1', '2025-10-14 22:14:00', '1990-06-06', 'República Dominicana', 1),
('jesús.romero.torres2@yahoo.com', 'E01B07F33B64DF25CEFE40E3DD5132E3D4EB1042888732D536F88743012F1672', 'jesromres2', '2024-05-24 22:14:01', '2004-03-17', 'República Dominicana', 1),
('isabel.fernández.álvarez3@outlook.com', 'F0EB26B40BC5ADD88CAC874047491AB0A59F696316AAE67C61DEEA8DDD70E58E', 'isaferrez3', '2024-11-20 22:14:01', '1962-08-14', 'México', 1),
('raquel.fernández.moreno4@hotmail.com', '597E453A69D41F485626A546D3DE926A1FC050BE503A06DAAE654230465C7AB1', 'raqfereno4', '2025-11-24 22:14:01', '2001-12-29', 'Perú', 1),
('diego.martín.sanz5@protonmail.com', 'B7778DE323D18422DF6A9D7962A941187D83495FC6D0C4BF199367DD73A5E196', 'diemaranz5', '2024-06-09 22:14:01', '2009-01-18', 'Bolivia', 1),
('rosa.sánchez.lópez6@msn.com', '5AD4F56061A650FB37F535AF06AEEF097F581682BF2F9582DEEA619371E41E22', 'rossánpez6', '2024-05-31 22:14:01', '2012-05-27', 'Paraguay', 1),
('sara.castro.torres7@msn.com', 'C2E05C9B15C5C46B070C0CE3F891AB62E4BFAAA791448AE7F3D7F5543D8D3286', 'sarcasres7', '2024-09-27 22:14:01', '1978-12-18', 'República Dominicana', 1),
('beatriz.lópez.gómez8@gmail.com', '9E7F6B8C542D20D88703D0C03842ED736CDE054544783E35576887B4F1798EA2', 'bealópmez8', '2025-11-22 22:14:01', '1978-07-09', 'México', 1),
('jesús.moreno.ortega9@icloud.com', '8C2FCD437E9E87A5DB20884390E61C6E6B68B18C4D7CB071466066791E660FDD', 'jesmorega9', '2026-02-18 22:14:01', '1972-10-18', 'España', 1),
('miguel.ruiz.hernández10@icloud.com', '581A5293C5977D69EBA63000B54AB70D503ACC6CAAE95C27567CFA17056BC27A', 'migruidez10', '2024-06-23 22:14:01', '1997-06-12', 'Ecuador', 1),
('teresa.gómez.ruiz11@msn.com', 'F6EA23FFA49E5B56C24775E5D83F3C28B9E613397F825B30B28FCC6964593D71', 'tergómuiz11', '2024-12-09 22:14:01', '1978-01-09', 'Ecuador', 1),
('rubén.sánchez.hernández12@live.com', 'D1FD56E62584C04EA49E42DAB25B99D6D5DDC4F447D056922F9240087A09B0E2', 'rubsández12', '2024-06-29 22:14:01', '1985-06-16', 'Estados Unidos', 1),
('alejandro.martínez.iglesias13@outlook.com', '5FC574FBD5885191F45BBEBA154B798BE7CC09D05C01BA8455C330174DE0D5C5', 'alemarias13', '2026-01-15 22:14:01', '1965-12-11', 'Estados Unidos', 1),
('teresa.fernández.delgado14@live.com', 'AD4358B1F47935AC0B27640A1BFC128BCBABAEC4387B1E56745E39855E4B67CB', 'terferado14', '2024-11-08 22:14:01', '1995-06-10', 'Uruguay', 1),
('lorena.gómez.torres15@icloud.com', '2A1ABB3835044D554F6DE3ED56374024FEBF16185F951C977D4DF9218051A85C', 'lorgómres15', '2025-05-21 22:14:01', '1982-10-05', 'Ecuador', 1),
('silvia.gómez.sánchez16@protonmail.com', '243D8778FBBF98E3764105D9F57ECB3702E3980BD4B15B4965C34A0B64825D61', 'silgómhez16', '2025-10-16 22:14:01', '1963-07-24', 'Perú', 1),
('hugo.ramírez.díaz17@msn.com', 'FEE6CA75D432101E0E45B18B19764F7FAE35BC2BF2F836F96873756CCA2C196C', 'hugramíaz17', '2025-08-07 22:14:01', '1958-05-25', 'Colombia', 1),
('álvaro.álvarez.morales18@yahoo.com', '63ECDE71DAA178EC41CCEED5C067EDA8992E51EC07C708A274D94E5D11A64514', 'álválvles18', '2024-08-13 22:14:01', '2004-11-18', 'Ecuador', 1),
('patricia.morales.martín19@gmail.com', 'C7079A44F784B867F4E773A12AC02F9ECA98209D184BFC7B880DF5D25316D52A', 'patmortín19', '2026-01-10 22:14:01', '1956-05-12', 'Chile', 1),
('juan.díaz.hernández20@msn.com', 'F5510B9525E15609A8EEDBE22EA93B2252B11A285B8101E1AB7A582E29AB1A8E', 'juadíadez20', '2024-06-12 22:14:01', '2000-07-28', 'México', 1),
('elena.alonso.gonzález21@outlook.com', '2DAF2428EA20B68D91EA494BCA66FDAD9FD3B1DE6551F0DC92964F9893008F18', 'elealolez21', '2025-01-07 22:14:01', '1986-02-02', 'Venezuela', 1),
('carmen.ortiz.hernández22@live.com', 'B8D1BDA91A7A6C70E8CDFD1EB05560839EBC6DB272831B8FB71ABDEDE761F8A3', 'carortdez22', '2025-10-10 22:14:01', '2002-09-02', 'Bolivia', 1),
('ana.hernández.ruiz23@protonmail.com', '8A4B7C55E4586FE53564D7B19AEB78F9401B31BB5CCDD182E4F3DE3788105505', 'anaheruiz23', '2025-10-23 22:14:01', '2005-05-23', 'Ecuador', 1),
('carmen.serrano.alonso24@gmail.com', '731D775CAC39EF82CB3025EAD439FE20CE7E21C259167CC458C80C5AA7989608', 'carsernso24', '2026-02-04 22:14:01', '1999-03-04', 'Ecuador', 1),
('isabel.ramos.fernández25@msn.com', '4892AF250550D1D0D3A41E50E19573AF681516A41A4981D9256F3510AFD9AA9F', 'isaramdez25', '2025-01-10 22:14:01', '1958-06-06', 'España', 1),
('sergio.blanco.gonzález26@yahoo.com', 'E182C02C38D5B05D6E81EEDAC08EC673D674F97E34E1D88677702C4E777C82CF', 'serblalez26', '2024-08-12 22:14:01', '1966-11-17', 'Ecuador', 1),
('claudia.blanco.gil27@hotmail.com', '8D6561CBE4DE8F562626A3FFACAD66AC9CCEE5E2278D6DC0359BC0026AA35A8A', 'clablagil27', '2024-07-17 22:14:01', '1958-02-22', 'Estados Unidos', 1),
('david.gonzález.domínguez28@outlook.com', 'AC1BE60A9088417609EDA812B322B20150E00739F3A187A423EBCA5C5593FB6D', 'davgonuez28', '2025-06-03 22:14:01', '1986-02-03', 'Colombia', 0),
('fernando.morales.lópez29@live.com', 'F22733957E858E76F0F6B7E1D608770BC587FE8F3EA46BE84CFC64789D561340', 'fermorpez29', '2025-09-26 22:14:01', '2000-01-05', 'Costa Rica', 1),
('óscar.díaz.hernández30@yahoo.com', 'DB416332120AB7C565009D0D180F580A0F468183A9FCA675EBCE91D402866258', 'óscdíadez30', '2024-11-02 22:14:01', '1973-08-15', 'México', 1),
('marta.navarro.ramos31@gmail.com', '8D1ECDE12FEE28535DEA56BDFD31DC90BC26B5D595747A120C199A97C2C38B91', 'marnavmos31', '2025-10-24 22:14:01', '1994-10-16', 'Estados Unidos', 1),
('fernando.fernández.ramírez32@outlook.com', 'B61704AD5416DCAD04D5DCFC55FB272AD734A405D6E1D03CA384AB75C4CE03BC', 'ferferrez32', '2024-09-30 22:14:01', '1956-08-11', 'Estados Unidos', 1),
('rubén.martín.morales33@live.com', '32F6677A996E585408C0B5E22E96B48FB66A27998EFA8E60046A888A097D0014', 'rubmarles33', '2025-08-25 22:14:01', '2002-09-23', 'República Dominicana', 1),
('jorge.pérez.gómez34@gmail.com', '0E1ACA91341FB34D0891EC237FD6ECCE16740C53E303BFFDDE14B503E34E832C', 'jorpérmez34', '2024-06-08 22:14:01', '1987-08-10', 'México', 1),
('laura.sanz.delgado35@gmail.com', 'CF4B725214579C5F9DED9BEF6EC993CE984F8B284DB255CACDFCA007559F30E7', 'lausanado35', '2024-08-24 22:14:01', '1982-08-25', 'Bolivia', 1),
('carlos.delgado.sánchez36@live.com', 'FF3DE93F9159F50CAD31F0309D5CF9560D945D3F2509960C8EDA4226C5C29C10', 'cardelhez36', '2025-03-05 22:14:01', '1996-04-09', 'España', 1),
('iván.ramos.alonso37@yahoo.com', 'B4EE2543777836D46C0484B7B22E8142920911B6C96C5217919464B159F416CC', 'iváramnso37', '2024-10-18 22:14:01', '2006-04-28', 'Chile', 1),
('carmen.sanz.medina38@hotmail.com', 'E9F3A1BEFD46FDED9D898D88FCB7584B5E4BBE03F5A4A71C61AF9C66A74E98D7', 'carsanina38', '2026-02-04 22:14:01', '1986-05-10', 'Paraguay', 1),
('cristina.delgado.martínez39@outlook.com', '94F843DE426B1AA83C259DF62AA37732236C11514E543DC1442ACE7C2B87DB22', 'cridelnez39', '2025-08-08 22:14:01', '1977-02-07', 'Estados Unidos', 1),
('luis.ruiz.ruiz40@protonmail.com', '227F552A235D360CB634DFCF11D27F4DEA0BE5E7A4AB56110B4537BA4FC580FF', 'luiruiuiz40', '2025-03-04 22:14:01', '1956-01-27', 'Venezuela', 1),
('maría.lópez.martínez41@outlook.com', 'B5B8C7243E95256465A0D5A8D4644E67568222ECEB28E263696EB0F943318BCD', 'marlópnez41', '2025-12-10 22:14:01', '2012-05-14', 'Chile', 1),
('yolanda.navarro.navarro42@gmail.com', '1DCBD5B79B9AE52860AD4E54B4334B1E263AAF7D42F581729E01C16F76B5A1A1', 'yolnavrro42', '2026-02-21 22:14:01', '2006-04-04', 'Bolivia', 1),
('claudia.jiménez.fernández43@yahoo.com', 'DFA84AB62BCB75ADABA0247CDA93F107A8D50EF768EBE3D011E896039F4CD1F8', 'clajimdez43', '2026-01-28 22:14:01', '1977-03-05', 'Argentina', 1),
('carmen.jiménez.rubio44@hotmail.com', 'D64A0713CCCCCED18F27D8FD63B69579B5A7DAD8D3830708AF7F30AF290A4CA9', 'carjimbio44', '2024-07-29 22:14:01', '1963-01-19', 'República Dominicana', 1),
('natalia.moreno.gil45@outlook.com', '0E2C3F9A1EAFE5F3EF9AF859ED79D578295B6033C4435EEA36640BDAD7D0EA6E', 'natmorgil45', '2025-06-20 22:14:01', '1999-08-31', 'Argentina', 1),
('maría.romero.pérez46@msn.com', '1723E6D5E9A69BE55BF970BE5264BAA50DE301455A39FDC81EC7C176D4589B86', 'marromrez46', '2024-04-25 22:14:01', '2006-12-16', 'Costa Rica', 1),
('rubén.alonso.serrano47@msn.com', '57E1064A116E28A1A68413AE3B4BDA25B6072296C2B57A3504AF044C054BC16B', 'rubaloano47', '2025-07-06 22:14:01', '1999-08-27', 'Uruguay', 1),
('teresa.fernández.moreno48@outlook.com', '22F3F34FB06C9CC1E3FF62ED8A1BF75EA403980C30543A863CFBE3AAE512FA46', 'terfereno48', '2025-04-16 22:14:01', '2000-03-04', 'Ecuador', 1),
('beatriz.gonzález.vázquez49@outlook.com', 'F02A9A1B83E90149ECDC51EE9671A7B60EF389C30116355D0F32BDBF7DE8A471', 'beagonuez49', '2025-06-19 22:14:01', '2011-08-25', 'España', 1),
('ricardo.garcía.marín50@msn.com', 'FFFBFC61EFED19FC8B5A41CC911186A73D1BCE41157EAC78C5C5C6FDA79022E7', 'ricgarrín50', '2025-05-09 22:14:01', '1987-01-16', 'Guatemala', 1),
('irene.díaz.blanco51@yahoo.com', 'C80071EFC95964729A8F0AECC1D7F76479D8629CBB09E3CDD9323632021DA814', 'iredíanco51', '2026-02-26 22:14:01', '2003-08-25', 'Costa Rica', 1),
('eduardo.sánchez.marín52@yahoo.com', '2764B326E136E5925DFA729CEF8F28F4EE81B085C39380839ECBBC5D0C374B53', 'edusánrín52', '2024-07-04 22:14:01', '1999-02-16', 'Uruguay', 1),
('maría.martínez.hernández53@hotmail.com', '0655D4E33FE6D438C90FD6950273937D1A5467BE9C6155AB67FB1BF1A41C8FE8', 'marmardez53', '2024-12-20 22:14:01', '1983-04-30', 'Perú', 1),
('carlos.hernández.gómez54@icloud.com', '11F72B9D986953ACCDB317FBAC1608FD6DADC4DE98A91A800563C864B1C31083', 'carhermez54', '2025-07-29 22:14:01', '1990-11-29', 'Guatemala', 0),
('marta.blanco.navarro55@yahoo.com', 'E132A91EC78F5FDA73C59967A783F85FE3A2FB0F3311DB48BAEF22B01E4715DD', 'marblarro55', '2024-10-29 22:14:01', '1965-04-19', 'España', 1),
('natalia.sanz.pérez56@icloud.com', '4828E1C22381E5B31E6BF185008CDCDBC458CABBA0BB672867FD331EC39A66FB', 'natsanrez56', '2025-10-29 22:14:01', '1974-07-08', 'Perú', 1),
('marta.rubio.morales57@yahoo.com', '13BCF44A6D7907C9393AB43A42025C1B5645F26BDFDD45A6361317158B54CFCE', 'marrubles57', '2025-10-06 22:14:01', '2009-02-07', 'México', 1),
('natalia.vázquez.rubio58@protonmail.com', '33DD70B72D21BCDB1D46288B94D97A8B44C2FF8134F31025FC4C19B40205B75F', 'natvázbio58', '2025-12-05 22:14:01', '1976-04-04', 'Venezuela', 1),
('hugo.gonzález.lópez59@gmail.com', '320DC257E5D1AAAAEB745740F9CF23FA745791A91ED3C19492A03AAB182A01B6', 'huggonpez59', '2024-11-14 22:14:01', '1981-02-26', 'Uruguay', 0),
('patricia.gómez.delgado60@yahoo.com', '88E5C946EA0F7604C153C6F0AE15E389DAC7FDCF152CE79198035DC74BB8BE80', 'patgómado60', '2024-04-01 22:14:01', '1999-06-28', 'Chile', 1),
('adrián.molina.gutiérrez61@outlook.com', '6338511AEAE930540E9B78E1550AE08A8C6C8AD62843E951B510CF105BF0013F', 'adrmolrez61', '2025-12-02 22:14:01', '2004-06-15', 'Bolivia', 1),
('luis.navarro.gil62@yahoo.com', 'C7942FDCF3BB3C24F8232E59CB3C811C95A695C27858A5B2D09F6BB160C47293', 'luinavgil62', '2025-02-28 22:14:01', '1963-05-08', 'Uruguay', 1),
('luis.serrano.moreno63@protonmail.com', 'AB193CBCCF6FBF57F51617D59B818BB93F9F14CD7808E209DF80D5AF65E63058', 'luisereno63', '2025-11-22 22:14:01', '1986-07-29', 'México', 1),
('hugo.castro.blanco64@outlook.com', '3C3CF2C325F1831B8DD4DE1876D87F45676CB524524021AE34673EA6903FD38B', 'hugcasnco64', '2025-10-29 22:14:01', '2000-04-20', 'España', 1),
('sofía.domínguez.álvarez65@outlook.com', '0062DA0FB6540D2CB6818B1B7A62FF9569CFC5AF2E2B7334B570A566213802B6', 'sofdomrez65', '2024-09-25 22:14:01', '1957-11-25', 'Bolivia', 1),
('marta.garcía.lópez66@gmail.com', 'FE1593E824550BC58D43442E960E21AD5C4E2156A1094CF7CEC27258B40E2DC6', 'margarpez66', '2025-12-29 22:14:01', '1995-11-19', 'España', 1),
('marta.morales.romero67@icloud.com', '667BA06BBF4BEAF4F2C4E143553175AF06BC10D12B18B2CB2FDE4E8F77B3B3B1', 'marmorero67', '2024-03-18 22:14:01', '1973-11-01', 'Argentina', 1),
('josé.ramos.iglesias68@outlook.com', '0D9E777350D09CCE77EF2EC830B7A05204F4AB40FD852E0657F066F8CC9A5D92', 'josramias68', '2025-04-20 22:14:01', '1956-04-08', 'Venezuela', 1),
('david.ramos.molina69@icloud.com', '4E50BE7D909AB218839942D01B81BD677AAA42A39FBEE9C109AFC5EF878F55BF', 'davramina69', '2025-08-20 22:14:01', '1984-03-10', 'México', 1),
('lorena.alonso.ortiz70@hotmail.com', '948B7CBEC46EC5DBAF4DE3432FEEBC7503BE8FE315A412463CDCF78EA57D37B0', 'loralotiz70', '2025-02-22 22:14:01', '1999-07-02', 'México', 1),
('carlos.blanco.navarro71@protonmail.com', '21815380632E0CC9463D20D7912D36A77910DDD562CF359B6847157FF147D43F', 'carblarro71', '2024-03-19 22:14:01', '1994-06-23', 'México', 1),
('laura.jiménez.fernández72@gmail.com', '2F6BF105A9631C2BF92E71A60BB980520850990BB052BE1445F2AEFB41006287', 'laujimdez72', '2025-01-23 22:14:01', '1964-03-12', 'Ecuador', 1),
('laura.rodríguez.navarro73@icloud.com', '26D2D77F4580F602F122C530855FC23BDB93AA7A1B381D7F6DF0F71CC5FEEE0D', 'laurodrro73', '2025-01-24 22:14:01', '2008-04-11', 'Guatemala', 1),
('jorge.alonso.rubio74@gmail.com', 'D66D724BBA2E17D864B66E44EC0B1A3A0ED05C6355B4F217865306332A7E73EE', 'joralobio74', '2025-06-19 22:14:01', '2005-03-29', 'Guatemala', 1),
('josé.torres.serrano75@msn.com', '3BD761D139B756E2AA7C82F27E72238DE8E80382810B6CD9436A6FADF7F9BFA2', 'jostorano75', '2025-08-03 22:14:01', '2006-09-08', 'Perú', 1),
('rocío.pérez.alonso76@hotmail.com', 'D6C2FB13EC9D7D79ADCEF603EE5313963656D94F76C53ED6A62CA2EF5010C59C', 'rocpérnso76', '2025-11-30 22:14:01', '1966-10-15', 'España', 1),
('maría.gonzález.gómez77@live.com', 'B5CAED80C72C4E65AC86D4009C083ACBFDEF51C1244606028C4EF4AFDA8705E9', 'margonmez77', '2025-05-13 22:14:01', '1975-12-11', 'Perú', 1),
('eduardo.rubio.pérez78@hotmail.com', 'F9ABA326D49609653643B4A71D6B281E45078E6B629DBC4A24528FF7C97EB2CE', 'edurubrez78', '2024-11-17 22:14:01', '1992-01-01', 'Venezuela', 1),
('carlos.alonso.gonzález79@gmail.com', '1F1C5C7064B83C57B188761B364633DF4CB383DA0C8906A3E0E0A39EDECC0BC6', 'caralolez79', '2024-10-15 22:14:01', '1995-09-07', 'Guatemala', 1),
('álvaro.blanco.sánchez80@live.com', 'DD272CB49E3870B5A670C8700D6E6B10CA8E0EC7B6BF0118AB8AEC4624846C4A', 'álvblahez80', '2025-10-01 22:14:01', '2009-08-12', 'Chile', 1),
('teresa.molina.ortiz81@hotmail.com', '5521A866AA5A0BB2BC864EE54A18CBFF73FF4A790672CC8731F2227961E40766', 'termoltiz81', '2024-09-19 22:14:01', '2001-09-20', 'México', 1),
('yolanda.suárez.rodríguez82@gmail.com', '2AB9BEC47B8502BCF4B4EF957C06085B29EF70F590A0E5AAA9EE16DF65336E29', 'yolsuáuez82', '2025-09-12 22:14:01', '1992-05-22', 'Argentina', 1),
('adrián.blanco.jiménez83@live.com', '7CB3E64853ECDBCE914C1F99240F2E37736ACE933D461A159C73754357AF572D', 'adrblanez83', '2025-08-05 22:14:01', '1977-03-20', 'Bolivia', 1),
('luis.iglesias.rodríguez84@yahoo.com', 'F0D85223167E7216FBF4552AC52E51DA8D09A975D0E1A4AC132359FF9BF4EB9A', 'luiigluez84', '2025-02-11 22:14:01', '1994-01-17', 'Ecuador', 1),
('teresa.ortiz.ortega85@msn.com', '55900430673543989CD2C0A84466AF0D5012A7402E564F16962AA50313554D25', 'terortega85', '2024-11-28 22:14:01', '1969-03-03', 'Bolivia', 1),
('hugo.delgado.torres86@icloud.com', 'A48249E92471AEACC9219F5FE58431DE74F83829E41F9D826C4CF944DE157ECF', 'hugdelres86', '2025-04-18 22:14:01', '1978-06-16', 'Bolivia', 1),
('teresa.navarro.jiménez87@gmail.com', '3D65C352DC1BE27F962D6E9611F141EE515E7042E9E48DAE4C0A1C87C84E35C2', 'ternavnez87', '2025-08-30 22:14:01', '1970-01-02', 'Venezuela', 1),
('diego.ruiz.ramírez88@protonmail.com', '2304DDEF13CD64155E8E4AEDE6D6F41A85610A9FA2A766277B8CACF9C8FE0BA3', 'dieruirez88', '2024-07-26 22:14:01', '1986-02-25', 'Estados Unidos', 1),
('cristina.ortega.suárez89@gmail.com', '2B625446B3D0079F80FDE4A940B556CEB2F13B7D4D1C3B09A41436D4B1B42FBD', 'criortrez89', '2025-03-07 22:14:01', '2008-02-24', 'Perú', 1),
('pilar.vázquez.iglesias90@gmail.com', '0D8A00B8B3E76965E431EF69229E1917CB30A3CD2687C5C302149A11022D557B', 'pilvázias90', '2026-02-02 22:14:01', '1991-02-16', 'Paraguay', 1),
('sergio.martín.sánchez91@icloud.com', '67838B8750CBB09577C231D1AF4294C94AF57287F254419349426CE384BDB753', 'sermarhez91', '2024-11-02 22:14:01', '1977-11-18', 'México', 1),
('rubén.torres.iglesias92@msn.com', 'E4FDA469AE658F868BCB5451AD5F754FC82306D48EB77EE6A09184BFBB3DB762', 'rubtorias92', '2025-12-26 22:14:01', '1966-01-03', 'Colombia', 1),
('irene.delgado.lópez93@outlook.com', '006E6D658C4E35E9C0CB43E31E579F9DD88A7AA5317052D340E21DB647D4A0B1', 'iredelpez93', '2024-11-14 22:14:01', '1992-12-27', 'Bolivia', 1),
('diego.torres.martín94@yahoo.com', 'D81C68123B7D3752BC6672E53363E9E6EAC2E72E80747EAB6E4AB0F42541A6EE', 'dietortín94', '2025-10-30 22:14:01', '2008-12-04', 'Argentina', 1),
('juan.fernández.lópez95@icloud.com', '90C96BC4CDF1CCE251E64F3D5CEAF73E9442FB0230BFF4F99F7DA05DA1E6E699', 'juaferpez95', '2025-09-18 22:14:01', '2007-07-07', 'República Dominicana', 1),
('luis.serrano.garcía96@live.com', 'DCA746B14F22B661B8DC3710D6168E2FA91FE99E89AF3213CD94B1E839E184E4', 'luisercía96', '2026-02-26 22:14:01', '1975-05-10', 'Paraguay', 0),
('elena.navarro.alonso97@yahoo.com', 'AA637DECBD55ACD2C9357F9687C028DD46436BEFB84DFC1647DA69D0029A03C2', 'elenavnso97', '2026-01-11 22:14:01', '1956-07-29', 'Uruguay', 1),
('daniel.fernández.blanco98@msn.com', '9CC5378D155B815233D2DE292CD2EAA778B70F6A6F712B823BA7AA9313E2C14E', 'danfernco98', '2025-03-03 22:14:01', '1983-04-29', 'Perú', 1),
('miguel.serrano.serrano99@protonmail.com', '7FA2CC04161C1BDA32BC555B84B98C4EEAB99309CE4DFE94C9994B86BD0A1D6B', 'migserano99', '2025-08-03 22:14:01', '1986-09-20', 'Costa Rica', 0),
('rubén.ruiz.garcía100@msn.com', '0F2B0504F6F683DE7E5CA4F32BFBAB99018734499597AC8CFE5384D9ABEC4C5C', 'rubruicía0', '2024-04-10 22:14:01', '1977-01-02', 'España', 1),
('javier.hernández.marín101@live.com', '4BD088067A13DE16DA4A75AF82F7502C5E2D7A540287FCB4577794EB19869429', 'javherrín1', '2024-04-22 22:14:01', '2010-11-23', 'Uruguay', 1),
('cristina.ortiz.gutiérrez102@icloud.com', '39ACCA4F4B52EE61CBF44847CF3A163E36C9FC337F8E4FA3AED0CCDEB5D6D8EA', 'criortrez2', '2026-01-29 22:14:01', '1968-06-29', 'Perú', 1),
('lorena.molina.moreno103@outlook.com', '4616A5FC0E4136354674DC62E6C83A8776ED24074F5069CF13D17BA297DF0095', 'lormoleno3', '2025-08-30 22:14:01', '2007-09-08', 'Colombia', 1),
('juan.marín.gómez104@icloud.com', 'BFBDC0BA7860FBDAF7B86539A197A8FDCFD8196443AEDE3A4E57260A486B566D', 'juamarmez4', '2024-03-28 22:14:01', '1998-03-31', 'Chile', 1),
('david.delgado.sánchez105@icloud.com', '3FFE3FDD8C4EBB4D4C6902F19BF7A1A9494BC84E81DE33CEABEF146FD3DE9126', 'davdelhez5', '2025-10-06 22:14:01', '1991-05-27', 'Colombia', 1),
('víctor.sánchez.sanz106@outlook.com', '3C256D9E02C4F254FDCC4BA328207E9D46A52FA09E75045D1E7F9070E6C02796', 'vícsánanz6', '2024-03-24 22:14:01', '1968-09-17', 'Guatemala', 1),
('luis.álvarez.moreno107@live.com', 'FDAFA279D4637F9528AF53E215B3ED5E1BADB32E7F3728BD29336E5EC3E2272A', 'luiálveno7', '2024-07-28 22:14:01', '1987-09-25', 'Perú', 1),
('rocío.ramos.ortega108@gmail.com', '87C3A6B666F61705DA8B8CF60ED03AD2B177F2FCC9DBF03FBDE90F3F9313BA0B', 'rocramega8', '2024-06-06 22:14:01', '1972-08-21', 'República Dominicana', 1),
('claudia.díaz.díaz109@protonmail.com', 'A932461498ED0A84ADC9AA7476458B6DE26893C1B8D08DFE47CE18312F5DA32B', 'cladíaíaz9', '2026-02-05 22:14:01', '1974-10-16', 'Perú', 1),
('pablo.gil.lópez110@icloud.com', 'C128DF5552AAF9D00CC94A53706A06A52F7DFCD5092E5112B4FA3FFDCFDCD8E8', 'pabgilpez10', '2025-10-29 22:14:01', '2004-07-08', 'Paraguay', 1),
('paula.marín.iglesias111@icloud.com', '84868DD627B1EFD5A992E04E36424ECADC8BD2F8D98C4CCBCA9844055C2AF6F2', 'paumarias11', '2024-11-11 22:14:01', '2008-12-23', 'Guatemala', 1),
('david.romero.morales112@live.com', 'D93508BFFEE93D66878F150ED3595C1F765633943DC93C2A0A4D7D01782D4F51', 'davromles12', '2025-10-09 22:14:01', '1970-04-26', 'Paraguay', 0),
('patricia.gutiérrez.torres113@outlook.com', 'F7A0527FF111B4D67D41E8113AAC151A0AB3C177110EEC81A54067000BB29566', 'patgutres13', '2024-06-18 22:14:01', '2006-01-05', 'Ecuador', 1),
('marta.navarro.pérez114@live.com', 'DF9BEBF1058C8415342DE598345265E72044F0532972DD0F44B23260840B7AA0', 'marnavrez14', '2024-12-02 22:14:01', '1967-05-18', 'Bolivia', 1),
('pablo.hernández.díaz115@yahoo.com', '06F2350B6432D12B66BEAA33D4EC3BCAD8E24AE28F9C8E99379FFBD5F4B2D7AC', 'pabheríaz15', '2024-06-11 22:14:01', '2008-02-04', 'Uruguay', 1),
('jorge.sanz.gonzález116@msn.com', 'F95555582F4EA6AB13AFB993F1CE7209C83DD20C946C38E73593ED114B4FC2EA', 'jorsanlez16', '2026-01-10 22:14:01', '1988-09-09', 'Ecuador', 1),
('ricardo.suárez.ramírez117@msn.com', '2A2D9D1DC1EE4EB800720DEB85CDC159BCBB1A737915D6371E18A24AC2164949', 'ricsuárez17', '2024-02-29 22:14:01', '1984-07-18', 'Guatemala', 1),
('hugo.gonzález.garcía118@msn.com', 'B80C1C152225EAF228FB96A6170B85AD5BF34D7CFC526272C1454EFC457E03A7', 'huggoncía18', '2024-10-02 22:14:01', '1958-06-22', 'España', 1),
('fernando.lópez.suárez119@protonmail.com', '80869EFB48346CCF4C24170485882C34606B1C580A1B0AAE2B03E35265343208', 'ferlóprez19', '2025-04-27 22:14:01', '1962-04-20', 'Perú', 1),
('sofía.pérez.ramos120@outlook.com', '6F9D9F114CDAB3D7DDF2B7EB91AC91553D1D66C6DF74AD2ED0C81AE63895960D', 'sofpérmos20', '2025-06-29 22:14:01', '1984-07-21', 'México', 1),
('josé.moreno.navarro121@msn.com', '545840C6AC68FF8A06F3C19353EC17F0D2800A745F4890AE22FC7C2D12521F8A', 'josmorrro21', '2025-06-26 22:14:01', '1977-06-13', 'España', 1),
('cristina.ortiz.lópez122@hotmail.com', '7BADE3925E2A104F6B89A029192EC1EA977ED1D92003FDF6658895DFB6D493F7', 'criortpez22', '2025-11-30 22:14:01', '1990-08-19', 'Ecuador', 1),
('david.pérez.castro123@hotmail.com', '5746220450F39D99F0DC3BBAAC76C9E7419BF8372BD24E386B5E0403BBC5218C', 'davpértro23', '2025-02-17 22:14:01', '1983-01-31', 'Colombia', 1),
('elena.gutiérrez.moreno124@live.com', '2BBFADF7D0103067124EDD6D85BB5EBFE434A34293927425F9D9ADCC30F42DA3', 'eleguteno24', '2026-02-04 22:14:01', '1974-05-23', 'Chile', 1),
('teresa.pérez.ramírez125@hotmail.com', '66C01B85099F1B7034B974E4A4A27FFCC5EB4BD9F8A749EBB2A6E702E33399C8', 'terpérrez25', '2024-09-12 22:14:01', '2004-09-24', 'Uruguay', 1),
('luis.navarro.sánchez126@hotmail.com', '6F99B6E8744C26092E7E39248AAE233AEA18AA4C3914E35D3FD63CD5558435C8', 'luinavhez26', '2024-07-15 22:14:01', '2012-09-29', 'Uruguay', 1),
('jorge.sánchez.pérez127@live.com', 'A711C3C71ABEDA47466F4FEF338CCC991C259AA5851AE75844469AD3B53F78BE', 'jorsánrez27', '2024-09-05 22:14:01', '1985-12-10', 'Uruguay', 1),
('andrés.rubio.iglesias128@gmail.com', 'C8ADE7C2F7447C47C4049A9BBF048640FEE4BB4603CD18F1B246B58F501F445E', 'andrubias28', '2025-12-08 22:14:01', '1976-02-24', 'España', 1),
('jesús.lópez.moreno129@icloud.com', 'F396084FBEBFC7EA00EDA14DD17935F9A3150177BFF6C8469A29E6FA0A7D6325', 'jeslópeno29', '2024-07-02 22:14:01', '1975-12-05', 'Costa Rica', 1),
('ricardo.navarro.rodríguez130@msn.com', 'A5F781136776B8FE0B357E928F8640790104B5F8A09E987B196D5CBE736731B3', 'ricnavuez30', '2025-11-12 22:14:01', '1983-01-24', 'Uruguay', 1),
('carmen.álvarez.díaz131@gmail.com', 'F3D2552330B690CB4FF5DC519F8F97C8F6E786D671C7E3EF31931A29401B0E95', 'carálvíaz31', '2025-12-30 22:14:01', '2007-03-08', 'Chile', 1),
('david.jiménez.alonso132@yahoo.com', '59FBD077EF8603B4065FB7A2D2C721FCDD25B5E44885F64B90B81B3E430917E5', 'davjimnso32', '2025-06-10 22:14:01', '1990-02-17', 'Argentina', 1),
('diego.gómez.gonzález133@outlook.com', 'D4EED254FC5237D307C8EFC8E03B27E44BC7102850D3A3B011DB3B8877319E5B', 'diegómlez33', '2025-06-15 22:14:01', '1988-03-07', 'República Dominicana', 1),
('raquel.garcía.medina134@outlook.com', 'AD65A6CDA4C687621B6AAF86C9EC46C67F6BCC72FC65BBEA3C1588EB0497B978', 'raqgarina34', '2025-02-25 22:14:01', '1996-01-21', 'Estados Unidos', 1),
('cristina.romero.gutiérrez135@live.com', '946FE2CDA0A2B9EAF0EA2D9449CE99AC9ED6D53FB12375F40AA99A1DCD9A10AB', 'criromrez35', '2024-07-25 22:14:01', '1981-07-14', 'México', 1),
('elena.gómez.vázquez136@protonmail.com', '8FEE018503D91F3E5E5E85FE448EB0D891FDB7552E07AEA27A4E7C6A6F578FFD', 'elegómuez36', '2025-08-30 22:14:01', '1961-04-03', 'España', 1),
('miguel.ruiz.navarro137@outlook.com', '7566776D97CE6E2AF2BCC08787B3BE865AEB3B33E665BCE22D15976DF331554F', 'migruirro37', '2024-10-16 22:14:01', '2012-04-03', 'Venezuela', 1),
('eva.iglesias.marín138@hotmail.com', '8FDAA49FAC60B7CE7914F1353248421E0B314DC5EC188805287CE47AF4ACA3F0', 'evaiglrín38', '2025-03-08 22:14:01', '1960-11-06', 'Venezuela', 1),
('paula.gil.navarro139@yahoo.com', 'B19C0EAD5214E5C7EF5127F1C1B6E3E526F3E9FF806C858AC936F2D7E1824702', 'paugilrro39', '2025-12-10 22:14:01', '1980-01-19', 'Guatemala', 0),
('cristina.rodríguez.álvarez140@hotmail.com', '0BCD4F32CB33A9CE778E7606DEA4557203F671EF3F8FE2ACD97AB7DF056397B0', 'crirodrez40', '2024-12-26 22:14:01', '1957-06-11', 'Ecuador', 1),
('isabel.vázquez.marín141@msn.com', '3FB68D9875FAB422089A91957CFE6EEEEA764F50008B477EBB99D4DEED9AC45C', 'isavázrín41', '2025-06-27 22:14:01', '2009-03-29', 'Chile', 1),
('ana.suárez.vázquez142@icloud.com', '5A7CDB08E7D00DF9503BACEF562560F289D541CA9D9283DDCCB24C9439BDA35B', 'anasuáuez42', '2025-03-16 22:14:01', '2007-09-27', 'Uruguay', 1),
('laura.vázquez.rubio143@protonmail.com', '724305A88C65DBBA16A7B6FCBF264B45734B8521F2C31FB3BF3798851C2BBB2B', 'lauvázbio43', '2024-08-05 22:14:01', '1996-04-17', 'Venezuela', 0),
('daniel.gutiérrez.martín144@hotmail.com', '5E6E197872CD131AB141D5A550630A293FEFE4ABC8A973E292647A5C59E4BE7D', 'danguttín44', '2025-12-27 22:14:01', '1980-05-11', 'Guatemala', 1),
('daniel.romero.sánchez145@msn.com', '94AB3E886438C0824190791DD25019B3D9CF0FE7F8FCF66874B942D9C00C6961', 'danromhez45', '2026-01-26 22:14:01', '1968-09-29', 'Bolivia', 1),
('fernando.martín.martínez146@hotmail.com', '18E299D40706C0963E62AD683690591F2B27A4797E48A2682E95799859826FE7', 'fermarnez46', '2025-04-09 22:14:01', '1967-03-25', 'Perú', 1),
('luis.moreno.marín147@protonmail.com', '560BB6A5AD269569F6AF7EEB7EEBBA620B1D28CD51F536D96D6537941FA0637A', 'luimorrín47', '2025-03-23 22:14:01', '1998-12-05', 'Chile', 1),
('laura.iglesias.blanco148@outlook.com', '730C7ACF3BF04E4839ED99E0C213C8C0D1222DC0ECEFA92CF2F2D0C6E7238732', 'lauiglnco48', '2024-06-17 22:14:01', '1992-09-02', 'Colombia', 1),
('silvia.blanco.vázquez149@live.com', 'AAD815B881F6289EEFF3EB641CC0557640A117399FBADB3A443D42F64106EFEE', 'silblauez49', '2025-12-24 22:14:01', '2009-06-22', 'Estados Unidos', 1),
('maría.gómez.rubio150@msn.com', '501A615FD43EFE5D20761107E823B707A4C4EC77D2C689AEF13C585B93FD10DB', 'margómbio50', '2025-03-05 22:14:01', '1964-04-21', 'Bolivia', 1),
('rosa.morales.serrano151@outlook.com', '1FD41F0E6A3EE796DD0F617240DF59F57A8E7C12866E0A6E806436253DCAFD1B', 'rosmorano51', '2024-04-05 22:14:01', '1990-12-19', 'Venezuela', 1),
('claudia.serrano.castro152@protonmail.com', '79FEC8DF9318980EA7D63F3E2E39ED441A27A6C7D6369A5534EA467C2CC76D89', 'clasertro52', '2025-09-02 22:14:01', '1997-10-21', 'Costa Rica', 1),
('daniel.navarro.moreno153@yahoo.com', 'CF9D8791C4F075D4A896BCE8892A0843B25D6DC720A92DCEADAFC3BA3380CC99', 'dannaveno53', '2024-10-27 22:14:01', '1984-05-26', 'Costa Rica', 1),
('carlos.molina.díaz154@outlook.com', '2D545E062C792633E599BD167049D5E8B7B19B26F933166C42B43D77D6CC91C5', 'carmolíaz54', '2025-12-23 22:14:01', '2003-04-07', 'Venezuela', 1),
('david.marín.iglesias155@gmail.com', 'D7E6BB19CD1EE50954C03EA0F80E06BD1F97501E418894D87B16B704794A0033', 'davmarias55', '2024-12-15 22:14:01', '1980-02-25', 'Paraguay', 1),
('jesús.ortega.navarro156@live.com', '32269C6D5F324F2D7BF242277297011B02EF892AC3BD33546FE1E22AF9A58228', 'jesortrro56', '2025-10-11 22:14:01', '1974-05-08', 'Guatemala', 1),
('eva.sanz.rubio157@outlook.com', '01252B6ABF7A9BEA260DA7EDC5256148DC6D185AEE583AE3AD8BE0F77240E36B', 'evasanbio57', '2025-06-30 22:14:01', '1997-12-16', 'Costa Rica', 1),
('marta.torres.rodríguez158@protonmail.com', 'C2B80829B2AABAF3FFEBC31DFCFDEFDE62497637AB9423B4F528F7112C52F2BD', 'martoruez58', '2024-04-06 22:14:01', '1966-04-28', 'España', 1),
('sara.álvarez.ruiz159@yahoo.com', '039CA660C3844404558F9C7FCC8124D7762E2DB7DBAD91AE6426DA5A3A8ED3EC', 'sarálvuiz59', '2025-01-07 22:14:01', '1965-12-13', 'Guatemala', 1),
('fernando.gómez.gonzález160@live.com', '4D90669B3C7C058C81BB4C39799960EB5AE65A374DE95C31423EB4B77D0FF05F', 'fergómlez60', '2025-02-10 22:14:01', '2012-11-25', 'Perú', 1),
('rocío.suárez.ortiz161@yahoo.com', '8AF77882AF9FB974A3297F95E800D4E11738F77E7E7C90BA69C1FB8A2FE2F3A7', 'rocsuátiz61', '2025-12-13 22:14:01', '2010-02-08', 'Guatemala', 1),
('isabel.rodríguez.martínez162@hotmail.com', 'A942550E52655B9825A06CA8E01C1CEF040EC72C19AE9D261BA8553B7EC4291A', 'isarodnez62', '2025-02-26 22:14:01', '1987-01-30', 'Costa Rica', 1),
('silvia.jiménez.castro163@outlook.com', '7895310F09EBDCF81682FBA4EDBD05F8E9B7B1E0B0325C304DA9EDAC3CA8BC42', 'siljimtro63', '2024-06-22 22:14:01', '1996-05-24', 'Venezuela', 1),
('luis.ortega.garcía164@yahoo.com', '27CF2C12A4053CC64D7507DCB90DF7BD473ED1C3E1F7B01BDD8BBF4AC46D02E2', 'luiortcía64', '2025-02-19 22:14:01', '1998-04-26', 'Estados Unidos', 1),
('andrés.martínez.molina165@live.com', 'DD3DAC36A856A9D5BF34D74FFF9AABD69C01DF8DEC07695A3781BF05DF63585F', 'andmarina65', '2025-02-07 22:14:01', '1956-11-19', 'Venezuela', 1),
('carlos.martínez.martínez166@yahoo.com', 'FED41436B1C7937183B371D58E25BACB91DBEEEB977EBA9CD15269A77EC4C03F', 'carmarnez66', '2024-03-10 22:14:01', '1964-03-29', 'República Dominicana', 1),
('rubén.serrano.garcía167@live.com', 'DC94ABB1EE310098BA59A9920F7189DBD2A01CA24974D8A8ED8DBB81C545A582', 'rubsercía67', '2024-11-26 22:14:01', '1988-02-16', 'República Dominicana', 1),
('lorena.suárez.medina168@icloud.com', 'CC34C3E6422AE5417835B19A568470F8E8EDA1C4D07F8BB333C66632005DCD98', 'lorsuáina68', '2024-04-26 22:14:01', '1983-10-30', 'España', 1),
('hugo.moreno.lópez169@outlook.com', 'F0A345FA2D3A68D3CCBE353ACBFD104F2FF18AF307848E5DACCDBBA0D3152190', 'hugmorpez69', '2026-02-01 22:14:01', '1985-04-18', 'Uruguay', 1),
('rocío.sanz.ramos170@yahoo.com', 'FE6C578D121F3B2612F3EEE9BA773009F4CDAE1F26F7B6F5AF67FA900741B57A', 'rocsanmos70', '2024-07-27 22:14:01', '1988-07-24', 'España', 1),
('pablo.sanz.ortiz171@outlook.com', '8BFBAB57C52EC4BC52095F55B64B60454C93009B068088167B3F0D947FB905C5', 'pabsantiz71', '2025-01-08 22:14:01', '2006-11-17', 'Estados Unidos', 1),
('laura.iglesias.martínez172@live.com', '5CB8C97EC8C8F81806A1D778AFF3CFCA4333763576815F5EA1C545F71456C417', 'lauiglnez72', '2026-02-26 22:14:01', '2006-02-16', 'Costa Rica', 1),
('rosa.jiménez.domínguez173@protonmail.com', 'DDBD0E28E547532AFB9230BC1D02660C48E4F773A2B6C4AB220EDC4A7FB23AB9', 'rosjimuez73', '2024-09-04 22:14:01', '1990-03-18', 'Perú', 1),
('ricardo.ortiz.navarro174@yahoo.com', '75599CFD1B463C1F2222D98A7BF16814B06AFBD63069707432EB127E050434EE', 'ricortrro74', '2024-10-05 22:14:01', '1970-11-11', 'Chile', 1),
('víctor.iglesias.ramírez175@outlook.com', 'B52E82DD8CB1E2DB1836431C54A440B31A8C62BDB2C511651CB7FA0F6A1B6C94', 'víciglrez75', '2025-10-29 22:14:01', '1965-09-18', 'República Dominicana', 1),
('sara.ruiz.castro176@yahoo.com', 'D5F6E7CFD112E0184D5E9B49FB9B8069F842604E5AFA9F0474C612A1E90412D2', 'sarruitro76', '2024-11-09 22:14:01', '1993-11-18', 'Perú', 1),
('luis.martínez.ramírez177@hotmail.com', 'A6C9EF3C834D84DC831A002123907CD6F5E0197DBDF174E03A58EA81A70C3507', 'luimarrez77', '2025-07-27 22:14:01', '1978-03-12', 'Colombia', 1),
('sergio.suárez.rodríguez178@yahoo.com', 'F306770D7315A3A55C8439280B7618489AF44279CAD8F1E7D8511D03C9483614', 'sersuáuez78', '2024-08-11 22:14:01', '2005-03-10', 'Costa Rica', 1),
('alejandro.rodríguez.rodríguez179@protonmail.com', '922E2E06330D3207566B1806E085131BEF1528E45A726D720F10D6DC02790C42', 'aleroduez79', '2026-02-19 22:14:01', '1982-01-23', 'México', 1),
('carlos.blanco.marín180@live.com', 'BA7957144D38538351E339AB232ED8323AD268DD076737DE9A1A5B1FBA534FBE', 'carblarín80', '2024-12-09 22:14:01', '2010-07-07', 'Ecuador', 0),
('sofía.martín.sánchez181@live.com', '6B22385F809ECC236FF0DA4B9E8BFE45516F2954F746AF58D076125DEA9B672C', 'sofmarhez81', '2024-04-16 22:14:01', '1969-01-13', 'República Dominicana', 1),
('lorena.castro.hernández182@live.com', '5A2C073E804B050B31DBEFFBEF0A5538B01950F1D2D1E78A64ADED66276FCE2A', 'lorcasdez82', '2025-09-16 22:14:01', '2003-07-04', 'Guatemala', 1),
('óscar.gutiérrez.gil183@live.com', 'AC7ABDB60B74AF17DBA486B956F2265739E5AB0CE3829BC2D63100CE55D14ACB', 'óscgutgil83', '2025-05-24 22:14:01', '1989-11-15', 'Guatemala', 1),
('andrés.gonzález.morales184@gmail.com', '93D2F12CF85DA2A42E8A8BDEDCB1FE3D52D33A75EF3A42A23214EE49D6C88DBD', 'andgonles84', '2025-10-07 22:14:01', '1966-10-20', 'Paraguay', 1),
('rocío.medina.gil185@yahoo.com', '5648B6B7453BFCD807FA790195A9517E5D015C672D2F2D2974615A924763626C', 'rocmedgil85', '2026-02-15 22:14:01', '2011-07-13', 'Guatemala', 0),
('eva.domínguez.delgado186@icloud.com', '8C7D6EA3C0AA88ADA60801D9ED0E47257DE5964639BAF8FA18F9D8557CE04B44', 'evadomado86', '2025-06-24 22:14:01', '2011-05-17', 'Perú', 1),
('teresa.domínguez.rubio187@icloud.com', 'D38C2807D6F7053DD63EE0AE6970ECE5DE65EE96B5D362463E5214B0D2757F55', 'terdombio87', '2025-07-29 22:14:01', '1972-03-15', 'Uruguay', 1),
('andrés.gonzález.díaz188@yahoo.com', 'E5783B4CC6EB8DF245EA5307BBB6DAB2A904DC44588FB493523C70CADE5CB522', 'andgoníaz88', '2025-08-30 22:14:01', '2004-01-31', 'España', 1),
('luis.rodríguez.romero189@gmail.com', '67688AE17D921E88E7F892392515F7F42BE1529B2AE896828D8B141665E60974', 'luirodero89', '2025-02-12 22:14:01', '1980-08-02', 'Argentina', 1),
('cristina.ortiz.rodríguez190@protonmail.com', '9844D4FF083F590D9B59E3DF1FFBE0D75AEE0B0D769C784D6433AE42B4F637A4', 'criortuez90', '2024-12-13 22:14:01', '1960-03-09', 'Ecuador', 1),
('raquel.suárez.gonzález191@protonmail.com', '73A7120EE4CCCCFFF670217CF6F14F20326B0D427639D22B9F6D45851E5254D1', 'raqsuález91', '2025-09-09 22:14:01', '2007-05-17', 'Uruguay', 1),
('raquel.torres.jiménez192@icloud.com', '1644A4FE4BBF55ACFB69EC58F34CF5809F62197AF3F9DFE44ACED1D5BC386A4C', 'raqtornez92', '2024-11-19 22:14:01', '1996-12-22', 'México', 1),
('hugo.ramos.ramírez193@gmail.com', '7BB5DDDF7147E0D13CA2002AC4A1A84F764BB0376720FC6560CAC3C1E788E659', 'hugramrez93', '2025-08-25 22:14:01', '2011-07-29', 'México', 1),
('claudia.delgado.martínez194@hotmail.com', 'B7908662882D68ECBB7E4073FB53C10F85308A82A4DD8866CB4090E1BF1ABC30', 'cladelnez94', '2025-03-26 22:14:01', '1967-03-26', 'Estados Unidos', 1),
('juan.gonzález.ramírez195@icloud.com', '103C86F0925A546E1D66FEC9CBC9841E724FB748A88478C7CF4BA67D53FBD12B', 'juagonrez95', '2024-12-05 22:14:01', '1968-02-25', 'Argentina', 1),
('lorena.rubio.ramírez196@live.com', '7945E9D8BAB89F3EEBB7B9680B317A8BCA04D6184CF74EBF4A409402CFC1DF6C', 'lorrubrez96', '2025-03-04 22:14:01', '2005-09-22', 'Uruguay', 1),
('natalia.gómez.ortiz197@protonmail.com', '68E2767E42F828518576BA56A166ABF8CCAAB2FC4FD9B939A0B0C520911484D7', 'natgómtiz97', '2025-11-18 22:14:01', '1962-11-13', 'Ecuador', 1),
('teresa.díaz.delgado198@hotmail.com', '44CB3317E7DC27169BDD4B38D3556FE51FD586CA1F0393C133F636D42D8095C6', 'terdíaado98', '2024-05-09 22:14:01', '1983-12-02', 'Ecuador', 1),
('álvaro.molina.ramos199@gmail.com', 'F25018325AA3C83AFA9713A9FF1FCF0F51DB805FA8FFF151DCF193480EE71D31', 'álvmolmos99', '2024-07-30 22:14:01', '1993-09-13', 'República Dominicana', 1),
('ricardo.molina.jiménez200@outlook.com', '25318C9223BBEF10852B5D53BA2742B4891FC56B057F59C30912A8B5F4382AD5', 'ricmolnez0', '2025-10-24 22:14:01', '1992-10-10', 'Ecuador', 1),
('jesús.garcía.marín201@hotmail.com', '483D3A35C04C8275588E18B25ED628A4BB18A891E44BA1746A2D55C7BEC96FBC', 'jesgarrín1', '2026-01-18 22:14:01', '1984-01-12', 'República Dominicana', 1),
('irene.hernández.gil202@yahoo.com', '424C3ADA0ECA7EEFEE769A405B4913A06E0B049EC2D52E2489BF30F211B60FB1', 'irehergil2', '2024-11-27 22:14:01', '1983-05-28', 'España', 1),
('patricia.alonso.marín203@gmail.com', '101F59364CC33F75D5D1D2D4B9DB86098ABA992BEE83628D259DEDA40297A576', 'patalorín3', '2025-11-30 22:14:01', '1962-08-29', 'Estados Unidos', 1),
('miguel.romero.romero204@gmail.com', '427D5A31E5C2405984750E5A2D03331AC076690DBA4C1B0EF91FCE89CB455F4A', 'migromero4', '2024-09-24 22:14:01', '1987-10-08', 'Guatemala', 1),
('hugo.delgado.ortega205@yahoo.com', '51637997FB8866C23A1CDA888AFF8A301BC0DB292666EBE195AB0636D497A943', 'hugdelega5', '2025-10-20 22:14:01', '1980-07-29', 'Ecuador', 1),
('fernando.ortega.delgado206@gmail.com', '0DA914E627C56B814418297C7EDFD4A26868440944AB15B3C911EC120355B505', 'ferortado6', '2025-08-21 22:14:01', '1984-05-16', 'República Dominicana', 1),
('adrián.ortega.sanz207@protonmail.com', 'EC241888FB52E575E04A0792F1F03EE45914BD2EEA552709A0DB6759015DF517', 'adrortanz7', '2026-01-09 22:14:01', '1997-05-25', 'Bolivia', 1),
('adrián.gil.rubio208@outlook.com', '954B6BD66A7101310B5AE3829B1CAD765E753927357F08D9C415143345F437F8', 'adrgilbio8', '2025-12-15 22:14:01', '1980-01-04', 'Chile', 1),
('jorge.medina.martín209@live.com', '1FF3DFF73E73B5B2CBF20E0F4F99E1462F29AAD184213AD9208BC9CE26431F66', 'jormedtín9', '2025-10-06 22:14:01', '1961-12-17', 'Colombia', 1),
('hugo.rubio.ruiz210@hotmail.com', '268C85223373ABBAE36158F93735944CC616DBA2468C1871EEA4F8B296B4BDDF', 'hugrubuiz10', '2026-02-15 22:14:01', '1969-08-04', 'Colombia', 1),
('cristina.medina.ramos211@yahoo.com', '73CB3CA124BC6C90AFC91AB0A142D924385F728D662C686332EC83F90794B750', 'crimedmos11', '2025-10-06 22:14:01', '2000-08-20', 'Paraguay', 1),
('daniel.jiménez.sánchez212@gmail.com', 'E051BA8F50AD5CF4A07C0703E9C9BE4D312884FB496BB33ADCE351CA3DD71C17', 'danjimhez12', '2024-07-28 22:14:01', '2010-05-29', 'Paraguay', 1),
('paula.gil.suárez213@gmail.com', '2C55E24F02D98D9A349A2454EEA3A2AE22B83296A321B1DA7B9B5797A6F342F4', 'paugilrez13', '2025-04-11 22:14:01', '1978-08-20', 'Bolivia', 1),
('elena.álvarez.fernández214@icloud.com', 'AA8411BF8A4DFD9273EB3AE866B344373824C8BFA8BE34B7CB48954821FC87C8', 'eleálvdez14', '2025-01-28 22:14:01', '2010-01-25', 'Argentina', 1),
('carmen.alonso.navarro215@protonmail.com', '5B32038EBB8C9A19A87FA344FDD3E83844620198F6DC71D8A58C4E01A5BDF8DA', 'caralorro15', '2025-08-22 22:14:01', '1989-09-24', 'Venezuela', 1),
('adrián.gómez.vázquez216@msn.com', 'B09BB9366C4F49B612C352155BB4D4BCBA29A13B58CEE8BFD34D4C4211B908EE', 'adrgómuez16', '2025-01-12 22:14:01', '1972-12-12', 'Venezuela', 1),
('beatriz.martínez.sanz217@live.com', '261642C68C005B396685414A4C7F1E63EE7BA3CA9AF165D9002B4EF72AA477E9', 'beamaranz17', '2025-04-05 22:14:01', '1987-02-10', 'Perú', 1),
('carmen.garcía.domínguez218@hotmail.com', 'BF3E89AB05AC7C58AF49E7983CEA2952AEAA3280F838C28F49ACF069098ECC42', 'cargaruez18', '2024-07-27 22:14:01', '1998-07-22', 'Bolivia', 1),
('andrés.marín.jiménez219@yahoo.com', 'E3B0E3FDC57F351FAA1ED4075F82DCA1C2EE0C8EC82E6613EB1FDE558746AA30', 'andmarnez19', '2024-10-03 22:14:01', '1979-02-25', 'España', 1),
('irene.navarro.iglesias220@icloud.com', 'E45C761D948E0F467C6DB14621D8CA6CB8775C8E2CEC7DFCF3C55B3A46675981', 'irenavias20', '2024-10-27 22:14:01', '2003-09-03', 'República Dominicana', 1),
('víctor.ortega.gonzález221@protonmail.com', '9D43ACD67273CAB40FF3382783C7BEF40D48F9F923F5FBA376E137526C1CA1A2', 'vícortlez21', '2024-08-09 22:14:01', '1979-12-14', 'Ecuador', 0),
('paula.iglesias.vázquez222@yahoo.com', 'FDBB2452EB32651AA4025D0BE07323C16468DAE657452E0806A38CDB29D4DA39', 'pauigluez22', '2025-07-22 22:14:01', '1992-09-30', 'Uruguay', 1),
('eva.morales.domínguez223@icloud.com', '973D68BC196E3C93DD51566BC8A183105692A97818A1BCE7095B72303AF667FC', 'evamoruez23', '2025-09-14 22:14:01', '1956-10-15', 'Perú', 1),
('jorge.blanco.díaz224@live.com', 'D8A3F5DD3C46F112D1AC309823E0EEB16C26442D3B5F76DADE86135FB75E078A', 'jorblaíaz24', '2024-11-11 22:14:01', '2012-08-17', 'Chile', 1),
('hugo.sanz.serrano225@outlook.com', '2C4ABCBA4FA87FAB5ABA246CA9B22EF9A562F63D9B42F1D3305DC006D6FB5B13', 'hugsanano25', '2025-12-07 22:14:01', '2011-05-30', 'Colombia', 1),
('paula.medina.ortiz226@msn.com', '63D123551954A5CE427C6D0F6E65A26926992D5072CBB841C4F1644E16961D63', 'paumedtiz26', '2025-10-09 22:14:01', '2008-03-13', 'Perú', 1),
('carmen.serrano.ramos227@outlook.com', '2BE87BDEEEE94229BDC07C8AC30EBEA043E09F0836F931E4373DAE7F179BB30A', 'carsermos27', '2025-07-06 22:14:01', '2008-09-03', 'Estados Unidos', 1),
('yolanda.romero.molina228@protonmail.com', '6C6BF17B81603DB51FA6EB8EAEDFBF3FD0987C1B61BCB41BCA7E88591AEABC2C', 'yolromina28', '2024-09-29 22:14:01', '1976-08-21', 'República Dominicana', 1),
('luis.medina.medina229@msn.com', 'D1D7A067F448960CC956F60CB1D4B40B6D5566E526F4B425AE9CFBA1B79873A7', 'luimedina29', '2026-02-08 22:14:01', '1957-04-28', 'Bolivia', 1),
('fernando.alonso.navarro230@protonmail.com', 'CA3EEF7896B0BDBDEE5D7D251224AAF3882815E7B35BDE0DF62F32E74BCEA00E', 'feralorro30', '2025-04-19 22:14:01', '1998-04-08', 'República Dominicana', 1),
('sofía.sanz.medina231@protonmail.com', '5C9EF64B3C5B95270574BFEC3ADA1219F8C5EF005B607950B431ADD9C07E7B46', 'sofsanina31', '2025-04-14 22:14:01', '1997-10-29', 'Bolivia', 1),
('álvaro.torres.pérez232@protonmail.com', 'B42D0ACE7BAC646EA6F06786B239E7379EEB15991E8E0934585C7CBA72BC7D51', 'álvtorrez32', '2024-09-29 22:14:01', '1978-08-20', 'Paraguay', 1),
('óscar.gonzález.morales233@gmail.com', '1BBF9B1F5E4C3E8A63358C7F7F4FC93B5547A429DA7FFEB9BF575E96F6337EA7', 'óscgonles33', '2025-12-02 22:14:01', '1995-06-14', 'Costa Rica', 1),
('josé.ortega.serrano234@protonmail.com', '098DB1F070E31262FB7D8869EAA95614D96DD55A6B237F6F9C533D7FB8CEF67C', 'josortano34', '2024-10-26 22:14:01', '1970-07-24', 'Perú', 1),
('álvaro.díaz.marín235@icloud.com', 'AF6E39AA074C849BDD55039ECB16BF9C820C5C706E62FD63F20B0FB2B9012700', 'álvdíarín35', '2025-08-04 22:14:01', '2010-04-18', 'Uruguay', 1),
('andrés.serrano.gil236@yahoo.com', '538EBE51844AA79B919F7BB81F46D60563333EB73347BBA0E87E071BCD0C734C', 'andsergil36', '2025-11-15 22:14:01', '2009-07-15', 'México', 1),
('teresa.hernández.navarro237@icloud.com', '7AEFE7F23C0B10105978FBFECEDFB5C581A93AE9C24F4A44C2C8274C92FD6C62', 'terherrro37', '2024-09-13 22:14:01', '1986-09-08', 'Costa Rica', 1),
('silvia.martín.castro238@msn.com', '47B1A7C62B4D0B1CE6A034A51DBC0A9663E81A252E19E8A418D623CBDB57610F', 'silmartro38', '2024-03-15 22:14:01', '2008-07-24', 'República Dominicana', 1),
('sofía.rodríguez.sanz239@yahoo.com', 'B0BAFD6C5534BAD618D46145DDBE4C7548929CFEE5820993440130B493A75213', 'sofrodanz39', '2026-02-26 22:14:01', '1979-05-18', 'Bolivia', 1),
('teresa.blanco.marín240@protonmail.com', '95340B31B845B063DD9E80D1A10DABD32C5F7DDAFA3BF3262E17E5AA3ABD9D2B', 'terblarín40', '2025-05-30 22:14:01', '1983-01-31', 'Chile', 1),
('jesús.jiménez.sánchez241@hotmail.com', '25ED410A1A1C1EF2ACE7203B7CCDC7E13310BC1524EF05A27B8A6A7051597236', 'jesjimhez41', '2025-07-26 22:14:01', '1979-12-06', 'Perú', 1),
('ricardo.ortega.torres242@outlook.com', 'CDF8A092D9E8918E815A153CC79E74337ACB1F025E784A4668FC6A59D2800F0D', 'ricortres42', '2025-03-25 22:14:01', '1960-10-03', 'Estados Unidos', 1),
('carlos.serrano.moreno243@icloud.com', '01AF3C750FADAA3263AA6841DDFEC8BD08CE7A35DBB0925AE6AA3BD499A5A41F', 'carsereno43', '2025-04-30 22:14:01', '1963-10-15', 'Ecuador', 1),
('rocío.ramírez.ruiz244@gmail.com', 'B7B5175D5692EED90F3FED43FAA19FC26B02CFD7F539D5C4C5427C05962B33FA', 'rocramuiz44', '2024-06-28 22:14:01', '1997-03-12', 'Bolivia', 1),
('pilar.romero.fernández245@gmail.com', '6AEDF5CDF9904A4C627FF5A98136EF74804463DC6C88B81CBAFCED47A2138C28', 'pilromdez45', '2025-02-11 22:14:01', '1971-12-13', 'Guatemala', 1),
('carmen.gonzález.ortiz246@outlook.com', '7D206805A37B53EF9C571814F49B122F8A63092E977A8118C58E849DFCFAFD29', 'cargontiz46', '2025-08-08 22:14:01', '1991-06-13', 'Paraguay', 1),
('óscar.alonso.fernández247@hotmail.com', '6A6DED9038C5D02576530A03719C190224E55B500C6A1C95D3A495DCEFD59F9E', 'óscalodez47', '2024-09-16 22:14:01', '1973-02-03', 'Colombia', 1),
('patricia.álvarez.garcía248@msn.com', '8AD686F1E0C9771F9593D75BE01CDED6306E18DF61226930EC7A498883B4A744', 'patálvcía48', '2025-07-05 22:14:01', '2012-05-24', 'México', 1),
('eva.gonzález.rodríguez249@hotmail.com', 'E8DDAE36E613FA05B7A9AC68C0190FB0FA6E111C39F2D0025AA9B4BABE81D47E', 'evagonuez49', '2026-01-17 22:14:01', '1997-06-23', 'España', 1),
('rubén.navarro.ortega250@hotmail.com', 'FC12A10ACD813D755AE058CDAAD2ABB542475B91098FD6FBB84EBC5493FEC46F', 'rubnavega50', '2024-04-25 22:14:01', '1956-01-22', 'República Dominicana', 1),
('fernando.sanz.marín251@outlook.com', '466DCA6FF8ECD592461024854FB2B6DFE7985BA9D6118E86CBCFCE1DC29E3564', 'fersanrín51', '2026-01-26 22:14:01', '1961-09-18', 'Paraguay', 1),
('javier.garcía.martín252@hotmail.com', 'D64AF40AE7A700B3DC9B39B2D5D8DF002B16E8CECE18C426DC8752876CF556D7', 'javgartín52', '2025-08-16 22:14:01', '1973-05-30', 'Chile', 1),
('diego.torres.gómez253@live.com', '2C5046EA7057F75F8EF7243607B2FB28D17437AE523C3994923749816E1ACB07', 'dietormez53', '2024-08-20 22:14:01', '1969-11-11', 'Paraguay', 1),
('natalia.fernández.martín254@live.com', '2043F225234A09A0A8CE06A40E09AD41CBC5F917091E04793ACF56465413F152', 'natfertín54', '2024-11-06 22:14:01', '1961-08-23', 'Venezuela', 1),
('marta.martínez.domínguez255@outlook.com', 'D2DB73CA01B59CA241F6343E55056464542DE8534790284EA4A9DE7DC6D41E32', 'marmaruez55', '2024-11-01 22:14:01', '1967-01-09', 'Costa Rica', 1),
('eva.torres.jiménez256@outlook.com', 'A2825F7CA0D79DFA8F05B8D3522FDD52240F83A74EF45E2AFD8AAB976471FBCE', 'evatornez56', '2025-12-14 22:14:01', '1980-05-11', 'Venezuela', 1),
('daniel.ruiz.sánchez257@yahoo.com', '0836AB2F98607083E47D5C313D29CD08174B3D858D8BA3A175C13264229C9DAA', 'danruihez57', '2024-11-30 22:14:01', '1990-04-17', 'Paraguay', 1),
('fernando.gutiérrez.ramos258@hotmail.com', 'C813BF07401C9ED06EDF3ACE6746BC52AE8068C823E3958EC68AAD7F972373AC', 'fergutmos58', '2025-12-26 22:14:01', '1969-08-10', 'Estados Unidos', 1),
('juan.martín.suárez259@hotmail.com', 'A46384AF377AAACF63877DFCCAE33129B5238BEBD29651D9503AF135918BC4D8', 'juamarrez59', '2025-06-12 22:14:01', '1962-12-30', 'Argentina', 1),
('óscar.castro.suárez260@icloud.com', '051584F1E69026113BA34D73D18B5D16E18B9B6256EBF57E8588B9E294769807', 'ósccasrez60', '2024-09-21 22:14:01', '1995-04-24', 'México', 1);

PRINT ' 260 usuarios reales insertados correctamente';
GO


-- ==========================================
-- 2. CREADORES (30 registros - 26 normales + 4 polémicos)
-- ==========================================
PRINT 'Insertando 30 creadores reales...';

INSERT INTO Creador (idUsuario, biografia, banco_nombre, banco_cuenta, es_nsfw, idCategoria) VALUES 
-- Creadores originales (1-26)
(1, 'Gamer profesional. Gameplays y streams diarios.', 'BBVA', '147646000097964', 0, 2),
(2, 'Entrenador personal. Rutinas de ejercicio y nutrición.', 'Banco de Chile', '1720510000091962', 0, 3),
(3, 'Tech reviewer. Análisis de gadgets y tecnología.', 'Bancolombia', '116367000005374', 0, 4),
(4, 'Artista digital. Ilustraciones y comisiones.', 'Banco Santander', '143115000003362', 0, 5),
(5, 'Músico. Covers y lecciones de guitarra.', 'BBVA', '123953000004327', 0, 6),
(6, 'Chef. Recetas fáciles y rápidas.', 'Banco de Chile', '104978000001426', 0, 7),
(7, 'Viajero. Guías y tips de viajes.', 'Bancolombia', '116899000008110', 0, 8),
(8, 'Profesor. Clases de matemáticas y física.', 'Banco Santander', '149644000003302', 0, 9),
(9, 'Comediante. Sketches y stand-up.', 'BBVA', '116049000004256', 0, 10),
(10, 'Creador de contenido versátil.', 'Banco de Chile', '151537000009526', 0, 1),
(11, 'Gamer profesional. Gameplays y streams diarios.', 'Bancolombia', '122697000009485', 0, 2),
(12, 'Entrenador personal. Rutinas de ejercicio y nutrición.', 'Banco Santander', '144560000005374', 0, 3),
(13, 'Tech reviewer. Análisis de gadgets y tecnología.', 'BBVA', '166673000001172', 1, 4),
(14, 'Artista digital. Ilustraciones y comisiones.', 'Banco de Chile', '128198000004226', 0, 5),
(15, 'Músico. Covers y lecciones de guitarra.', 'Bancolombia', '109438000009334', 0, 6),
(16, 'Chef. Recetas fáciles y rápidas.', 'Banco Santander', '112939000008925', 0, 7),
(17, 'Viajero. Guías y tips de viajes.', 'BBVA', '130172000002122', 0, 8),
(18, 'Profesor. Clases de matemáticas y física.', 'Banco de Chile', '127388000007021', 0, 9),
(19, 'Comediante. Sketches y stand-up.', 'Bancolombia', '110033000004063', 0, 10),
(20, 'Creador de contenido versátil.', 'Banco Santander', '117865000008808', 0, 1),
(21, 'Gamer profesional. Gameplays y streams diarios.', 'BBVA', '173822000009978', 0, 2),
(22, 'Entrenador personal. Rutinas de ejercicio y nutrición.', 'Banco de Chile', '113212000005355', 0, 3),
(23, 'Tech reviewer. Análisis de gadgets y tecnología.', 'Bancolombia', '117127000007153', 0, 4),
(24, 'Artista digital. Ilustraciones y comisiones.', 'Banco Santander', '171601000004310', 0, 5),
(25, 'Músico. Covers y lecciones de guitarra.', 'BBVA', '118285000009473', 0, 6),
(26, 'Chef. Recetas fáciles y rápidas.', 'Banco de Chile', '119240000007717', 1, 7),
(27, 'Crítico controversial. Opiniones que nadie quiere escuchar.', 'Banco Santander', '271234000056789', 0, 10), -- Comedia
(28, 'Debatidor profesional. Temas que generan discusión.', 'BBVA', '281234000067890', 0, 18), -- Política y Noticias
(29, 'Opinólogo extremo. Siempre tengo una opinión diferente.', 'Banco de Chile', '291234000078901', 0, 9), -- ASMR (irónico)
(30, 'El que siempre lleva la contraria. Debate todo.', 'Bancolombia', '301234000089012', 0, 10); -- Comedia

PRINT ' 30 creadores insertados correctamente (26 normales + 4 polémicos)';
GO

-- ==========================================
-- 3. NIVELES DE SUSCRIPCIÓN (57 registros reales)
-- ==========================================
PRINT 'Insertando niveles de suscripción...';

INSERT INTO NivelSuscripcion (idCreador, nombre, descripcion, precio_actual, esta_activo, orden) VALUES 
(1, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(2, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(2, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(3, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(3, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(3, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(4, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(4, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(4, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(5, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(6, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(6, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(7, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(7, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(7, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(8, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(9, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(9, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(9, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(10, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(11, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(11, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(11, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(12, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(12, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(12, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(13, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 14.99, 1, 1),
(13, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 37.48, 1, 2),
(13, 'VIP', 'Acceso completo + contenido personalizado mensual.', 74.95, 1, 3),
(14, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(15, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(15, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(15, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(16, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(16, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(17, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(17, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(17, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(18, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(18, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(19, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(19, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(19, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(20, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(20, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(20, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(21, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(21, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(22, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(22, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(23, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(23, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(24, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(24, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(25, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 7.99, 1, 1),
(25, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 19.98, 1, 2),
(25, 'VIP', 'Acceso completo + contenido personalizado mensual.', 39.95, 1, 3),
(26, 'Básico', 'Acceso a contenido general y publicaciones públicas.', 14.99, 1, 1),
(26, 'Premium', 'Acceso a contenido exclusivo y descuentos.', 37.48, 1, 2);

PRINT ' 57 niveles de suscripción insertados';
GO

-- ==========================================
-- 4. PUBLICACIONES (850 registros)
-- ==========================================
PRINT 'Insertando 850 publicaciones...';

INSERT INTO Publicacion (idCreador, titulo, fecha_publicacion, es_publica, tipo_contenido) VALUES 
(23, 'Publicación 1 - VIDEO', '2025-12-05 22:42:44', 0, 'VIDEO'),
(22, 'Publicación 2 - TEXTO', '2025-09-15 22:42:44', 1, 'TEXTO'),
(2, 'Publicación 3 - IMAGEN', '2025-09-09 22:42:44', 1, 'IMAGEN'),
(18, 'Publicación 4 - VIDEO', '2025-10-05 22:42:44', 1, 'VIDEO'),
(23, 'Publicación 5 - TEXTO', '2025-09-19 22:42:44', 0, 'TEXTO'),
(2, 'Publicación 6 - IMAGEN', '2025-10-19 22:42:44', 0, 'IMAGEN'),
(26, 'Publicación 7 - VIDEO', '2025-11-05 22:42:44', 1, 'VIDEO'),
(8, 'Publicación 8 - TEXTO', '2026-01-19 22:42:44', 1, 'TEXTO'),
(8, 'Publicación 9 - IMAGEN', '2025-12-28 22:42:44', 1, 'IMAGEN'),
(8, 'Publicación 10 - VIDEO', '2025-11-27 22:42:44', 1, 'VIDEO'),
(18, 'Publicación 11 - TEXTO', '2026-01-12 22:42:44', 1, 'TEXTO'),
(1, 'Publicación 12 - IMAGEN', '2025-09-25 22:42:44', 0, 'IMAGEN'),
(10, 'Publicación 13 - VIDEO', '2025-09-06 22:42:44', 1, 'VIDEO'),
(16, 'Publicación 14 - TEXTO', '2025-11-17 22:42:44', 1, 'TEXTO'),
(23, 'Publicación 15 - IMAGEN', '2025-10-30 22:42:44', 0, 'IMAGEN'),
(25, 'Publicación 16 - VIDEO', '2026-01-30 22:42:44', 1, 'VIDEO'),
(22, 'Publicación 17 - TEXTO', '2025-11-29 22:42:44', 1, 'TEXTO'),
(25, 'Publicación 18 - IMAGEN', '2025-11-07 22:42:44', 0, 'IMAGEN'),
(6, 'Publicación 19 - VIDEO', '2025-12-06 22:42:44', 1, 'VIDEO'),
(14, 'Publicación 20 - TEXTO', '2026-02-22 22:42:44', 1, 'TEXTO'),
(13, 'Publicación 21 - IMAGEN', '2026-01-18 22:42:44', 0, 'IMAGEN'),
(7, 'Publicación 22 - VIDEO', '2026-02-04 22:42:44', 1, 'VIDEO'),
(10, 'Publicación 23 - TEXTO', '2026-01-13 22:42:44', 1, 'TEXTO'),
(19, 'Publicación 24 - IMAGEN', '2025-11-12 22:42:44', 1, 'IMAGEN'),
(3, 'Publicación 25 - VIDEO', '2025-09-26 22:42:44', 1, 'VIDEO'),
(10, 'Publicación 26 - TEXTO', '2026-02-04 22:42:44', 1, 'TEXTO'),
(12, 'Publicación 27 - IMAGEN', '2025-12-24 22:42:44', 1, 'IMAGEN'),
(26, 'Publicación 28 - VIDEO', '2026-02-18 22:42:44', 0, 'VIDEO'),
(23, 'Publicación 29 - TEXTO', '2025-09-13 22:42:44', 1, 'TEXTO'),
(3, 'Publicación 30 - IMAGEN', '2025-10-25 22:42:44', 1, 'IMAGEN'),
(4, 'Publicación 31 - VIDEO', '2025-11-13 22:42:44', 0, 'VIDEO'),
(4, 'Publicación 32 - TEXTO', '2025-10-26 22:42:44', 1, 'TEXTO'),
(10, 'Publicación 33 - IMAGEN', '2025-09-20 22:42:44', 1, 'IMAGEN'),
(24, 'Publicación 34 - VIDEO', '2026-02-25 22:42:44', 0, 'VIDEO'),
(19, 'Publicación 35 - TEXTO', '2025-12-20 22:42:44', 1, 'TEXTO'),
(15, 'Publicación 36 - IMAGEN', '2026-02-08 22:42:44', 0, 'IMAGEN'),
(1, 'Publicación 37 - VIDEO', '2025-09-13 22:42:44', 1, 'VIDEO'),
(5, 'Publicación 38 - TEXTO', '2025-12-21 22:42:44', 1, 'TEXTO'),
(14, 'Publicación 39 - IMAGEN', '2025-10-24 22:42:44', 1, 'IMAGEN'),
(3, 'Publicación 40 - VIDEO', '2026-01-13 22:42:44', 1, 'VIDEO'),
(26, 'Publicación 41 - TEXTO', '2026-01-28 22:42:44', 1, 'TEXTO'),
(25, 'Publicación 42 - IMAGEN', '2025-09-10 22:42:44', 1, 'IMAGEN'),
(17, 'Publicación 43 - VIDEO', '2025-11-22 22:42:44', 1, 'VIDEO'),
(2, 'Publicación 44 - TEXTO', '2026-01-09 22:42:44', 0, 'TEXTO'),
(1, 'Publicación 45 - IMAGEN', '2025-11-16 22:42:44', 1, 'IMAGEN'),
(16, 'Publicación 46 - VIDEO', '2025-10-19 22:42:44', 1, 'VIDEO'),
(19, 'Publicación 47 - TEXTO', '2025-10-28 22:42:44', 1, 'TEXTO'),
(23, 'Publicación 48 - IMAGEN', '2026-01-14 22:42:44', 1, 'IMAGEN'),
(7, 'Publicación 49 - VIDEO', '2025-11-28 22:42:44', 0, 'VIDEO'),
(13, 'Publicación 50 - TEXTO', '2025-12-05 22:42:44', 1, 'TEXTO'),
(13, 'Publicación 51 - IMAGEN', '2025-12-10 22:42:44', 1, 'IMAGEN'),
(5, 'Publicación 52 - VIDEO', '2025-09-11 22:42:44', 0, 'VIDEO'),
(5, 'Publicación 53 - TEXTO', '2025-12-17 22:42:44', 1, 'TEXTO'),
(9, 'Publicación 54 - IMAGEN', '2026-02-15 22:42:44', 1, 'IMAGEN'),
(4, 'Publicación 55 - VIDEO', '2026-01-27 22:42:44', 0, 'VIDEO'),
(23, 'Publicación 56 - TEXTO', '2025-09-15 22:42:44', 0, 'TEXTO'),
(3, 'Publicación 57 - IMAGEN', '2025-12-22 22:42:44', 1, 'IMAGEN'),
(15, 'Publicación 58 - VIDEO', '2026-01-01 22:42:44', 0, 'VIDEO'),
(1, 'Publicación 59 - TEXTO', '2025-10-24 22:42:44', 1, 'TEXTO'),
(5, 'Publicación 60 - IMAGEN', '2026-01-30 22:42:44', 0, 'IMAGEN'),
(13, 'Publicación 61 - VIDEO', '2025-11-17 22:42:44', 1, 'VIDEO'),
(16, 'Publicación 62 - TEXTO', '2026-02-02 22:42:44', 1, 'TEXTO'),
(14, 'Publicación 63 - IMAGEN', '2025-12-06 22:42:44', 1, 'IMAGEN'),
(20, 'Publicación 64 - VIDEO', '2026-01-07 22:42:44', 1, 'VIDEO'),
(15, 'Publicación 65 - TEXTO', '2026-02-13 22:42:44', 1, 'TEXTO'),
(4, 'Publicación 66 - IMAGEN', '2025-09-02 22:42:44', 1, 'IMAGEN'),
(24, 'Publicación 67 - VIDEO', '2025-11-27 22:42:44', 0, 'VIDEO'),
(25, 'Publicación 68 - TEXTO', '2025-11-20 22:42:44', 1, 'TEXTO'),
(20, 'Publicación 69 - IMAGEN', '2026-02-02 22:42:44', 1, 'IMAGEN'),
(14, 'Publicación 70 - VIDEO', '2025-11-14 22:42:44', 1, 'VIDEO'),
(15, 'Publicación 71 - TEXTO', '2025-10-27 22:42:44', 0, 'TEXTO'),
(8, 'Publicación 72 - IMAGEN', '2025-11-24 22:42:44', 1, 'IMAGEN'),
(7, 'Publicación 73 - VIDEO', '2025-11-08 22:42:44', 1, 'VIDEO'),
(21, 'Publicación 74 - TEXTO', '2025-09-30 22:42:44', 0, 'TEXTO'),
(18, 'Publicación 75 - IMAGEN', '2026-01-27 22:42:44', 0, 'IMAGEN'),
(4, 'Publicación 76 - VIDEO', '2025-09-26 22:42:44', 1, 'VIDEO'),
(24, 'Publicación 77 - TEXTO', '2025-09-09 22:42:44', 0, 'TEXTO'),
(21, 'Publicación 78 - IMAGEN', '2025-11-15 22:42:44', 1, 'IMAGEN'),
(14, 'Publicación 79 - VIDEO', '2025-09-12 22:42:44', 1, 'VIDEO'),
(7, 'Publicación 80 - TEXTO', '2025-11-27 22:42:44', 0, 'TEXTO'),
(23, 'Publicación 81 - IMAGEN', '2025-12-15 22:42:44', 1, 'IMAGEN'),
(5, 'Publicación 82 - VIDEO', '2025-09-22 22:42:44', 1, 'VIDEO'),
(14, 'Publicación 83 - TEXTO', '2025-10-20 22:42:44', 0, 'TEXTO'),
(6, 'Publicación 84 - IMAGEN', '2025-11-09 22:42:44', 1, 'IMAGEN'),
(13, 'Publicación 85 - VIDEO', '2025-12-07 22:42:44', 1, 'VIDEO'),
(23, 'Publicación 86 - TEXTO', '2025-11-25 22:42:44', 1, 'TEXTO'),
(11, 'Publicación 87 - IMAGEN', '2025-11-08 22:42:44', 1, 'IMAGEN'),
(8, 'Publicación 88 - VIDEO', '2025-10-03 22:42:44', 1, 'VIDEO'),
(23, 'Publicación 89 - TEXTO', '2026-01-23 22:42:44', 0, 'TEXTO'),
(17, 'Publicación 90 - IMAGEN', '2026-01-09 22:42:44', 1, 'IMAGEN'),
(14, 'Publicación 91 - VIDEO', '2025-09-06 22:42:44', 1, 'VIDEO'),
(3, 'Publicación 92 - TEXTO', '2026-02-06 22:42:44', 0, 'TEXTO'),
(1, 'Publicación 93 - IMAGEN', '2025-11-07 22:42:44', 1, 'IMAGEN'),
(1, 'Publicación 94 - VIDEO', '2025-12-18 22:42:44', 0, 'VIDEO'),
(6, 'Publicación 95 - TEXTO', '2025-12-22 22:42:44', 1, 'TEXTO'),
(2, 'Publicación 96 - IMAGEN', '2026-02-20 22:42:44', 1, 'IMAGEN'),
(16, 'Publicación 97 - VIDEO', '2025-09-24 22:42:44', 0, 'VIDEO'),
(25, 'Publicación 98 - TEXTO', '2025-10-28 22:42:44', 0, 'TEXTO'),
(8, 'Publicación 99 - IMAGEN', '2026-01-12 22:42:44', 1, 'IMAGEN'),
(17, 'Publicación 100 - VIDEO', '2026-01-06 22:42:44', 1, 'VIDEO'),
(10, 'Publicación 101 - TEXTO', '2025-10-11 22:42:44', 1, 'TEXTO'),
(19, 'Publicación 102 - IMAGEN', '2026-02-15 22:42:44', 1, 'IMAGEN'),
(9, 'Publicación 103 - VIDEO', '2025-12-20 22:42:44', 0, 'VIDEO'),
(21, 'Publicación 104 - TEXTO', '2026-01-17 22:42:44', 1, 'TEXTO'),
(17, 'Publicación 105 - IMAGEN', '2025-10-16 22:42:44', 0, 'IMAGEN'),
(4, 'Publicación 106 - VIDEO', '2025-12-13 22:42:44', 1, 'VIDEO'),
(25, 'Publicación 107 - TEXTO', '2026-02-20 22:42:44', 1, 'TEXTO'),
(14, 'Publicación 108 - IMAGEN', '2025-09-18 22:42:44', 1, 'IMAGEN'),
(9, 'Publicación 109 - VIDEO', '2026-02-24 22:42:44', 1, 'VIDEO'),
(16, 'Publicación 110 - TEXTO', '2026-02-22 22:42:44', 0, 'TEXTO'),
(5, 'Publicación 111 - IMAGEN', '2026-02-27 22:42:44', 1, 'IMAGEN'),
(21, 'Publicación 112 - VIDEO', '2025-11-25 22:42:44', 0, 'VIDEO'),
(19, 'Publicación 113 - TEXTO', '2026-01-06 22:42:44', 1, 'TEXTO'),
(6, 'Publicación 114 - IMAGEN', '2026-02-13 22:42:44', 1, 'IMAGEN'),
(9, 'Publicación 115 - VIDEO', '2025-12-01 22:42:44', 1, 'VIDEO'),
(17, 'Publicación 116 - TEXTO', '2025-09-22 22:42:44', 1, 'TEXTO'),
(12, 'Publicación 117 - IMAGEN', '2026-02-15 22:42:44', 1, 'IMAGEN'),
(9, 'Publicación 118 - VIDEO', '2025-10-17 22:42:44', 1, 'VIDEO'),
(14, 'Publicación 119 - TEXTO', '2026-01-02 22:42:44', 1, 'TEXTO'),
(10, 'Publicación 120 - IMAGEN', '2026-02-13 22:42:44', 1, 'IMAGEN'),
(17, 'Publicación 121 - VIDEO', '2025-11-29 22:42:44', 1, 'VIDEO'),
(12, 'Publicación 122 - TEXTO', '2026-02-13 22:42:44', 1, 'TEXTO'),
(1, 'Publicación 123 - IMAGEN', '2026-02-21 22:42:44', 0, 'IMAGEN'),
(14, 'Publicación 124 - VIDEO', '2026-02-06 22:42:44', 1, 'VIDEO'),
(3, 'Publicación 125 - TEXTO', '2025-12-22 22:42:44', 1, 'TEXTO'),
(14, 'Publicación 126 - IMAGEN', '2026-02-03 22:42:44', 1, 'IMAGEN'),
(18, 'Publicación 127 - VIDEO', '2026-01-01 22:42:44', 0, 'VIDEO'),
(9, 'Publicación 128 - TEXTO', '2026-01-26 22:42:44', 1, 'TEXTO'),
(25, 'Publicación 129 - IMAGEN', '2025-09-25 22:42:44', 0, 'IMAGEN'),
(19, 'Publicación 130 - VIDEO', '2026-02-19 22:42:44', 1, 'VIDEO'),
(5, 'Publicación 131 - TEXTO', '2026-01-18 22:42:44', 1, 'TEXTO'),
(5, 'Publicación 132 - IMAGEN', '2025-12-01 22:42:44', 1, 'IMAGEN'),
(6, 'Publicación 133 - VIDEO', '2026-01-11 22:42:44', 1, 'VIDEO'),
(18, 'Publicación 134 - TEXTO', '2026-02-03 22:42:44', 0, 'TEXTO'),
(2, 'Publicación 135 - IMAGEN', '2026-01-31 22:42:44', 1, 'IMAGEN'),
(18, 'Publicación 136 - VIDEO', '2025-10-19 22:42:44', 1, 'VIDEO'),
(12, 'Publicación 137 - TEXTO', '2026-02-21 22:42:44', 0, 'TEXTO'),
(6, 'Publicación 138 - IMAGEN', '2025-09-16 22:42:44', 0, 'IMAGEN'),
(18, 'Publicación 139 - VIDEO', '2025-11-13 22:42:44', 1, 'VIDEO'),
(12, 'Publicación 140 - TEXTO', '2025-09-15 22:42:44', 0, 'TEXTO'),
(23, 'Publicación 141 - IMAGEN', '2026-01-05 22:42:44', 0, 'IMAGEN'),
(4, 'Publicación 142 - VIDEO', '2025-09-27 22:42:44', 1, 'VIDEO'),
(10, 'Publicación 143 - TEXTO', '2025-10-06 22:42:44', 0, 'TEXTO'),
(24, 'Publicación 144 - IMAGEN', '2025-09-07 22:42:44', 1, 'IMAGEN'),
(24, 'Publicación 145 - VIDEO', '2026-02-10 22:42:44', 1, 'VIDEO'),
(11, 'Publicación 146 - TEXTO', '2025-10-17 22:42:44', 1, 'TEXTO'),
(14, 'Publicación 147 - IMAGEN', '2025-10-04 22:42:44', 1, 'IMAGEN'),
(12, 'Publicación 148 - VIDEO', '2025-11-24 22:42:44', 1, 'VIDEO'),
(11, 'Publicación 149 - TEXTO', '2025-12-15 22:42:44', 1, 'TEXTO'),
(8, 'Publicación 150 - IMAGEN', '2025-09-25 22:42:44', 1, 'IMAGEN'),
(4, 'Publicación 151 - VIDEO', '2025-11-07 22:42:44', 1, 'VIDEO'),
(4, 'Publicación 152 - TEXTO', '2025-10-26 22:42:44', 1, 'TEXTO'),
(17, 'Publicación 153 - IMAGEN', '2026-01-15 22:42:44', 0, 'IMAGEN'),
(13, 'Publicación 154 - VIDEO', '2026-02-13 22:42:44', 1, 'VIDEO'),
(9, 'Publicación 155 - TEXTO', '2025-12-29 22:42:44', 0, 'TEXTO'),
(14, 'Publicación 156 - IMAGEN', '2025-11-25 22:42:44', 0, 'IMAGEN'),
(16, 'Publicación 157 - VIDEO', '2026-01-16 22:42:44', 1, 'VIDEO'),
(8, 'Publicación 158 - TEXTO', '2025-09-01 22:42:44', 1, 'TEXTO'),
(10, 'Publicación 159 - IMAGEN', '2025-12-16 22:42:44', 1, 'IMAGEN'),
(13, 'Publicación 160 - VIDEO', '2025-12-05 22:42:44', 0, 'VIDEO'),
(19, 'Publicación 161 - TEXTO', '2025-09-13 22:42:44', 1, 'TEXTO'),
(21, 'Publicación 162 - IMAGEN', '2026-01-24 22:42:44', 1, 'IMAGEN'),
(25, 'Publicación 163 - VIDEO', '2025-11-28 22:42:44', 1, 'VIDEO'),
(8, 'Publicación 164 - TEXTO', '2026-01-16 22:42:44', 0, 'TEXTO'),
(5, 'Publicación 165 - IMAGEN', '2026-01-09 22:42:44', 1, 'IMAGEN'),
(22, 'Publicación 166 - VIDEO', '2025-09-11 22:42:44', 1, 'VIDEO'),
(5, 'Publicación 167 - TEXTO', '2026-01-20 22:42:44', 0, 'TEXTO'),
(5, 'Publicación 168 - IMAGEN', '2025-09-08 22:42:44', 0, 'IMAGEN'),
(20, 'Publicación 169 - VIDEO', '2025-10-23 22:42:44', 0, 'VIDEO'),
(9, 'Publicación 170 - TEXTO', '2025-12-08 22:42:44', 0, 'TEXTO'),
(3, 'Publicación 171 - IMAGEN', '2025-12-21 22:42:44', 1, 'IMAGEN'),
(3, 'Publicación 172 - VIDEO', '2025-09-01 22:42:44', 1, 'VIDEO'),
(7, 'Publicación 173 - TEXTO', '2026-02-04 22:42:44', 1, 'TEXTO'),
(16, 'Publicación 174 - IMAGEN', '2025-11-17 22:42:44', 1, 'IMAGEN'),
(16, 'Publicación 175 - VIDEO', '2025-11-04 22:42:44', 0, 'VIDEO'),
(4, 'Publicación 176 - TEXTO', '2026-02-07 22:42:44', 1, 'TEXTO'),
(1, 'Publicación 177 - IMAGEN', '2025-10-24 22:42:44', 1, 'IMAGEN'),
(7, 'Publicación 178 - VIDEO', '2025-12-01 22:42:44', 0, 'VIDEO'),
(13, 'Publicación 179 - TEXTO', '2025-11-11 22:42:44', 1, 'TEXTO'),
(2, 'Publicación 180 - IMAGEN', '2025-10-04 22:42:44', 1, 'IMAGEN'),
(17, 'Publicación 181 - VIDEO', '2025-12-08 22:42:44', 1, 'VIDEO'),
(6, 'Publicación 182 - TEXTO', '2025-10-23 22:42:44', 1, 'TEXTO'),
(11, 'Publicación 183 - IMAGEN', '2026-02-13 22:42:44', 1, 'IMAGEN'),
(3, 'Publicación 184 - VIDEO', '2025-11-25 22:42:44', 0, 'VIDEO'),
(15, 'Publicación 185 - TEXTO', '2026-02-06 22:42:44', 1, 'TEXTO'),
(23, 'Publicación 186 - IMAGEN', '2026-02-13 22:42:44', 1, 'IMAGEN'),
(1, 'Publicación 187 - VIDEO', '2025-10-13 22:42:44', 1, 'VIDEO'),
(20, 'Publicación 188 - TEXTO', '2025-12-07 22:42:44', 0, 'TEXTO'),
(6, 'Publicación 189 - IMAGEN', '2026-01-11 22:42:44', 1, 'IMAGEN'),
(17, 'Publicación 190 - VIDEO', '2025-12-08 22:42:44', 1, 'VIDEO'),
(2, 'Publicación 191 - TEXTO', '2025-10-11 22:42:44', 1, 'TEXTO'),
(7, 'Publicación 192 - IMAGEN', '2025-11-08 22:42:44', 0, 'IMAGEN'),
(21, 'Publicación 193 - VIDEO', '2026-02-09 22:42:44', 1, 'VIDEO'),
(18, 'Publicación 194 - TEXTO', '2025-10-24 22:42:44', 1, 'TEXTO'),
(15, 'Publicación 195 - IMAGEN', '2025-10-10 22:42:44', 0, 'IMAGEN'),
(6, 'Publicación 196 - VIDEO', '2026-01-17 22:42:44', 1, 'VIDEO'),
(12, 'Publicación 197 - TEXTO', '2026-01-04 22:42:44', 1, 'TEXTO'),
(11, 'Publicación 198 - IMAGEN', '2025-09-07 22:42:44', 0, 'IMAGEN'),
(21, 'Publicación 199 - VIDEO', '2025-12-24 22:42:44', 1, 'VIDEO'),
(14, 'Publicación 200 - TEXTO', '2026-02-19 22:42:44', 1, 'TEXTO'),
(10, 'Publicación 201 - IMAGEN', '2025-11-17 22:42:44', 0, 'IMAGEN'),
(21, 'Publicación 202 - VIDEO', '2025-11-10 22:42:44', 1, 'VIDEO'),
(19, 'Publicación 203 - TEXTO', '2026-02-20 22:42:44', 0, 'TEXTO'),
(4, 'Publicación 204 - IMAGEN', '2025-11-02 22:42:44', 1, 'IMAGEN'),
(6, 'Publicación 205 - VIDEO', '2025-09-09 22:42:44', 1, 'VIDEO'),
(17, 'Publicación 206 - TEXTO', '2025-11-22 22:42:44', 1, 'TEXTO'),
(18, 'Publicación 207 - IMAGEN', '2026-01-21 22:42:44', 1, 'IMAGEN'),
(9, 'Publicación 208 - VIDEO', '2025-11-06 22:42:44', 1, 'VIDEO'),
(19, 'Publicación 209 - TEXTO', '2025-09-24 22:42:44', 1, 'TEXTO'),
(9, 'Publicación 210 - IMAGEN', '2025-12-01 22:42:44', 1, 'IMAGEN'),
(8, 'Publicación 211 - VIDEO', '2025-09-29 22:42:44', 1, 'VIDEO'),
(17, 'Publicación 212 - TEXTO', '2025-12-14 22:42:44', 1, 'TEXTO'),
(22, 'Publicación 213 - IMAGEN', '2025-11-04 22:42:44', 0, 'IMAGEN'),
(22, 'Publicación 214 - VIDEO', '2026-01-13 22:42:44', 1, 'VIDEO'),
(12, 'Publicación 215 - TEXTO', '2026-01-01 22:42:44', 1, 'TEXTO'),
(17, 'Publicación 216 - IMAGEN', '2026-02-08 22:42:44', 1, 'IMAGEN'),
(24, 'Publicación 217 - VIDEO', '2025-09-06 22:42:44', 1, 'VIDEO'),
(5, 'Publicación 218 - TEXTO', '2025-09-26 22:42:44', 0, 'TEXTO'),
(13, 'Publicación 219 - IMAGEN', '2026-01-25 22:42:44', 1, 'IMAGEN'),
(14, 'Publicación 220 - VIDEO', '2026-02-01 22:42:44', 0, 'VIDEO'),
(14, 'Publicación 221 - TEXTO', '2025-10-18 22:42:44', 0, 'TEXTO'),
(12, 'Publicación 222 - IMAGEN', '2025-11-22 22:42:44', 1, 'IMAGEN'),
(1, 'Publicación 223 - VIDEO', '2026-02-06 22:42:44', 0, 'VIDEO'),
(4, 'Publicación 224 - TEXTO', '2026-01-18 22:42:44', 1, 'TEXTO'),
(16, 'Publicación 225 - IMAGEN', '2025-09-05 22:42:44', 1, 'IMAGEN'),
(9, 'Publicación 226 - VIDEO', '2025-09-13 22:42:44', 1, 'VIDEO'),
(11, 'Publicación 227 - TEXTO', '2025-10-09 22:42:44', 0, 'TEXTO'),
(18, 'Publicación 228 - IMAGEN', '2025-11-19 22:42:44', 0, 'IMAGEN'),
(15, 'Publicación 229 - VIDEO', '2025-09-29 22:42:44', 1, 'VIDEO'),
(19, 'Publicación 230 - TEXTO', '2025-12-03 22:42:44', 1, 'TEXTO'),
(6, 'Publicación 231 - IMAGEN', '2025-12-13 22:42:44', 1, 'IMAGEN'),
(15, 'Publicación 232 - VIDEO', '2025-09-25 22:42:44', 0, 'VIDEO'),
(25, 'Publicación 233 - TEXTO', '2025-09-22 22:42:44', 1, 'TEXTO'),
(24, 'Publicación 234 - IMAGEN', '2025-10-23 22:42:44', 0, 'IMAGEN'),
(22, 'Publicación 235 - VIDEO', '2025-09-08 22:42:44', 1, 'VIDEO'),
(26, 'Publicación 236 - TEXTO', '2025-11-24 22:42:44', 1, 'TEXTO'),
(6, 'Publicación 237 - IMAGEN', '2025-11-19 22:42:44', 0, 'IMAGEN'),
(24, 'Publicación 238 - VIDEO', '2025-10-16 22:42:44', 1, 'VIDEO'),
(26, 'Publicación 239 - TEXTO', '2026-02-16 22:42:44', 1, 'TEXTO'),
(5, 'Publicación 240 - IMAGEN', '2026-02-25 22:42:44', 1, 'IMAGEN'),
(10, 'Publicación 241 - VIDEO', '2025-11-02 22:42:44', 0, 'VIDEO'),
(23, 'Publicación 242 - TEXTO', '2026-01-25 22:42:44', 1, 'TEXTO'),
(14, 'Publicación 243 - IMAGEN', '2026-02-19 22:42:44', 1, 'IMAGEN'),
(4, 'Publicación 244 - VIDEO', '2025-09-03 22:42:44', 0, 'VIDEO'),
(23, 'Publicación 245 - TEXTO', '2025-09-14 22:42:44', 1, 'TEXTO'),
(6, 'Publicación 246 - IMAGEN', '2026-02-08 22:42:44', 0, 'IMAGEN'),
(4, 'Publicación 247 - VIDEO', '2025-10-12 22:42:44', 1, 'VIDEO'),
(17, 'Publicación 248 - TEXTO', '2026-02-09 22:42:44', 1, 'TEXTO'),
(8, 'Publicación 249 - IMAGEN', '2025-12-13 22:42:44', 1, 'IMAGEN'),
(8, 'Publicación 250 - VIDEO', '2026-02-04 22:42:44', 0, 'VIDEO'),
(1, 'Publicación 251 - TEXTO', '2026-02-01 22:42:44', 1, 'TEXTO'),
(17, 'Publicación 252 - IMAGEN', '2025-09-23 22:42:44', 0, 'IMAGEN'),
(17, 'Publicación 253 - VIDEO', '2025-11-13 22:42:44', 1, 'VIDEO'),
(25, 'Publicación 254 - TEXTO', '2025-10-11 22:42:44', 1, 'TEXTO'),
(5, 'Publicación 255 - IMAGEN', '2025-10-04 22:42:44', 1, 'IMAGEN'),
(10, 'Publicación 256 - VIDEO', '2026-01-01 22:42:44', 1, 'VIDEO'),
(4, 'Publicación 257 - TEXTO', '2025-10-18 22:42:44', 0, 'TEXTO'),
(6, 'Publicación 258 - IMAGEN', '2025-09-21 22:42:44', 1, 'IMAGEN'),
(5, 'Publicación 259 - VIDEO', '2025-12-04 22:42:44', 0, 'VIDEO'),
(11, 'Publicación 260 - TEXTO', '2025-11-12 22:42:44', 1, 'TEXTO'),
(17, 'Publicación 261 - IMAGEN', '2026-02-06 22:42:44', 0, 'IMAGEN'),
(20, 'Publicación 262 - VIDEO', '2025-12-21 22:42:44', 1, 'VIDEO'),
(8, 'Publicación 263 - TEXTO', '2025-11-25 22:42:44', 1, 'TEXTO'),
(10, 'Publicación 264 - IMAGEN', '2025-09-11 22:42:44', 0, 'IMAGEN'),
(22, 'Publicación 265 - VIDEO', '2025-12-16 22:42:44', 0, 'VIDEO'),
(22, 'Publicación 266 - TEXTO', '2026-01-22 22:42:44', 1, 'TEXTO'),
(21, 'Publicación 267 - IMAGEN', '2025-11-25 22:42:44', 0, 'IMAGEN'),
(19, 'Publicación 268 - VIDEO', '2026-02-22 22:42:44', 1, 'VIDEO'),
(12, 'Publicación 269 - TEXTO', '2025-09-26 22:42:44', 1, 'TEXTO'),
(4, 'Publicación 270 - IMAGEN', '2026-02-23 22:42:44', 1, 'IMAGEN'),
(18, 'Publicación 271 - VIDEO', '2026-01-02 22:42:44', 1, 'VIDEO'),
(16, 'Publicación 272 - TEXTO', '2025-12-17 22:42:44', 1, 'TEXTO'),
(18, 'Publicación 273 - IMAGEN', '2025-12-09 22:42:44', 1, 'IMAGEN'),
(13, 'Publicación 274 - VIDEO', '2025-10-20 22:42:44', 1, 'VIDEO'),
(5, 'Publicación 275 - TEXTO', '2025-11-08 22:42:44', 1, 'TEXTO'),
(25, 'Publicación 276 - IMAGEN', '2025-10-20 22:42:44', 1, 'IMAGEN'),
(18, 'Publicación 277 - VIDEO', '2025-10-16 22:42:44', 1, 'VIDEO'),
(22, 'Publicación 278 - TEXTO', '2025-12-26 22:42:44', 1, 'TEXTO'),
(2, 'Publicación 279 - IMAGEN', '2026-01-22 22:42:44', 0, 'IMAGEN'),
(12, 'Publicación 280 - VIDEO', '2025-09-11 22:42:44', 1, 'VIDEO'),
(3, 'Publicación 281 - TEXTO', '2025-10-01 22:42:45', 1, 'TEXTO'),
(9, 'Publicación 282 - IMAGEN', '2025-09-25 22:42:45', 1, 'IMAGEN'),
(6, 'Publicación 283 - VIDEO', '2026-02-24 22:42:45', 1, 'VIDEO'),
(23, 'Publicación 284 - TEXTO', '2025-10-08 22:42:45', 1, 'TEXTO'),
(26, 'Publicación 285 - IMAGEN', '2025-09-07 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 286 - VIDEO', '2025-09-18 22:42:45', 1, 'VIDEO'),
(7, 'Publicación 287 - TEXTO', '2025-09-10 22:42:45', 0, 'TEXTO'),
(7, 'Publicación 288 - IMAGEN', '2026-01-23 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 289 - VIDEO', '2025-10-21 22:42:45', 1, 'VIDEO'),
(18, 'Publicación 290 - TEXTO', '2025-09-05 22:42:45', 1, 'TEXTO'),
(13, 'Publicación 291 - IMAGEN', '2025-10-11 22:42:45', 1, 'IMAGEN'),
(16, 'Publicación 292 - VIDEO', '2025-10-19 22:42:45', 0, 'VIDEO'),
(23, 'Publicación 293 - TEXTO', '2025-11-05 22:42:45', 0, 'TEXTO'),
(7, 'Publicación 294 - IMAGEN', '2026-01-08 22:42:45', 1, 'IMAGEN'),
(18, 'Publicación 295 - VIDEO', '2026-01-06 22:42:45', 1, 'VIDEO'),
(20, 'Publicación 296 - TEXTO', '2025-09-11 22:42:45', 0, 'TEXTO'),
(7, 'Publicación 297 - IMAGEN', '2025-12-13 22:42:45', 1, 'IMAGEN'),
(25, 'Publicación 298 - VIDEO', '2025-12-13 22:42:45', 1, 'VIDEO'),
(6, 'Publicación 299 - TEXTO', '2025-10-10 22:42:45', 0, 'TEXTO'),
(19, 'Publicación 300 - IMAGEN', '2025-11-17 22:42:45', 1, 'IMAGEN'),
(12, 'Publicación 301 - VIDEO', '2026-02-14 22:42:45', 1, 'VIDEO'),
(11, 'Publicación 302 - TEXTO', '2026-01-04 22:42:45', 0, 'TEXTO'),
(10, 'Publicación 303 - IMAGEN', '2026-01-17 22:42:45', 1, 'IMAGEN'),
(18, 'Publicación 304 - VIDEO', '2025-09-02 22:42:45', 1, 'VIDEO'),
(16, 'Publicación 305 - TEXTO', '2025-11-11 22:42:45', 1, 'TEXTO'),
(3, 'Publicación 306 - IMAGEN', '2026-01-07 22:42:45', 0, 'IMAGEN'),
(26, 'Publicación 307 - VIDEO', '2025-09-09 22:42:45', 1, 'VIDEO'),
(12, 'Publicación 308 - TEXTO', '2026-01-12 22:42:45', 0, 'TEXTO'),
(18, 'Publicación 309 - IMAGEN', '2025-12-30 22:42:45', 1, 'IMAGEN'),
(3, 'Publicación 310 - VIDEO', '2025-11-13 22:42:45', 1, 'VIDEO'),
(9, 'Publicación 311 - TEXTO', '2026-02-04 22:42:45', 1, 'TEXTO'),
(14, 'Publicación 312 - IMAGEN', '2025-09-10 22:42:45', 1, 'IMAGEN'),
(21, 'Publicación 313 - VIDEO', '2025-09-13 22:42:45', 1, 'VIDEO'),
(17, 'Publicación 314 - TEXTO', '2025-11-28 22:42:45', 0, 'TEXTO'),
(19, 'Publicación 315 - IMAGEN', '2025-09-20 22:42:45', 1, 'IMAGEN'),
(13, 'Publicación 316 - VIDEO', '2026-01-18 22:42:45', 1, 'VIDEO'),
(11, 'Publicación 317 - TEXTO', '2025-09-10 22:42:45', 1, 'TEXTO'),
(21, 'Publicación 318 - IMAGEN', '2025-09-28 22:42:45', 0, 'IMAGEN'),
(8, 'Publicación 319 - VIDEO', '2025-12-16 22:42:45', 1, 'VIDEO'),
(6, 'Publicación 320 - TEXTO', '2026-02-16 22:42:45', 1, 'TEXTO'),
(26, 'Publicación 321 - IMAGEN', '2026-02-12 22:42:45', 0, 'IMAGEN'),
(23, 'Publicación 322 - VIDEO', '2025-11-23 22:42:45', 1, 'VIDEO'),
(16, 'Publicación 323 - TEXTO', '2025-09-05 22:42:45', 0, 'TEXTO'),
(6, 'Publicación 324 - IMAGEN', '2026-01-12 22:42:45', 0, 'IMAGEN'),
(11, 'Publicación 325 - VIDEO', '2026-01-15 22:42:45', 1, 'VIDEO'),
(21, 'Publicación 326 - TEXTO', '2025-11-11 22:42:45', 1, 'TEXTO'),
(26, 'Publicación 327 - IMAGEN', '2025-09-21 22:42:45', 0, 'IMAGEN'),
(3, 'Publicación 328 - VIDEO', '2025-09-25 22:42:45', 1, 'VIDEO'),
(26, 'Publicación 329 - TEXTO', '2025-11-04 22:42:45', 1, 'TEXTO'),
(8, 'Publicación 330 - IMAGEN', '2026-01-09 22:42:45', 1, 'IMAGEN'),
(6, 'Publicación 331 - VIDEO', '2026-01-08 22:42:45', 1, 'VIDEO'),
(18, 'Publicación 332 - TEXTO', '2025-10-27 22:42:45', 1, 'TEXTO'),
(25, 'Publicación 333 - IMAGEN', '2025-11-03 22:42:45', 1, 'IMAGEN'),
(23, 'Publicación 334 - VIDEO', '2025-12-05 22:42:45', 1, 'VIDEO'),
(1, 'Publicación 335 - TEXTO', '2025-11-24 22:42:45', 1, 'TEXTO'),
(8, 'Publicación 336 - IMAGEN', '2026-02-18 22:42:45', 1, 'IMAGEN'),
(2, 'Publicación 337 - VIDEO', '2025-10-14 22:42:45', 1, 'VIDEO'),
(20, 'Publicación 338 - TEXTO', '2026-01-30 22:42:45', 1, 'TEXTO'),
(1, 'Publicación 339 - IMAGEN', '2025-10-16 22:42:45', 1, 'IMAGEN'),
(21, 'Publicación 340 - VIDEO', '2026-02-15 22:42:45', 0, 'VIDEO'),
(2, 'Publicación 341 - TEXTO', '2025-09-11 22:42:45', 1, 'TEXTO'),
(24, 'Publicación 342 - IMAGEN', '2025-09-21 22:42:45', 1, 'IMAGEN'),
(10, 'Publicación 343 - VIDEO', '2025-09-14 22:42:45', 0, 'VIDEO'),
(17, 'Publicación 344 - TEXTO', '2025-10-23 22:42:45', 1, 'TEXTO'),
(11, 'Publicación 345 - IMAGEN', '2025-11-03 22:42:45', 1, 'IMAGEN'),
(9, 'Publicación 346 - VIDEO', '2025-12-07 22:42:45', 1, 'VIDEO'),
(3, 'Publicación 347 - TEXTO', '2025-09-09 22:42:45', 1, 'TEXTO'),
(7, 'Publicación 348 - IMAGEN', '2026-01-14 22:42:45', 0, 'IMAGEN'),
(21, 'Publicación 349 - VIDEO', '2025-09-14 22:42:45', 0, 'VIDEO'),
(25, 'Publicación 350 - TEXTO', '2026-02-09 22:42:45', 1, 'TEXTO'),
(6, 'Publicación 351 - IMAGEN', '2026-01-09 22:42:45', 0, 'IMAGEN'),
(9, 'Publicación 352 - VIDEO', '2026-02-17 22:42:45', 0, 'VIDEO'),
(19, 'Publicación 353 - TEXTO', '2026-02-14 22:42:45', 0, 'TEXTO'),
(20, 'Publicación 354 - IMAGEN', '2025-12-06 22:42:45', 1, 'IMAGEN'),
(9, 'Publicación 355 - VIDEO', '2026-02-18 22:42:45', 0, 'VIDEO'),
(17, 'Publicación 356 - TEXTO', '2026-01-24 22:42:45', 1, 'TEXTO'),
(19, 'Publicación 357 - IMAGEN', '2026-02-13 22:42:45', 0, 'IMAGEN'),
(8, 'Publicación 358 - VIDEO', '2025-11-23 22:42:45', 1, 'VIDEO'),
(23, 'Publicación 359 - TEXTO', '2025-10-19 22:42:45', 0, 'TEXTO'),
(3, 'Publicación 360 - IMAGEN', '2025-11-04 22:42:45', 0, 'IMAGEN'),
(6, 'Publicación 361 - VIDEO', '2025-10-10 22:42:45', 1, 'VIDEO'),
(6, 'Publicación 362 - TEXTO', '2026-01-16 22:42:45', 1, 'TEXTO'),
(16, 'Publicación 363 - IMAGEN', '2025-11-16 22:42:45', 1, 'IMAGEN'),
(21, 'Publicación 364 - VIDEO', '2026-01-03 22:42:45', 0, 'VIDEO'),
(26, 'Publicación 365 - TEXTO', '2025-09-20 22:42:45', 1, 'TEXTO'),
(15, 'Publicación 366 - IMAGEN', '2026-01-05 22:42:45', 1, 'IMAGEN'),
(8, 'Publicación 367 - VIDEO', '2025-11-19 22:42:45', 1, 'VIDEO'),
(14, 'Publicación 368 - TEXTO', '2025-10-29 22:42:45', 1, 'TEXTO'),
(24, 'Publicación 369 - IMAGEN', '2025-10-11 22:42:45', 1, 'IMAGEN'),
(23, 'Publicación 370 - VIDEO', '2025-12-19 22:42:45', 0, 'VIDEO'),
(6, 'Publicación 371 - TEXTO', '2025-09-29 22:42:45', 1, 'TEXTO'),
(4, 'Publicación 372 - IMAGEN', '2026-02-15 22:42:45', 1, 'IMAGEN'),
(20, 'Publicación 373 - VIDEO', '2025-09-25 22:42:45', 1, 'VIDEO'),
(20, 'Publicación 374 - TEXTO', '2026-02-25 22:42:45', 1, 'TEXTO'),
(8, 'Publicación 375 - IMAGEN', '2025-11-28 22:42:45', 0, 'IMAGEN'),
(17, 'Publicación 376 - VIDEO', '2025-11-21 22:42:45', 0, 'VIDEO'),
(3, 'Publicación 377 - TEXTO', '2025-09-03 22:42:45', 1, 'TEXTO'),
(20, 'Publicación 378 - IMAGEN', '2025-11-22 22:42:45', 1, 'IMAGEN'),
(14, 'Publicación 379 - VIDEO', '2025-11-29 22:42:45', 1, 'VIDEO'),
(15, 'Publicación 380 - TEXTO', '2026-02-14 22:42:45', 1, 'TEXTO'),
(15, 'Publicación 381 - IMAGEN', '2025-12-30 22:42:45', 0, 'IMAGEN'),
(13, 'Publicación 382 - VIDEO', '2026-02-03 22:42:45', 0, 'VIDEO'),
(6, 'Publicación 383 - TEXTO', '2025-09-28 22:42:45', 1, 'TEXTO'),
(20, 'Publicación 384 - IMAGEN', '2025-11-22 22:42:45', 1, 'IMAGEN'),
(17, 'Publicación 385 - VIDEO', '2025-10-01 22:42:45', 1, 'VIDEO'),
(10, 'Publicación 386 - TEXTO', '2025-11-24 22:42:45', 0, 'TEXTO'),
(2, 'Publicación 387 - IMAGEN', '2025-11-03 22:42:45', 1, 'IMAGEN'),
(23, 'Publicación 388 - VIDEO', '2025-09-28 22:42:45', 0, 'VIDEO'),
(11, 'Publicación 389 - TEXTO', '2026-02-04 22:42:45', 1, 'TEXTO'),
(20, 'Publicación 390 - IMAGEN', '2025-09-09 22:42:45', 1, 'IMAGEN'),
(6, 'Publicación 391 - VIDEO', '2025-12-26 22:42:45', 1, 'VIDEO'),
(21, 'Publicación 392 - TEXTO', '2025-12-07 22:42:45', 1, 'TEXTO'),
(20, 'Publicación 393 - IMAGEN', '2025-12-04 22:42:45', 1, 'IMAGEN'),
(3, 'Publicación 394 - VIDEO', '2025-09-13 22:42:45', 1, 'VIDEO'),
(5, 'Publicación 395 - TEXTO', '2025-12-02 22:42:45', 1, 'TEXTO'),
(14, 'Publicación 396 - IMAGEN', '2025-09-04 22:42:45', 1, 'IMAGEN'),
(25, 'Publicación 397 - VIDEO', '2025-10-01 22:42:45', 0, 'VIDEO'),
(1, 'Publicación 398 - TEXTO', '2025-12-08 22:42:45', 1, 'TEXTO'),
(19, 'Publicación 399 - IMAGEN', '2025-11-08 22:42:45', 0, 'IMAGEN'),
(9, 'Publicación 400 - VIDEO', '2025-11-17 22:42:45', 1, 'VIDEO'),
(7, 'Publicación 401 - TEXTO', '2025-10-04 22:42:45', 0, 'TEXTO'),
(25, 'Publicación 402 - IMAGEN', '2025-11-09 22:42:45', 0, 'IMAGEN'),
(13, 'Publicación 403 - VIDEO', '2025-11-27 22:42:45', 1, 'VIDEO'),
(14, 'Publicación 404 - TEXTO', '2026-01-08 22:42:45', 1, 'TEXTO'),
(21, 'Publicación 405 - IMAGEN', '2025-10-12 22:42:45', 1, 'IMAGEN'),
(21, 'Publicación 406 - VIDEO', '2025-11-28 22:42:45', 0, 'VIDEO'),
(4, 'Publicación 407 - TEXTO', '2025-12-04 22:42:45', 0, 'TEXTO'),
(24, 'Publicación 408 - IMAGEN', '2025-11-03 22:42:45', 1, 'IMAGEN'),
(11, 'Publicación 409 - VIDEO', '2025-09-08 22:42:45', 1, 'VIDEO'),
(10, 'Publicación 410 - TEXTO', '2025-11-23 22:42:45', 0, 'TEXTO'),
(7, 'Publicación 411 - IMAGEN', '2025-10-25 22:42:45', 0, 'IMAGEN'),
(22, 'Publicación 412 - VIDEO', '2025-09-17 22:42:45', 1, 'VIDEO'),
(14, 'Publicación 413 - TEXTO', '2026-02-17 22:42:45', 1, 'TEXTO'),
(25, 'Publicación 414 - IMAGEN', '2025-09-16 22:42:45', 1, 'IMAGEN'),
(26, 'Publicación 415 - VIDEO', '2025-10-25 22:42:45', 1, 'VIDEO'),
(15, 'Publicación 416 - TEXTO', '2025-11-14 22:42:45', 1, 'TEXTO'),
(23, 'Publicación 417 - IMAGEN', '2025-12-18 22:42:45', 1, 'IMAGEN'),
(21, 'Publicación 418 - VIDEO', '2026-01-10 22:42:45', 1, 'VIDEO'),
(16, 'Publicación 419 - TEXTO', '2026-02-21 22:42:45', 1, 'TEXTO'),
(18, 'Publicación 420 - IMAGEN', '2026-01-18 22:42:45', 1, 'IMAGEN'),
(12, 'Publicación 421 - VIDEO', '2025-11-26 22:42:45', 1, 'VIDEO'),
(2, 'Publicación 422 - TEXTO', '2025-12-19 22:42:45', 1, 'TEXTO'),
(21, 'Publicación 423 - IMAGEN', '2025-12-16 22:42:45', 1, 'IMAGEN'),
(4, 'Publicación 424 - VIDEO', '2025-12-01 22:42:45', 1, 'VIDEO'),
(19, 'Publicación 425 - TEXTO', '2025-11-14 22:42:45', 0, 'TEXTO'),
(18, 'Publicación 426 - IMAGEN', '2026-02-18 22:42:45', 1, 'IMAGEN'),
(10, 'Publicación 427 - VIDEO', '2025-09-25 22:42:45', 0, 'VIDEO'),
(20, 'Publicación 428 - TEXTO', '2025-09-20 22:42:45', 1, 'TEXTO'),
(16, 'Publicación 429 - IMAGEN', '2026-01-17 22:42:45', 1, 'IMAGEN'),
(12, 'Publicación 430 - VIDEO', '2026-02-02 22:42:45', 1, 'VIDEO'),
(19, 'Publicación 431 - TEXTO', '2025-12-09 22:42:45', 0, 'TEXTO'),
(9, 'Publicación 432 - IMAGEN', '2025-12-14 22:42:45', 1, 'IMAGEN'),
(9, 'Publicación 433 - VIDEO', '2026-01-19 22:42:45', 1, 'VIDEO'),
(9, 'Publicación 434 - TEXTO', '2025-12-17 22:42:45', 1, 'TEXTO'),
(26, 'Publicación 435 - IMAGEN', '2025-09-12 22:42:45', 1, 'IMAGEN'),
(26, 'Publicación 436 - VIDEO', '2025-09-08 22:42:45', 0, 'VIDEO'),
(3, 'Publicación 437 - TEXTO', '2025-09-27 22:42:45', 0, 'TEXTO'),
(13, 'Publicación 438 - IMAGEN', '2026-01-03 22:42:45', 1, 'IMAGEN'),
(16, 'Publicación 439 - VIDEO', '2025-11-26 22:42:45', 1, 'VIDEO'),
(22, 'Publicación 440 - TEXTO', '2025-10-19 22:42:45', 1, 'TEXTO'),
(8, 'Publicación 441 - IMAGEN', '2026-01-12 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 442 - VIDEO', '2025-10-20 22:42:45', 1, 'VIDEO'),
(17, 'Publicación 443 - TEXTO', '2025-09-12 22:42:45', 1, 'TEXTO'),
(20, 'Publicación 444 - IMAGEN', '2025-09-17 22:42:45', 0, 'IMAGEN'),
(2, 'Publicación 445 - VIDEO', '2025-11-29 22:42:45', 1, 'VIDEO'),
(3, 'Publicación 446 - TEXTO', '2025-11-08 22:42:45', 1, 'TEXTO'),
(22, 'Publicación 447 - IMAGEN', '2025-10-22 22:42:45', 1, 'IMAGEN'),
(24, 'Publicación 448 - VIDEO', '2026-01-20 22:42:45', 1, 'VIDEO'),
(22, 'Publicación 449 - TEXTO', '2026-01-03 22:42:45', 1, 'TEXTO'),
(4, 'Publicación 450 - IMAGEN', '2025-12-17 22:42:45', 1, 'IMAGEN'),
(16, 'Publicación 451 - VIDEO', '2026-01-28 22:42:45', 1, 'VIDEO'),
(14, 'Publicación 452 - TEXTO', '2025-09-01 22:42:45', 0, 'TEXTO'),
(23, 'Publicación 453 - IMAGEN', '2025-11-09 22:42:45', 1, 'IMAGEN'),
(24, 'Publicación 454 - VIDEO', '2026-01-14 22:42:45', 1, 'VIDEO'),
(22, 'Publicación 455 - TEXTO', '2025-12-06 22:42:45', 1, 'TEXTO'),
(2, 'Publicación 456 - IMAGEN', '2025-12-04 22:42:45', 1, 'IMAGEN'),
(9, 'Publicación 457 - VIDEO', '2026-01-23 22:42:45', 0, 'VIDEO'),
(6, 'Publicación 458 - TEXTO', '2026-02-18 22:42:45', 1, 'TEXTO'),
(10, 'Publicación 459 - IMAGEN', '2026-02-17 22:42:45', 1, 'IMAGEN'),
(21, 'Publicación 460 - VIDEO', '2025-10-01 22:42:45', 1, 'VIDEO'),
(1, 'Publicación 461 - TEXTO', '2025-09-25 22:42:45', 1, 'TEXTO'),
(2, 'Publicación 462 - IMAGEN', '2026-01-27 22:42:45', 1, 'IMAGEN'),
(14, 'Publicación 463 - VIDEO', '2026-01-29 22:42:45', 1, 'VIDEO'),
(6, 'Publicación 464 - TEXTO', '2026-02-05 22:42:45', 1, 'TEXTO'),
(2, 'Publicación 465 - IMAGEN', '2025-12-15 22:42:45', 0, 'IMAGEN'),
(2, 'Publicación 466 - VIDEO', '2026-02-15 22:42:45', 1, 'VIDEO'),
(26, 'Publicación 467 - TEXTO', '2025-10-18 22:42:45', 1, 'TEXTO'),
(18, 'Publicación 468 - IMAGEN', '2026-02-12 22:42:45', 0, 'IMAGEN'),
(25, 'Publicación 469 - VIDEO', '2025-11-07 22:42:45', 1, 'VIDEO'),
(23, 'Publicación 470 - TEXTO', '2026-01-10 22:42:45', 1, 'TEXTO'),
(3, 'Publicación 471 - IMAGEN', '2025-10-19 22:42:45', 0, 'IMAGEN'),
(15, 'Publicación 472 - VIDEO', '2025-10-25 22:42:45', 1, 'VIDEO'),
(20, 'Publicación 473 - TEXTO', '2025-10-03 22:42:45', 1, 'TEXTO'),
(12, 'Publicación 474 - IMAGEN', '2025-10-20 22:42:45', 1, 'IMAGEN'),
(10, 'Publicación 475 - VIDEO', '2026-02-23 22:42:45', 1, 'VIDEO'),
(3, 'Publicación 476 - TEXTO', '2026-02-15 22:42:45', 0, 'TEXTO'),
(20, 'Publicación 477 - IMAGEN', '2025-12-10 22:42:45', 1, 'IMAGEN'),
(17, 'Publicación 478 - VIDEO', '2026-01-15 22:42:45', 1, 'VIDEO'),
(8, 'Publicación 479 - TEXTO', '2025-09-28 22:42:45', 1, 'TEXTO'),
(25, 'Publicación 480 - IMAGEN', '2025-09-09 22:42:45', 0, 'IMAGEN'),
(8, 'Publicación 481 - VIDEO', '2025-12-09 22:42:45', 1, 'VIDEO'),
(8, 'Publicación 482 - TEXTO', '2025-09-02 22:42:45', 1, 'TEXTO'),
(13, 'Publicación 483 - IMAGEN', '2025-10-16 22:42:45', 0, 'IMAGEN'),
(11, 'Publicación 484 - VIDEO', '2026-01-18 22:42:45', 1, 'VIDEO'),
(6, 'Publicación 485 - TEXTO', '2025-10-08 22:42:45', 0, 'TEXTO'),
(1, 'Publicación 486 - IMAGEN', '2026-01-22 22:42:45', 1, 'IMAGEN'),
(18, 'Publicación 487 - VIDEO', '2025-11-03 22:42:45', 1, 'VIDEO'),
(10, 'Publicación 488 - TEXTO', '2025-09-06 22:42:45', 0, 'TEXTO'),
(23, 'Publicación 489 - IMAGEN', '2025-09-28 22:42:45', 1, 'IMAGEN'),
(22, 'Publicación 490 - VIDEO', '2025-11-10 22:42:45', 0, 'VIDEO'),
(20, 'Publicación 491 - TEXTO', '2026-01-24 22:42:45', 1, 'TEXTO'),
(8, 'Publicación 492 - IMAGEN', '2025-12-03 22:42:45', 0, 'IMAGEN'),
(3, 'Publicación 493 - VIDEO', '2026-01-12 22:42:45', 1, 'VIDEO'),
(3, 'Publicación 494 - TEXTO', '2026-01-13 22:42:45', 1, 'TEXTO'),
(11, 'Publicación 495 - IMAGEN', '2025-09-08 22:42:45', 1, 'IMAGEN'),
(4, 'Publicación 496 - VIDEO', '2025-09-20 22:42:45', 1, 'VIDEO'),
(15, 'Publicación 497 - TEXTO', '2025-11-01 22:42:45', 1, 'TEXTO'),
(16, 'Publicación 498 - IMAGEN', '2026-02-04 22:42:45', 1, 'IMAGEN'),
(6, 'Publicación 499 - VIDEO', '2025-10-02 22:42:45', 0, 'VIDEO'),
(3, 'Publicación 500 - TEXTO', '2026-01-03 22:42:45', 1, 'TEXTO'),
(24, 'Publicación 501 - IMAGEN', '2026-02-13 22:42:45', 1, 'IMAGEN'),
(23, 'Publicación 502 - VIDEO', '2026-01-24 22:42:45', 1, 'VIDEO'),
(9, 'Publicación 503 - TEXTO', '2025-11-03 22:42:45', 1, 'TEXTO'),
(9, 'Publicación 504 - IMAGEN', '2025-10-11 22:42:45', 1, 'IMAGEN'),
(24, 'Publicación 505 - VIDEO', '2026-02-18 22:42:45', 1, 'VIDEO'),
(14, 'Publicación 506 - TEXTO', '2025-11-11 22:42:45', 1, 'TEXTO'),
(8, 'Publicación 507 - IMAGEN', '2025-10-26 22:42:45', 1, 'IMAGEN'),
(24, 'Publicación 508 - VIDEO', '2025-09-20 22:42:45', 1, 'VIDEO'),
(12, 'Publicación 509 - TEXTO', '2026-02-05 22:42:45', 1, 'TEXTO'),
(7, 'Publicación 510 - IMAGEN', '2025-09-07 22:42:45', 1, 'IMAGEN'),
(17, 'Publicación 511 - VIDEO', '2026-02-08 22:42:45', 1, 'VIDEO'),
(12, 'Publicación 512 - TEXTO', '2025-12-27 22:42:45', 1, 'TEXTO'),
(1, 'Publicación 513 - IMAGEN', '2026-01-23 22:42:45', 1, 'IMAGEN'),
(22, 'Publicación 514 - VIDEO', '2025-11-12 22:42:45', 1, 'VIDEO'),
(26, 'Publicación 515 - TEXTO', '2026-01-29 22:42:45', 1, 'TEXTO'),
(22, 'Publicación 516 - IMAGEN', '2025-12-20 22:42:45', 1, 'IMAGEN'),
(17, 'Publicación 517 - VIDEO', '2025-09-26 22:42:45', 1, 'VIDEO'),
(24, 'Publicación 518 - TEXTO', '2026-02-19 22:42:45', 1, 'TEXTO'),
(20, 'Publicación 519 - IMAGEN', '2026-02-04 22:42:45', 0, 'IMAGEN'),
(5, 'Publicación 520 - VIDEO', '2025-11-15 22:42:45', 1, 'VIDEO'),
(14, 'Publicación 521 - TEXTO', '2026-01-17 22:42:45', 1, 'TEXTO'),
(4, 'Publicación 522 - IMAGEN', '2025-10-10 22:42:45', 0, 'IMAGEN'),
(13, 'Publicación 523 - VIDEO', '2026-02-01 22:42:45', 1, 'VIDEO'),
(20, 'Publicación 524 - TEXTO', '2026-01-27 22:42:45', 0, 'TEXTO'),
(15, 'Publicación 525 - IMAGEN', '2026-01-23 22:42:45', 1, 'IMAGEN'),
(12, 'Publicación 526 - VIDEO', '2025-10-08 22:42:45', 0, 'VIDEO'),
(19, 'Publicación 527 - TEXTO', '2026-02-11 22:42:45', 0, 'TEXTO'),
(15, 'Publicación 528 - IMAGEN', '2026-01-14 22:42:45', 0, 'IMAGEN'),
(23, 'Publicación 529 - VIDEO', '2025-10-30 22:42:45', 1, 'VIDEO'),
(18, 'Publicación 530 - TEXTO', '2025-09-25 22:42:45', 1, 'TEXTO'),
(11, 'Publicación 531 - IMAGEN', '2025-11-22 22:42:45', 1, 'IMAGEN'),
(6, 'Publicación 532 - VIDEO', '2026-02-10 22:42:45', 1, 'VIDEO'),
(6, 'Publicación 533 - TEXTO', '2025-11-03 22:42:45', 0, 'TEXTO'),
(1, 'Publicación 534 - IMAGEN', '2026-02-07 22:42:45', 1, 'IMAGEN'),
(2, 'Publicación 535 - VIDEO', '2025-12-09 22:42:45', 1, 'VIDEO'),
(19, 'Publicación 536 - TEXTO', '2025-11-18 22:42:45', 0, 'TEXTO'),
(22, 'Publicación 537 - IMAGEN', '2025-10-09 22:42:45', 1, 'IMAGEN'),
(6, 'Publicación 538 - VIDEO', '2025-12-27 22:42:45', 1, 'VIDEO'),
(15, 'Publicación 539 - TEXTO', '2025-11-14 22:42:45', 0, 'TEXTO'),
(7, 'Publicación 540 - IMAGEN', '2026-02-03 22:42:45', 0, 'IMAGEN'),
(21, 'Publicación 541 - VIDEO', '2025-11-02 22:42:45', 1, 'VIDEO'),
(26, 'Publicación 542 - TEXTO', '2026-01-24 22:42:45', 1, 'TEXTO'),
(14, 'Publicación 543 - IMAGEN', '2026-01-12 22:42:45', 0, 'IMAGEN'),
(10, 'Publicación 544 - VIDEO', '2025-09-07 22:42:45', 0, 'VIDEO'),
(11, 'Publicación 545 - TEXTO', '2026-01-16 22:42:45', 0, 'TEXTO'),
(22, 'Publicación 546 - IMAGEN', '2025-10-06 22:42:45', 1, 'IMAGEN'),
(25, 'Publicación 547 - VIDEO', '2025-11-06 22:42:45', 1, 'VIDEO'),
(13, 'Publicación 548 - TEXTO', '2025-12-23 22:42:45', 1, 'TEXTO'),
(1, 'Publicación 549 - IMAGEN', '2025-09-01 22:42:45', 1, 'IMAGEN'),
(15, 'Publicación 550 - VIDEO', '2025-12-14 22:42:45', 0, 'VIDEO'),
(1, 'Publicación 551 - TEXTO', '2025-12-11 22:42:45', 1, 'TEXTO'),
(25, 'Publicación 552 - IMAGEN', '2025-12-24 22:42:45', 0, 'IMAGEN'),
(2, 'Publicación 553 - VIDEO', '2025-11-16 22:42:45', 0, 'VIDEO'),
(26, 'Publicación 554 - TEXTO', '2026-01-14 22:42:45', 0, 'TEXTO'),
(24, 'Publicación 555 - IMAGEN', '2025-12-07 22:42:45', 1, 'IMAGEN'),
(8, 'Publicación 556 - VIDEO', '2025-10-22 22:42:45', 0, 'VIDEO'),
(9, 'Publicación 557 - TEXTO', '2026-02-14 22:42:45', 1, 'TEXTO'),
(20, 'Publicación 558 - IMAGEN', '2025-09-08 22:42:45', 0, 'IMAGEN'),
(5, 'Publicación 559 - VIDEO', '2025-11-28 22:42:45', 1, 'VIDEO'),
(4, 'Publicación 560 - TEXTO', '2026-02-10 22:42:45', 1, 'TEXTO'),
(3, 'Publicación 561 - IMAGEN', '2025-11-13 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 562 - VIDEO', '2026-01-14 22:42:45', 1, 'VIDEO'),
(25, 'Publicación 563 - TEXTO', '2025-09-27 22:42:45', 0, 'TEXTO'),
(6, 'Publicación 564 - IMAGEN', '2025-09-29 22:42:45', 1, 'IMAGEN'),
(7, 'Publicación 565 - VIDEO', '2025-12-08 22:42:45', 1, 'VIDEO'),
(21, 'Publicación 566 - TEXTO', '2025-10-24 22:42:45', 1, 'TEXTO'),
(2, 'Publicación 567 - IMAGEN', '2025-09-01 22:42:45', 1, 'IMAGEN'),
(4, 'Publicación 568 - VIDEO', '2026-02-26 22:42:45', 1, 'VIDEO'),
(7, 'Publicación 569 - TEXTO', '2026-02-22 22:42:45', 0, 'TEXTO'),
(15, 'Publicación 570 - IMAGEN', '2026-01-24 22:42:45', 1, 'IMAGEN'),
(17, 'Publicación 571 - VIDEO', '2025-11-01 22:42:45', 1, 'VIDEO'),
(5, 'Publicación 572 - TEXTO', '2026-02-04 22:42:45', 1, 'TEXTO'),
(25, 'Publicación 573 - IMAGEN', '2026-02-22 22:42:45', 1, 'IMAGEN'),
(6, 'Publicación 574 - VIDEO', '2025-12-12 22:42:45', 1, 'VIDEO'),
(7, 'Publicación 575 - TEXTO', '2025-11-29 22:42:45', 1, 'TEXTO'),
(10, 'Publicación 576 - IMAGEN', '2025-11-03 22:42:45', 1, 'IMAGEN'),
(19, 'Publicación 577 - VIDEO', '2026-02-21 22:42:45', 1, 'VIDEO'),
(20, 'Publicación 578 - TEXTO', '2025-12-21 22:42:45', 0, 'TEXTO'),
(10, 'Publicación 579 - IMAGEN', '2025-12-08 22:42:45', 1, 'IMAGEN'),
(23, 'Publicación 580 - VIDEO', '2025-11-11 22:42:45', 1, 'VIDEO'),
(21, 'Publicación 581 - TEXTO', '2025-09-21 22:42:45', 1, 'TEXTO'),
(9, 'Publicación 582 - IMAGEN', '2025-10-15 22:42:45', 1, 'IMAGEN'),
(4, 'Publicación 583 - VIDEO', '2025-11-23 22:42:45', 1, 'VIDEO'),
(26, 'Publicación 584 - TEXTO', '2025-09-06 22:42:45', 1, 'TEXTO'),
(9, 'Publicación 585 - IMAGEN', '2025-12-11 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 586 - VIDEO', '2026-01-18 22:42:45', 1, 'VIDEO'),
(1, 'Publicación 587 - TEXTO', '2025-09-09 22:42:45', 0, 'TEXTO'),
(20, 'Publicación 588 - IMAGEN', '2026-02-22 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 589 - VIDEO', '2026-01-13 22:42:45', 1, 'VIDEO'),
(19, 'Publicación 590 - TEXTO', '2026-01-11 22:42:45', 0, 'TEXTO'),
(11, 'Publicación 591 - IMAGEN', '2026-02-22 22:42:45', 1, 'IMAGEN'),
(23, 'Publicación 592 - VIDEO', '2025-10-29 22:42:45', 1, 'VIDEO'),
(14, 'Publicación 593 - TEXTO', '2026-02-03 22:42:45', 0, 'TEXTO'),
(25, 'Publicación 594 - IMAGEN', '2026-01-29 22:42:45', 1, 'IMAGEN'),
(14, 'Publicación 595 - VIDEO', '2026-02-07 22:42:45', 1, 'VIDEO'),
(3, 'Publicación 596 - TEXTO', '2025-11-19 22:42:45', 1, 'TEXTO'),
(20, 'Publicación 597 - IMAGEN', '2025-11-11 22:42:45', 1, 'IMAGEN'),
(20, 'Publicación 598 - VIDEO', '2026-01-01 22:42:45', 1, 'VIDEO'),
(24, 'Publicación 599 - TEXTO', '2025-09-23 22:42:45', 0, 'TEXTO'),
(15, 'Publicación 600 - IMAGEN', '2025-09-07 22:42:45', 0, 'IMAGEN'),
(20, 'Publicación 601 - VIDEO', '2026-01-25 22:42:45', 1, 'VIDEO'),
(12, 'Publicación 602 - TEXTO', '2026-02-07 22:42:45', 1, 'TEXTO'),
(9, 'Publicación 603 - IMAGEN', '2025-09-21 22:42:45', 0, 'IMAGEN'),
(5, 'Publicación 604 - VIDEO', '2025-12-19 22:42:45', 0, 'VIDEO'),
(13, 'Publicación 605 - TEXTO', '2026-02-17 22:42:45', 1, 'TEXTO'),
(22, 'Publicación 606 - IMAGEN', '2025-11-25 22:42:45', 1, 'IMAGEN'),
(25, 'Publicación 607 - VIDEO', '2025-11-13 22:42:45', 1, 'VIDEO'),
(15, 'Publicación 608 - TEXTO', '2025-12-04 22:42:45', 0, 'TEXTO'),
(26, 'Publicación 609 - IMAGEN', '2025-11-08 22:42:45', 1, 'IMAGEN'),
(14, 'Publicación 610 - VIDEO', '2026-02-02 22:42:45', 1, 'VIDEO'),
(16, 'Publicación 611 - TEXTO', '2025-12-19 22:42:45', 0, 'TEXTO'),
(15, 'Publicación 612 - IMAGEN', '2025-12-26 22:42:45', 1, 'IMAGEN'),
(19, 'Publicación 613 - VIDEO', '2025-10-22 22:42:45', 1, 'VIDEO'),
(8, 'Publicación 614 - TEXTO', '2026-02-23 22:42:45', 0, 'TEXTO'),
(9, 'Publicación 615 - IMAGEN', '2026-02-27 22:42:45', 1, 'IMAGEN'),
(9, 'Publicación 616 - VIDEO', '2026-02-22 22:42:45', 1, 'VIDEO'),
(21, 'Publicación 617 - TEXTO', '2026-02-22 22:42:45', 1, 'TEXTO'),
(5, 'Publicación 618 - IMAGEN', '2026-01-25 22:42:45', 1, 'IMAGEN'),
(13, 'Publicación 619 - VIDEO', '2025-09-30 22:42:45', 1, 'VIDEO'),
(2, 'Publicación 620 - TEXTO', '2026-01-04 22:42:45', 1, 'TEXTO'),
(2, 'Publicación 621 - IMAGEN', '2025-11-23 22:42:45', 1, 'IMAGEN'),
(18, 'Publicación 622 - VIDEO', '2025-09-21 22:42:45', 0, 'VIDEO'),
(7, 'Publicación 623 - TEXTO', '2026-01-08 22:42:45', 0, 'TEXTO'),
(15, 'Publicación 624 - IMAGEN', '2026-01-31 22:42:45', 0, 'IMAGEN'),
(19, 'Publicación 625 - VIDEO', '2025-12-08 22:42:45', 1, 'VIDEO'),
(7, 'Publicación 626 - TEXTO', '2025-09-26 22:42:45', 0, 'TEXTO'),
(15, 'Publicación 627 - IMAGEN', '2025-09-04 22:42:45', 0, 'IMAGEN'),
(2, 'Publicación 628 - VIDEO', '2026-02-10 22:42:45', 1, 'VIDEO'),
(15, 'Publicación 629 - TEXTO', '2025-12-14 22:42:45', 1, 'TEXTO'),
(22, 'Publicación 630 - IMAGEN', '2025-12-05 22:42:45', 0, 'IMAGEN'),
(4, 'Publicación 631 - VIDEO', '2026-01-12 22:42:45', 1, 'VIDEO'),
(2, 'Publicación 632 - TEXTO', '2026-01-27 22:42:45', 1, 'TEXTO'),
(11, 'Publicación 633 - IMAGEN', '2025-12-17 22:42:45', 1, 'IMAGEN'),
(13, 'Publicación 634 - VIDEO', '2025-10-31 22:42:45', 1, 'VIDEO'),
(4, 'Publicación 635 - TEXTO', '2025-09-20 22:42:45', 1, 'TEXTO'),
(9, 'Publicación 636 - IMAGEN', '2025-09-13 22:42:45', 1, 'IMAGEN'),
(22, 'Publicación 637 - VIDEO', '2026-02-06 22:42:45', 1, 'VIDEO'),
(24, 'Publicación 638 - TEXTO', '2025-10-13 22:42:45', 1, 'TEXTO'),
(22, 'Publicación 639 - IMAGEN', '2026-01-23 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 640 - VIDEO', '2026-01-31 22:42:45', 1, 'VIDEO'),
(12, 'Publicación 641 - TEXTO', '2025-11-25 22:42:45', 1, 'TEXTO'),
(3, 'Publicación 642 - IMAGEN', '2025-10-07 22:42:45', 0, 'IMAGEN'),
(2, 'Publicación 643 - VIDEO', '2025-09-12 22:42:45', 0, 'VIDEO'),
(11, 'Publicación 644 - TEXTO', '2025-11-11 22:42:45', 1, 'TEXTO'),
(18, 'Publicación 645 - IMAGEN', '2025-12-05 22:42:45', 1, 'IMAGEN'),
(2, 'Publicación 646 - VIDEO', '2026-02-05 22:42:45', 1, 'VIDEO'),
(23, 'Publicación 647 - TEXTO', '2025-10-14 22:42:45', 1, 'TEXTO'),
(1, 'Publicación 648 - IMAGEN', '2025-09-04 22:42:45', 1, 'IMAGEN'),
(7, 'Publicación 649 - VIDEO', '2025-12-05 22:42:45', 1, 'VIDEO'),
(11, 'Publicación 650 - TEXTO', '2025-10-14 22:42:45', 0, 'TEXTO'),
(6, 'Publicación 651 - IMAGEN', '2025-11-28 22:42:45', 1, 'IMAGEN'),
(4, 'Publicación 652 - VIDEO', '2026-02-18 22:42:45', 0, 'VIDEO'),
(7, 'Publicación 653 - TEXTO', '2025-10-20 22:42:45', 1, 'TEXTO'),
(13, 'Publicación 654 - IMAGEN', '2026-01-04 22:42:45', 1, 'IMAGEN'),
(13, 'Publicación 655 - VIDEO', '2025-11-21 22:42:45', 1, 'VIDEO'),
(16, 'Publicación 656 - TEXTO', '2026-01-14 22:42:45', 1, 'TEXTO'),
(25, 'Publicación 657 - IMAGEN', '2026-02-13 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 658 - VIDEO', '2025-10-21 22:42:45', 1, 'VIDEO'),
(18, 'Publicación 659 - TEXTO', '2025-11-22 22:42:45', 1, 'TEXTO'),
(10, 'Publicación 660 - IMAGEN', '2025-09-12 22:42:45', 1, 'IMAGEN'),
(15, 'Publicación 661 - VIDEO', '2025-10-10 22:42:45', 1, 'VIDEO'),
(3, 'Publicación 662 - TEXTO', '2025-11-03 22:42:45', 1, 'TEXTO'),
(17, 'Publicación 663 - IMAGEN', '2026-01-18 22:42:45', 1, 'IMAGEN'),
(16, 'Publicación 664 - VIDEO', '2025-09-29 22:42:45', 1, 'VIDEO'),
(9, 'Publicación 665 - TEXTO', '2025-12-11 22:42:45', 1, 'TEXTO'),
(22, 'Publicación 666 - IMAGEN', '2026-02-11 22:42:45', 1, 'IMAGEN'),
(3, 'Publicación 667 - VIDEO', '2025-09-20 22:42:45', 1, 'VIDEO'),
(12, 'Publicación 668 - TEXTO', '2025-11-16 22:42:45', 1, 'TEXTO'),
(6, 'Publicación 669 - IMAGEN', '2026-02-13 22:42:45', 1, 'IMAGEN'),
(21, 'Publicación 670 - VIDEO', '2025-11-08 22:42:45', 0, 'VIDEO'),
(15, 'Publicación 671 - TEXTO', '2026-02-14 22:42:45', 0, 'TEXTO'),
(3, 'Publicación 672 - IMAGEN', '2025-10-29 22:42:45', 1, 'IMAGEN'),
(18, 'Publicación 673 - VIDEO', '2025-12-31 22:42:45', 1, 'VIDEO'),
(20, 'Publicación 674 - TEXTO', '2025-11-07 22:42:45', 1, 'TEXTO'),
(21, 'Publicación 675 - IMAGEN', '2026-02-20 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 676 - VIDEO', '2026-01-31 22:42:45', 1, 'VIDEO'),
(25, 'Publicación 677 - TEXTO', '2026-01-28 22:42:45', 1, 'TEXTO'),
(13, 'Publicación 678 - IMAGEN', '2025-10-28 22:42:45', 1, 'IMAGEN'),
(23, 'Publicación 679 - VIDEO', '2025-11-05 22:42:45', 0, 'VIDEO'),
(1, 'Publicación 680 - TEXTO', '2025-11-11 22:42:45', 1, 'TEXTO'),
(11, 'Publicación 681 - IMAGEN', '2026-01-25 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 682 - VIDEO', '2025-12-14 22:42:45', 1, 'VIDEO'),
(15, 'Publicación 683 - TEXTO', '2026-02-09 22:42:45', 0, 'TEXTO'),
(4, 'Publicación 684 - IMAGEN', '2026-01-20 22:42:45', 0, 'IMAGEN'),
(16, 'Publicación 685 - VIDEO', '2026-01-23 22:42:45', 1, 'VIDEO'),
(24, 'Publicación 686 - TEXTO', '2025-10-16 22:42:45', 1, 'TEXTO'),
(9, 'Publicación 687 - IMAGEN', '2026-01-25 22:42:45', 1, 'IMAGEN'),
(3, 'Publicación 688 - VIDEO', '2025-09-29 22:42:45', 0, 'VIDEO'),
(13, 'Publicación 689 - TEXTO', '2025-10-01 22:42:45', 1, 'TEXTO'),
(15, 'Publicación 690 - IMAGEN', '2025-12-22 22:42:45', 0, 'IMAGEN'),
(24, 'Publicación 691 - VIDEO', '2025-12-31 22:42:45', 0, 'VIDEO'),
(6, 'Publicación 692 - TEXTO', '2026-02-05 22:42:45', 0, 'TEXTO'),
(22, 'Publicación 693 - IMAGEN', '2026-01-04 22:42:45', 0, 'IMAGEN'),
(10, 'Publicación 694 - VIDEO', '2026-02-09 22:42:45', 1, 'VIDEO'),
(22, 'Publicación 695 - TEXTO', '2025-09-28 22:42:45', 0, 'TEXTO'),
(25, 'Publicación 696 - IMAGEN', '2025-12-15 22:42:45', 1, 'IMAGEN'),
(12, 'Publicación 697 - VIDEO', '2026-01-23 22:42:45', 0, 'VIDEO'),
(20, 'Publicación 698 - TEXTO', '2025-12-31 22:42:45', 0, 'TEXTO'),
(8, 'Publicación 699 - IMAGEN', '2025-09-13 22:42:45', 1, 'IMAGEN'),
(8, 'Publicación 700 - VIDEO', '2026-01-03 22:42:45', 1, 'VIDEO'),
(7, 'Publicación 701 - TEXTO', '2026-01-22 22:42:45', 1, 'TEXTO'),
(23, 'Publicación 702 - IMAGEN', '2025-09-21 22:42:45', 0, 'IMAGEN'),
(26, 'Publicación 703 - VIDEO', '2025-10-04 22:42:45', 0, 'VIDEO'),
(25, 'Publicación 704 - TEXTO', '2025-12-26 22:42:45', 0, 'TEXTO'),
(4, 'Publicación 705 - IMAGEN', '2026-02-20 22:42:45', 1, 'IMAGEN'),
(26, 'Publicación 706 - VIDEO', '2025-09-11 22:42:45', 1, 'VIDEO'),
(10, 'Publicación 707 - TEXTO', '2025-10-24 22:42:45', 0, 'TEXTO'),
(13, 'Publicación 708 - IMAGEN', '2025-11-29 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 709 - VIDEO', '2025-10-16 22:42:45', 0, 'VIDEO'),
(9, 'Publicación 710 - TEXTO', '2025-10-16 22:42:45', 0, 'TEXTO'),
(16, 'Publicación 711 - IMAGEN', '2026-01-30 22:42:45', 1, 'IMAGEN'),
(24, 'Publicación 712 - VIDEO', '2025-11-05 22:42:45', 1, 'VIDEO'),
(1, 'Publicación 713 - TEXTO', '2025-11-20 22:42:45', 1, 'TEXTO'),
(16, 'Publicación 714 - IMAGEN', '2025-09-04 22:42:45', 0, 'IMAGEN'),
(19, 'Publicación 715 - VIDEO', '2025-10-05 22:42:45', 1, 'VIDEO'),
(16, 'Publicación 716 - TEXTO', '2026-02-20 22:42:45', 1, 'TEXTO'),
(21, 'Publicación 717 - IMAGEN', '2025-10-28 22:42:45', 0, 'IMAGEN'),
(10, 'Publicación 718 - VIDEO', '2025-11-07 22:42:45', 0, 'VIDEO'),
(9, 'Publicación 719 - TEXTO', '2025-09-07 22:42:45', 1, 'TEXTO'),
(26, 'Publicación 720 - IMAGEN', '2025-11-24 22:42:45', 1, 'IMAGEN'),
(21, 'Publicación 721 - VIDEO', '2025-09-28 22:42:45', 1, 'VIDEO'),
(4, 'Publicación 722 - TEXTO', '2026-01-12 22:42:45', 1, 'TEXTO'),
(14, 'Publicación 723 - IMAGEN', '2025-11-24 22:42:45', 1, 'IMAGEN'),
(15, 'Publicación 724 - VIDEO', '2025-10-28 22:42:45', 1, 'VIDEO'),
(17, 'Publicación 725 - TEXTO', '2026-01-20 22:42:45', 1, 'TEXTO'),
(13, 'Publicación 726 - IMAGEN', '2025-09-22 22:42:45', 1, 'IMAGEN'),
(14, 'Publicación 727 - VIDEO', '2026-02-06 22:42:45', 1, 'VIDEO'),
(6, 'Publicación 728 - TEXTO', '2025-11-07 22:42:45', 1, 'TEXTO'),
(19, 'Publicación 729 - IMAGEN', '2025-09-20 22:42:45', 1, 'IMAGEN'),
(25, 'Publicación 730 - VIDEO', '2025-09-13 22:42:45', 1, 'VIDEO'),
(26, 'Publicación 731 - TEXTO', '2026-02-12 22:42:45', 1, 'TEXTO'),
(2, 'Publicación 732 - IMAGEN', '2025-11-19 22:42:45', 1, 'IMAGEN'),
(15, 'Publicación 733 - VIDEO', '2025-12-21 22:42:45', 0, 'VIDEO'),
(4, 'Publicación 734 - TEXTO', '2026-01-22 22:42:45', 0, 'TEXTO'),
(16, 'Publicación 735 - IMAGEN', '2025-11-05 22:42:45', 1, 'IMAGEN'),
(19, 'Publicación 736 - VIDEO', '2026-02-27 22:42:45', 0, 'VIDEO'),
(24, 'Publicación 737 - TEXTO', '2025-11-08 22:42:45', 1, 'TEXTO'),
(7, 'Publicación 738 - IMAGEN', '2025-09-13 22:42:45', 1, 'IMAGEN'),
(25, 'Publicación 739 - VIDEO', '2026-02-15 22:42:45', 1, 'VIDEO'),
(13, 'Publicación 740 - TEXTO', '2026-01-06 22:42:45', 0, 'TEXTO'),
(26, 'Publicación 741 - IMAGEN', '2026-01-05 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 742 - VIDEO', '2025-10-27 22:42:45', 1, 'VIDEO'),
(17, 'Publicación 743 - TEXTO', '2026-01-13 22:42:45', 1, 'TEXTO'),
(22, 'Publicación 744 - IMAGEN', '2026-01-21 22:42:45', 1, 'IMAGEN'),
(4, 'Publicación 745 - VIDEO', '2025-09-04 22:42:45', 1, 'VIDEO'),
(21, 'Publicación 746 - TEXTO', '2025-12-31 22:42:45', 1, 'TEXTO'),
(14, 'Publicación 747 - IMAGEN', '2025-10-04 22:42:45', 1, 'IMAGEN'),
(9, 'Publicación 748 - VIDEO', '2026-02-06 22:42:45', 1, 'VIDEO'),
(10, 'Publicación 749 - TEXTO', '2026-01-30 22:42:45', 0, 'TEXTO'),
(13, 'Publicación 750 - IMAGEN', '2025-11-04 22:42:45', 0, 'IMAGEN'),
(7, 'Publicación 751 - VIDEO', '2025-12-07 22:42:45', 1, 'VIDEO'),
(14, 'Publicación 752 - TEXTO', '2025-10-26 22:42:45', 0, 'TEXTO'),
(18, 'Publicación 753 - IMAGEN', '2026-02-01 22:42:45', 1, 'IMAGEN'),
(7, 'Publicación 754 - VIDEO', '2025-12-21 22:42:45', 1, 'VIDEO'),
(7, 'Publicación 755 - TEXTO', '2025-12-29 22:42:45', 1, 'TEXTO'),
(5, 'Publicación 756 - IMAGEN', '2026-02-21 22:42:45', 1, 'IMAGEN'),
(22, 'Publicación 757 - VIDEO', '2025-10-06 22:42:45', 1, 'VIDEO'),
(23, 'Publicación 758 - TEXTO', '2025-09-02 22:42:45', 0, 'TEXTO'),
(22, 'Publicación 759 - IMAGEN', '2025-10-16 22:42:45', 0, 'IMAGEN'),
(17, 'Publicación 760 - VIDEO', '2026-02-13 22:42:45', 1, 'VIDEO'),
(4, 'Publicación 761 - TEXTO', '2025-12-01 22:42:45', 1, 'TEXTO'),
(14, 'Publicación 762 - IMAGEN', '2026-01-02 22:42:45', 1, 'IMAGEN'),
(7, 'Publicación 763 - VIDEO', '2025-10-25 22:42:45', 1, 'VIDEO'),
(19, 'Publicación 764 - TEXTO', '2025-12-02 22:42:45', 0, 'TEXTO'),
(21, 'Publicación 765 - IMAGEN', '2025-09-04 22:42:45', 1, 'IMAGEN'),
(12, 'Publicación 766 - VIDEO', '2025-12-12 22:42:45', 1, 'VIDEO'),
(24, 'Publicación 767 - TEXTO', '2025-10-02 22:42:45', 1, 'TEXTO'),
(12, 'Publicación 768 - IMAGEN', '2026-02-10 22:42:45', 1, 'IMAGEN'),
(20, 'Publicación 769 - VIDEO', '2025-12-05 22:42:45', 1, 'VIDEO'),
(19, 'Publicación 770 - TEXTO', '2025-11-11 22:42:45', 0, 'TEXTO'),
(19, 'Publicación 771 - IMAGEN', '2025-09-24 22:42:45', 1, 'IMAGEN'),
(1, 'Publicación 772 - VIDEO', '2025-12-06 22:42:45', 1, 'VIDEO'),
(3, 'Publicación 773 - TEXTO', '2025-11-18 22:42:45', 1, 'TEXTO'),
(24, 'Publicación 774 - IMAGEN', '2025-10-15 22:42:45', 0, 'IMAGEN'),
(14, 'Publicación 775 - VIDEO', '2026-01-30 22:42:45', 1, 'VIDEO'),
(2, 'Publicación 776 - TEXTO', '2026-02-11 22:42:45', 1, 'TEXTO'),
(14, 'Publicación 777 - IMAGEN', '2025-12-15 22:42:45', 1, 'IMAGEN'),
(7, 'Publicación 778 - VIDEO', '2026-01-26 22:42:45', 0, 'VIDEO'),
(1, 'Publicación 779 - TEXTO', '2026-02-23 22:42:45', 1, 'TEXTO'),
(18, 'Publicación 780 - IMAGEN', '2025-12-15 22:42:45', 1, 'IMAGEN'),
(26, 'Publicación 781 - VIDEO', '2025-12-20 22:42:45', 0, 'VIDEO'),
(19, 'Publicación 782 - TEXTO', '2025-12-14 22:42:45', 1, 'TEXTO'),
(24, 'Publicación 783 - IMAGEN', '2025-09-16 22:42:45', 1, 'IMAGEN'),
(22, 'Publicación 784 - VIDEO', '2025-11-12 22:42:45', 1, 'VIDEO'),
(2, 'Publicación 785 - TEXTO', '2025-10-13 22:42:45', 1, 'TEXTO'),
(11, 'Publicación 786 - IMAGEN', '2026-02-17 22:42:45', 1, 'IMAGEN'),
(14, 'Publicación 787 - VIDEO', '2025-11-02 22:42:45', 1, 'VIDEO'),
(8, 'Publicación 788 - TEXTO', '2026-01-12 22:42:45', 1, 'TEXTO'),
(12, 'Publicación 789 - IMAGEN', '2025-10-12 22:42:45', 0, 'IMAGEN'),
(6, 'Publicación 790 - VIDEO', '2025-12-08 22:42:45', 1, 'VIDEO'),
(23, 'Publicación 791 - TEXTO', '2025-09-09 22:42:45', 0, 'TEXTO'),
(4, 'Publicación 792 - IMAGEN', '2026-02-17 22:42:45', 0, 'IMAGEN'),
(12, 'Publicación 793 - VIDEO', '2025-12-06 22:42:45', 0, 'VIDEO'),
(10, 'Publicación 794 - TEXTO', '2026-01-13 22:42:45', 1, 'TEXTO'),
(13, 'Publicación 795 - IMAGEN', '2026-01-22 22:42:45', 1, 'IMAGEN'),
(16, 'Publicación 796 - VIDEO', '2025-10-08 22:42:45', 1, 'VIDEO'),
(20, 'Publicación 797 - TEXTO', '2025-10-17 22:42:45', 0, 'TEXTO'),
(25, 'Publicación 798 - IMAGEN', '2025-09-03 22:42:45', 0, 'IMAGEN'),
(17, 'Publicación 799 - VIDEO', '2025-11-18 22:42:45', 1, 'VIDEO'),
(14, 'Publicación 800 - TEXTO', '2026-02-21 22:42:45', 0, 'TEXTO'),
(21, 'Publicación 801 - IMAGEN', '2025-12-27 22:42:45', 1, 'IMAGEN'),
(15, 'Publicación 802 - VIDEO', '2025-10-18 22:42:45', 1, 'VIDEO'),
(5, 'Publicación 803 - TEXTO', '2025-11-21 22:42:45', 0, 'TEXTO'),
(19, 'Publicación 804 - IMAGEN', '2026-01-28 22:42:45', 0, 'IMAGEN'),
(8, 'Publicación 805 - VIDEO', '2025-09-27 22:42:45', 1, 'VIDEO'),
(17, 'Publicación 806 - TEXTO', '2025-11-25 22:42:45', 1, 'TEXTO'),
(23, 'Publicación 807 - IMAGEN', '2025-12-31 22:42:45', 1, 'IMAGEN'),
(17, 'Publicación 808 - VIDEO', '2026-02-24 22:42:45', 1, 'VIDEO'),
(22, 'Publicación 809 - TEXTO', '2025-09-22 22:42:45', 1, 'TEXTO'),
(9, 'Publicación 810 - IMAGEN', '2025-11-19 22:42:45', 1, 'IMAGEN'),
(2, 'Publicación 811 - VIDEO', '2025-12-01 22:42:45', 1, 'VIDEO'),
(16, 'Publicación 812 - TEXTO', '2025-09-03 22:42:45', 1, 'TEXTO'),
(1, 'Publicación 813 - IMAGEN', '2026-01-24 22:42:45', 0, 'IMAGEN'),
(10, 'Publicación 814 - VIDEO', '2025-10-15 22:42:45', 1, 'VIDEO'),
(7, 'Publicación 815 - TEXTO', '2025-10-28 22:42:45', 1, 'TEXTO'),
(19, 'Publicación 816 - IMAGEN', '2025-10-13 22:42:45', 1, 'IMAGEN'),
(12, 'Publicación 817 - VIDEO', '2026-02-05 22:42:45', 0, 'VIDEO'),
(18, 'Publicación 818 - TEXTO', '2025-10-28 22:42:45', 0, 'TEXTO'),
(12, 'Publicación 819 - IMAGEN', '2025-12-17 22:42:45', 1, 'IMAGEN'),
(22, 'Publicación 820 - VIDEO', '2025-10-15 22:42:45', 1, 'VIDEO'),
(5, 'Publicación 821 - TEXTO', '2025-10-22 22:42:45', 1, 'TEXTO'),
(2, 'Publicación 822 - IMAGEN', '2026-01-13 22:42:45', 1, 'IMAGEN'),
(10, 'Publicación 823 - VIDEO', '2025-11-13 22:42:45', 1, 'VIDEO'),
(7, 'Publicación 824 - TEXTO', '2025-12-31 22:42:45', 1, 'TEXTO'),
(18, 'Publicación 825 - IMAGEN', '2026-01-17 22:42:45', 0, 'IMAGEN'),
(1, 'Publicación 826 - VIDEO', '2025-09-10 22:42:45', 1, 'VIDEO'),
(11, 'Publicación 827 - TEXTO', '2025-12-01 22:42:45', 1, 'TEXTO'),
(3, 'Publicación 828 - IMAGEN', '2025-10-23 22:42:45', 1, 'IMAGEN'),
(16, 'Publicación 829 - VIDEO', '2025-12-07 22:42:45', 0, 'VIDEO'),
(26, 'Publicación 830 - TEXTO', '2025-12-01 22:42:45', 0, 'TEXTO'),
(8, 'Publicación 831 - IMAGEN', '2025-09-16 22:42:45', 1, 'IMAGEN'),
(23, 'Publicación 832 - VIDEO', '2026-01-20 22:42:46', 1, 'VIDEO'),
(9, 'Publicación 833 - TEXTO', '2025-10-11 22:42:46', 0, 'TEXTO'),
(25, 'Publicación 834 - IMAGEN', '2026-01-31 22:42:46', 1, 'IMAGEN'),
(17, 'Publicación 835 - VIDEO', '2025-11-24 22:42:46', 1, 'VIDEO'),
(4, 'Publicación 836 - TEXTO', '2026-02-02 22:42:46', 1, 'TEXTO'),
(24, 'Publicación 837 - IMAGEN', '2026-01-25 22:42:46', 1, 'IMAGEN'),
(3, 'Publicación 838 - VIDEO', '2025-11-26 22:42:46', 1, 'VIDEO'),
(6, 'Publicación 839 - TEXTO', '2026-02-08 22:42:46', 0, 'TEXTO'),
(12, 'Publicación 840 - IMAGEN', '2025-09-09 22:42:46', 1, 'IMAGEN'),
(14, 'Publicación 841 - VIDEO', '2026-02-17 22:42:46', 1, 'VIDEO'),
(9, 'Publicación 842 - TEXTO', '2025-09-12 22:42:46', 1, 'TEXTO'),
(21, 'Publicación 843 - IMAGEN', '2026-02-18 22:42:46', 1, 'IMAGEN'),
(6, 'Publicación 844 - VIDEO', '2025-09-24 22:42:46', 1, 'VIDEO'),
(9, 'Publicación 845 - TEXTO', '2025-10-02 22:42:46', 1, 'TEXTO'),
(8, 'Publicación 846 - IMAGEN', '2025-11-30 22:42:46', 1, 'IMAGEN'),
(12, 'Publicación 847 - VIDEO', '2025-10-16 22:42:46', 1, 'VIDEO'),
(19, 'Publicación 848 - TEXTO', '2026-01-06 22:42:46', 1, 'TEXTO'),
(17, 'Publicación 849 - IMAGEN', '2026-01-25 22:42:46', 1, 'IMAGEN'),
(18, 'Publicación 850 - VIDEO', '2025-10-17 22:42:46', 0, 'VIDEO');

PRINT ' 850 publicaciones insertadas correctamente';
GO


-- PUBLICACIONES POLÉMICAS PARA CREADORES 27-30

USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'CREANDO PUBLICACIONES POLÉMICAS';
PRINT '========================================';
GO


-- 1. VERIFICAR QUE LOS CREADORES POLÉMICOS EXISTEN

IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id = 27)
BEGIN
    PRINT 'ERROR: Faltan los usuarios 27-30. Debes insertarlos primero.';
    RETURN;
END
GO


-- 2. CREAR PUBLICACIONES POLÉMICAS (3 cada uno = 12 publicaciones)

PRINT 'Creando publicaciones para creadores polémicos...';

DECLARE @creador_polemico INT;
DECLARE @pub_id INT;

DECLARE cursor_polemicos CURSOR FOR 
    SELECT idUsuario FROM Creador WHERE idUsuario BETWEEN 27 AND 30;

OPEN cursor_polemicos;
FETCH NEXT FROM cursor_polemicos INTO @creador_polemico;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Publicación 1: Muchos comentarios, pocas reacciones
    INSERT INTO Publicacion (idCreador, titulo, fecha_publicacion, es_publica, tipo_contenido)
    VALUES (@creador_polemico, 'Opinión: Lo que nadie se atreve a decir', DATEADD(DAY, -5, GETDATE()), 1, 'TEXTO');
    
    SET @pub_id = SCOPE_IDENTITY();
    
    -- Agregar 25 comentarios (muchos)
    INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
    SELECT TOP 25
        u.id,
        @pub_id,
        NULL,
        CASE ABS(CHECKSUM(NEWID())) % 5
            WHEN 0 THEN 'Totalmente en desacuerdo!'
            WHEN 1 THEN 'Qué estupidez acabo de leer'
            WHEN 2 THEN 'Esto es completamente falso'
            WHEN 3 THEN 'Fuente: de los deseos'
            ELSE 'No puedo creer que pienses así'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 5, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    -- Solo 2 reacciones (pocas)
    INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion)
    SELECT TOP 2
        u.id,
        @pub_id,
        CASE ABS(CHECKSUM(NEWID())) % 2 WHEN 0 THEN 5 ELSE 7 END, -- Me entristece o Me enfurece
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 5, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    -- Publicación 2: Muchos comentarios, cero reacciones
    INSERT INTO Publicacion (idCreador, titulo, fecha_publicacion, es_publica, tipo_contenido)
    VALUES (@creador_polemico, 'La verdad incómoda sobre...', DATEADD(DAY, -10, GETDATE()), 1, 'TEXTO');
    
    SET @pub_id = SCOPE_IDENTITY();
    
    -- Agregar 20 comentarios
    INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
    SELECT TOP 20
        u.id,
        @pub_id,
        NULL,
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Basado en qué evidencia?'
            WHEN 1 THEN 'Reportado por misinformation'
            WHEN 2 THEN 'Comparto pero no estoy de acuerdo'
            ELSE 'Necesitas leer más sobre el tema'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 8, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    -- NO agregar reacciones (0 reacciones) - ratio infinito
    
    -- Publicación 3: 15 comentarios, 1 reacción
    INSERT INTO Publicacion (idCreador, titulo, fecha_publicacion, es_publica, tipo_contenido)
    VALUES (@creador_polemico, 'Por qué todo el mundo está equivocado', DATEADD(DAY, -15, GETDATE()), 1, 'TEXTO');
    
    SET @pub_id = SCOPE_IDENTITY();
    
    -- Agregar 15 comentarios
    INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
    SELECT TOP 15
        u.id,
        @pub_id,
        NULL,
        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN 'Qué argumento tan pobre'
            WHEN 1 THEN 'Explícame tu lógica'
            ELSE 'No entiendo cómo puedes pensar eso'
        END,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 12, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    -- Agregar 1 reacción
    INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion)
    SELECT TOP 1
        u.id,
        @pub_id,
        5, -- Me entristece
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 12, GETDATE())
    FROM Usuario u
    WHERE u.id > 26
    ORDER BY NEWID();
    
    FETCH NEXT FROM cursor_polemicos INTO @creador_polemico;
END;

CLOSE cursor_polemicos;
DEALLOCATE cursor_polemicos;

PRINT 'Publicaciones polémicas creadas (3 por cada creador)';
GO


-- 3. VERIFICACIÓN CON LOS NOMBRES CORRECTOS 
PRINT '';
PRINT 'RESUMEN DE PUBLICACIONES POLÉMICAS:';
SELECT 
    u.nickname,
    COUNT(p.id) AS total_publicaciones  -- se cambio idPublicacion por id
FROM Creador c
JOIN Usuario u ON c.idUsuario = u.id
LEFT JOIN Publicacion p ON c.idUsuario = p.idCreador
WHERE c.idUsuario BETWEEN 27 AND 30
GROUP BY u.nickname;
GO




-- 5. DETALLES POR TIPO - VIDEOS
PRINT 'Insertando detalles de videos...';

-- Primero, limpiar videos existentes si los hay
DELETE FROM Video;
PRINT '✓ Videos anteriores eliminados';

-- Insertar videos SOLO para publicaciones que existen y son de tipo VIDEO
INSERT INTO Video (idPublicacion, duracion_seg, resolucion, url_stream)
SELECT 
    p.id,
    60 + ABS(CHECKSUM(NEWID())) % 3600, -- Duración entre 1 y 60 minutos
    CASE ABS(CHECKSUM(NEWID())) % 3
        WHEN 0 THEN '720p'
        WHEN 1 THEN '1080p'
        ELSE '4K'
    END,
    'https://stream.fanhub.com/video/' + CAST(p.id AS VARCHAR)
FROM Publicacion p
WHERE p.tipo_contenido = 'VIDEO'
AND NOT EXISTS (SELECT 1 FROM Video v WHERE v.idPublicacion = p.id);

PRINT ' Videos insertados correctamente';
GO

-- Verificar cuántos videos se insertaron
SELECT COUNT(*) as TotalVideos FROM Video;
GO


-- 6. ETIQUETAS (37 registros) 
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





-- 7. ASOCIACIONES ETIQUETAS-PUBLICACIONES 
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'REFRESH DE PUBLICACIONETIQUETA - VERSIÓN ALTA';
PRINT '========================================';
GO


-- 1. ELIMINAR REGISTROS EXISTENTES
PRINT 'Eliminando asociaciones existentes...';
DELETE FROM PublicacionEtiqueta;
PRINT ' Asociaciones eliminadas';
GO


-- 2. GENERAR NUEVAS ASOCIACIONES
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

PRINT ' Asociaciones principales generadas';
GO


-- 3. AGREGAR ASOCIACIONES ADICIONALES ALEATORIAS
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
ORDER BY NEWID();  

PRINT ' Asociaciones adicionales agregadas';
GO


-- 4. TERCERA PASADA: COMPLETAR HASTA LLEGAR A ~31,450
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

PRINT 'Volumen completado';
GO


-- 5. VERIFICAR RESULTADO FINAL
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

-- 6. VER DISTRIBUCIÓN POR CATEGORÍA
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


-- 8. MÉTODOS DE PAGO (260 registros con variedad de tarjetas)
PRINT '========================================';
PRINT 'LIMPIANDO Y REGENERANDO MÉTODOS DE PAGO';
PRINT '========================================';
GO


-- 1. LIMPIAR MÉTODOS DE PAGO EXISTENTES
PRINT 'Eliminando métodos de pago existentes...';
DELETE FROM MetodoPago;
PRINT 'Métodos de pago eliminados';
GO


-- 2. INSERTAR MÉTODOS DE PAGO CON VARIEDAD
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
        ELSE 'Visa' 
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

PRINT ' 260 métodos de pago insertados correctamente';
GO


-- 3. VERIFICAR LA DISTRIBUCIÓN DE TARJETAS
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


-- 4. VER MUESTRA DE LOS NUEVOS MÉTODOS DE PAGO
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
PRINT ' MÉTODOS DE PAGO REGENERADOS EXITOSAMENTE';
PRINT '========================================';
GO




--9. SUSCRIPCIONES (550 registros reales)
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'INSERTANDO 550 SUSCRIPCIONES REALES';
PRINT '========================================';
GO

-- Limpiar suscripciones existentes
PRINT 'Eliminando suscripciones anteriores...';
DELETE FROM Suscripcion;
PRINT ' Suscripciones anteriores eliminadas';
GO

PRINT 'Insertando 550 suscripciones reales...';
GO

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES 
(240, 57, '2026-02-25 23:02:21.513', '2026-03-25 23:02:21.513', '2026-04-24 23:02:21.513', 'Cancelada', 39.95),
(175, 35, '2025-06-23 23:02:21.517', '2025-07-23 23:02:21.517', NULL, 'Activa', 19.98),
(141, 28, '2025-06-20 23:02:21.520', '2025-07-20 23:02:21.520', '2025-07-04 23:02:21.520', 'Cancelada', 37.48),
(253, 1, '2025-10-09 23:02:21.523', '2025-11-09 23:02:21.523', NULL, 'Activa', 7.99),
(45, 17, '2025-04-05 23:02:21.523', '2025-05-05 23:02:21.523', '2025-05-04 23:02:21.523', 'Cancelada', 7.99),
(195, 32, '2025-10-13 23:02:21.527', '2025-11-13 23:02:21.527', NULL, 'Activa', 19.98),
(226, 41, '2025-07-18 23:02:21.530', '2025-08-18 23:02:21.530', NULL, 'Activa', 7.99),
(48, 52, '2025-10-29 23:02:21.530', '2025-11-29 23:02:21.530', '2026-03-29 23:02:21.530', 'Vencida', 19.98),
(65, 19, '2026-02-22 23:02:21.533', '2026-03-22 23:02:21.533', '2026-07-22 23:02:21.533', 'Vencida', 39.95),
(187, 22, '2025-08-20 23:02:21.537', '2025-09-20 23:02:21.537', '2025-09-13 23:02:21.537', 'Cancelada', 19.98),
(241, 5, '2025-09-25 23:02:21.537', '2025-10-25 23:02:21.537', NULL, 'Activa', 19.98),
(165, 25, '2025-06-01 23:02:21.540', '2025-07-01 23:02:21.540', '2025-07-12 23:02:21.540', 'Cancelada', 19.98),
(123, 27, '2025-08-12 23:02:21.543', '2025-09-12 23:02:21.543', NULL, 'Activa', 14.99),
(205, 41, '2025-11-19 23:02:21.543', '2025-12-19 23:02:21.543', '2025-11-27 23:02:21.543', 'Cancelada', 7.99),
(138, 37, '2025-05-13 23:02:21.547', '2025-06-13 23:02:21.547', '2025-06-30 23:02:21.547', 'Cancelada', 19.98),
(177, 36, '2025-06-03 23:02:21.550', '2025-07-03 23:02:21.550', '2025-07-06 23:02:21.550', 'Cancelada', 7.99),
(134, 20, '2025-03-02 23:02:21.550', '2025-04-02 23:02:21.550', '2025-03-15 23:02:21.550', 'Cancelada', 7.99),
(255, 40, '2025-03-27 23:02:21.553', '2025-04-27 23:02:21.553', '2025-05-25 23:02:21.553', 'Cancelada', 19.98),
(192, 59, '2025-12-23 23:02:21.553', '2026-01-23 23:02:21.553', '2026-01-23 23:02:21.553', 'Vencida', 37.48),
(153, 52, '2025-09-20 23:02:21.557', '2025-10-20 23:02:21.557', NULL, 'Activa', 19.98),
(27, 15, '2025-02-28 23:02:21.560', '2025-03-28 23:02:21.560', NULL, 'Activa', 39.95),
(210, 15, '2025-10-23 23:02:21.560', '2025-11-23 23:02:21.560', NULL, 'Activa', 39.95),
(125, 5, '2025-10-05 23:02:21.563', '2025-11-05 23:02:21.563', '2026-02-05 23:02:21.563', 'Vencida', 19.98),
(244, 41, '2025-05-09 23:02:21.563', '2025-06-09 23:02:21.563', '2025-05-09 23:02:21.563', 'Vencida', 7.99),
(242, 10, '2025-09-11 23:02:21.567', '2025-10-11 23:02:21.567', NULL, 'Activa', 7.99),
(226, 48, '2025-05-07 23:02:21.570', '2025-06-07 23:02:21.570', '2025-06-07 23:02:21.570', 'Cancelada', 19.98),
(103, 37, '2025-05-01 23:02:21.570', '2025-06-01 23:02:21.570', NULL, 'Activa', 19.98),
(213, 56, '2025-03-05 23:02:21.570', '2025-04-05 23:02:21.570', NULL, 'Activa', 19.98),
(94, 43, '2025-03-23 23:02:21.573', '2025-04-23 23:02:21.573', NULL, 'Activa', 39.95),
(163, 39, '2025-05-25 23:02:21.577', '2025-06-25 23:02:21.577', NULL, 'Activa', 7.99),
(211, 22, '2025-04-16 23:02:21.580', '2025-05-16 23:02:21.580', '2025-05-25 23:02:21.580', 'Cancelada', 19.98),
(170, 25, '2025-11-20 23:02:21.580', '2025-12-20 23:02:21.580', NULL, 'Activa', 19.98),
(74, 32, '2025-11-11 23:02:21.583', '2025-12-11 23:02:21.583', NULL, 'Activa', 19.98),
(246, 52, '2026-02-22 23:02:21.587', '2026-03-22 23:02:21.587', '2026-04-22 23:02:21.587', 'Vencida', 19.98),
(177, 19, '2025-03-23 23:02:21.587', '2025-04-23 23:02:21.587', '2025-04-23 23:02:21.587', 'Vencida', 39.95),
(242, 13, '2025-03-31 23:02:21.590', '2025-04-30 23:02:21.590', '2025-05-14 23:02:21.590', 'Cancelada', 7.99),
(204, 31, '2025-07-01 23:02:21.590', '2025-08-01 23:02:21.590', NULL, 'Activa', 7.99),
(67, 37, '2025-07-23 23:02:21.590', '2025-08-23 23:02:21.590', NULL, 'Activa', 19.98),
(52, 10, '2025-08-24 23:02:21.593', '2025-09-24 23:02:21.593', '2025-09-26 23:02:21.593', 'Cancelada', 7.99),
(100, 58, '2025-09-25 23:02:21.593', '2025-10-25 23:02:21.593', '2025-11-25 23:02:21.593', 'Vencida', 14.99),
(60, 30, '2025-12-22 23:02:21.597', '2026-01-22 23:02:21.597', '2026-05-22 23:02:21.597', 'Vencida', 7.99),
(160, 10, '2025-09-22 23:02:21.600', '2025-10-22 23:02:21.600', NULL, 'Activa', 7.99),
(53, 42, '2025-09-28 23:02:21.600', '2025-10-28 23:02:21.600', '2026-02-28 23:02:21.600', 'Vencida', 19.98),
(182, 17, '2025-11-08 23:02:21.603', '2025-12-08 23:02:21.603', NULL, 'Activa', 7.99),
(169, 29, '2025-09-26 23:02:21.607', '2025-10-26 23:02:21.607', NULL, 'Activa', 74.95),
(114, 34, '2025-12-22 23:02:21.607', '2026-01-22 23:02:21.607', NULL, 'Activa', 7.99),
(146, 28, '2025-10-18 23:02:21.610', '2025-11-18 23:02:21.610', '2026-02-18 23:02:21.610', 'Vencida', 37.48),
(118, 10, '2026-02-13 23:02:21.610', '2026-03-13 23:02:21.610', NULL, 'Activa', 7.99),
(122, 58, '2025-10-25 23:02:21.613', '2025-11-25 23:02:21.613', '2025-11-08 23:02:21.613', 'Cancelada', 14.99),
(239, 36, '2025-10-21 23:02:21.613', '2025-11-21 23:02:21.613', NULL, 'Activa', 7.99),
(117, 53, '2025-07-17 23:02:21.617', '2025-08-17 23:02:21.617', '2025-08-17 23:02:21.617', 'Cancelada', 7.99),
(210, 33, '2025-06-14 23:02:21.620', '2025-07-14 23:02:21.620', '2025-07-07 23:02:21.620', 'Cancelada', 39.95),
(226, 6, '2025-04-21 23:02:21.620', '2025-05-21 23:02:21.620', NULL, 'Activa', 39.95),
(168, 51, '2025-11-28 23:02:21.623', '2025-12-28 23:02:21.623', NULL, 'Activa', 7.99),
(213, 21, '2025-08-03 23:02:21.623', '2025-09-03 23:02:21.623', NULL, 'Activa', 7.99),
(201, 21, '2025-08-08 23:02:21.627', '2025-09-08 23:02:21.627', '2026-01-08 23:02:21.627', 'Vencida', 7.99),
(254, 54, '2025-05-14 23:02:21.630', '2025-06-14 23:02:21.630', NULL, 'Activa', 19.98),
(204, 33, '2025-10-06 23:02:21.630', '2025-11-06 23:02:21.630', '2025-11-27 23:02:21.630', 'Cancelada', 39.95),
(258, 35, '2025-11-12 23:02:21.633', '2025-12-12 23:02:21.633', NULL, 'Activa', 19.98),
(155, 57, '2026-01-11 23:02:21.633', '2026-02-11 23:02:21.633', NULL, 'Activa', 39.95),
(260, 37, '2025-06-22 23:02:21.637', '2025-07-22 23:02:21.637', NULL, 'Activa', 19.98),
(253, 18, '2026-01-25 23:02:21.640', '2026-02-25 23:02:21.640', '2026-02-27 23:02:21.640', 'Cancelada', 19.98),
(207, 13, '2025-08-06 23:02:21.643', '2025-09-06 23:02:21.643', NULL, 'Activa', 7.99),
(248, 36, '2026-02-03 23:02:21.647', '2026-03-03 23:02:21.647', '2026-02-14 23:02:21.647', 'Cancelada', 7.99),
(215, 16, '2025-06-11 23:02:21.647', '2025-07-11 23:02:21.647', NULL, 'Activa', 7.99),
(74, 26, '2025-08-18 23:02:21.650', '2025-09-18 23:02:21.650', '2025-10-05 23:02:21.650', 'Cancelada', 39.95),
(181, 17, '2025-07-06 23:02:21.650', '2025-08-06 23:02:21.650', NULL, 'Activa', 7.99),
(38, 12, '2026-01-01 23:02:21.653', '2026-02-01 23:02:21.653', NULL, 'Activa', 19.98),
(62, 38, '2025-08-02 23:02:21.653', '2025-09-02 23:02:21.653', NULL, 'Activa', 39.95),
(92, 54, '2025-04-06 23:02:21.657', '2025-05-06 23:02:21.657', NULL, 'Activa', 19.98),
(222, 47, '2025-03-24 23:02:21.660', '2025-04-24 23:02:21.660', NULL, 'Activa', 7.99),
(110, 23, '2025-03-13 23:02:21.660', '2025-04-13 23:02:21.660', NULL, 'Activa', 39.95),
(228, 20, '2026-01-26 23:02:21.663', '2026-02-26 23:02:21.663', NULL, 'Activa', 7.99),
(260, 54, '2025-11-04 23:02:21.667', '2025-12-04 23:02:21.667', '2026-03-04 23:02:21.667', 'Vencida', 19.98),
(157, 51, '2025-05-15 23:02:21.667', '2025-06-15 23:02:21.667', NULL, 'Activa', 7.99),
(150, 49, '2025-05-25 23:02:21.670', '2025-06-25 23:02:21.670', NULL, 'Activa', 7.99),
(243, 17, '2026-01-11 23:02:21.670', '2026-02-11 23:02:21.670', NULL, 'Activa', 7.99),
(208, 10, '2025-11-22 23:02:21.673', '2025-12-22 23:02:21.673', NULL, 'Activa', 7.99),
(186, 48, '2025-06-04 23:02:21.677', '2025-07-04 23:02:21.677', '2025-06-04 23:02:21.677', 'Cancelada', 19.98),
(102, 20, '2025-08-24 23:02:21.677', '2025-09-24 23:02:21.677', '2025-08-24 23:02:21.677', 'Cancelada', 7.99),
(80, 51, '2025-09-01 23:02:21.680', '2025-10-01 23:02:21.680', NULL, 'Activa', 7.99),
(165, 54, '2025-07-26 23:02:21.680', '2025-08-26 23:02:21.680', NULL, 'Activa', 19.98),
(107, 1, '2025-08-28 23:02:21.683', '2025-09-28 23:02:21.683', NULL, 'Activa', 7.99),
(216, 48, '2025-06-28 23:02:21.687', '2025-07-28 23:02:21.687', NULL, 'Activa', 19.98),
(128, 22, '2025-07-07 23:02:21.690', '2025-08-07 23:02:21.690', '2025-08-17 23:02:21.690', 'Cancelada', 19.98),
(195, 23, '2025-10-19 23:02:21.690', '2025-11-19 23:02:21.690', NULL, 'Activa', 39.95),
(198, 3, '2026-01-28 23:02:21.703', '2026-02-28 23:02:21.703', '2026-03-28 23:02:21.703', 'Vencida', 19.98),
(144, 29, '2025-08-02 23:02:21.703', '2025-09-02 23:02:21.703', '2025-08-19 23:02:21.703', 'Cancelada', 74.95),
(171, 7, '2025-09-04 23:02:21.707', '2025-10-04 23:02:21.707', NULL, 'Activa', 7.99),
(222, 17, '2025-11-21 23:02:21.710', '2025-12-21 23:02:21.710', NULL, 'Activa', 7.99),
(70, 5, '2025-03-02 23:02:21.710', '2025-04-02 23:02:21.710', '2025-03-18 23:02:21.710', 'Cancelada', 19.98),
(222, 46, '2025-05-26 23:02:21.713', '2025-06-26 23:02:21.713', '2025-06-02 23:02:21.713', 'Cancelada', 39.95),
(216, 11, '2025-10-30 23:02:21.713', '2025-11-30 23:02:21.713', '2025-11-25 23:02:21.713', 'Cancelada', 7.99),
(158, 24, '2025-10-05 23:02:21.717', '2025-11-05 23:02:21.717', NULL, 'Activa', 7.99),
(147, 1, '2025-11-04 23:02:21.717', '2025-12-04 23:02:21.717', '2025-11-28 23:02:21.717', 'Cancelada', 7.99),
(229, 34, '2025-08-28 23:02:21.720', '2025-09-28 23:02:21.720', NULL, 'Activa', 7.99),
(226, 3, '2026-02-10 23:02:21.720', '2026-03-10 23:02:21.720', NULL, 'Activa', 19.98),
(86, 28, '2025-04-24 23:02:21.723', '2025-05-24 23:02:21.723', '2025-05-24 23:02:21.723', 'Vencida', 37.48),
(250, 57, '2025-09-14 23:02:21.727', '2025-10-14 23:02:21.727', '2025-10-01 23:02:21.727', 'Cancelada', 39.95),
(158, 1, '2025-11-19 23:02:21.730', '2025-12-19 23:02:21.730', NULL, 'Activa', 7.99),
(162, 12, '2025-08-14 23:02:21.730', '2025-09-14 23:02:21.730', NULL, 'Activa', 19.98),
(119, 57, '2026-01-03 23:02:21.733', '2026-02-03 23:02:21.733', '2026-01-26 23:02:21.733', 'Cancelada', 39.95),
(215, 20, '2025-04-05 23:02:21.737', '2025-05-05 23:02:21.737', NULL, 'Activa', 7.99),
(47, 42, '2026-02-08 23:02:21.740', '2026-03-08 23:02:21.740', NULL, 'Activa', 19.98),
(124, 52, '2025-09-20 23:02:21.743', '2025-10-20 23:02:21.743', NULL, 'Activa', 19.98),
(44, 41, '2025-06-15 23:02:21.750', '2025-07-15 23:02:21.750', NULL, 'Activa', 7.99),
(244, 57, '2025-07-16 23:02:21.750', '2025-08-16 23:02:21.750', NULL, 'Activa', 39.95),
(248, 12, '2025-08-02 23:02:21.753', '2025-09-02 23:02:21.753', '2025-09-09 23:02:21.753', 'Cancelada', 19.98),
(98, 18, '2026-02-22 23:02:21.753', '2026-03-22 23:02:21.753', '2026-04-13 23:02:21.753', 'Cancelada', 19.98),
(90, 15, '2025-09-15 23:02:21.757', '2025-10-15 23:02:21.757', '2025-09-18 23:02:21.757', 'Cancelada', 39.95),
(213, 53, '2025-08-31 23:02:21.760', '2025-09-30 23:02:21.760', NULL, 'Activa', 7.99),
(82, 40, '2025-06-01 23:02:21.763', '2025-07-01 23:02:21.763', NULL, 'Activa', 19.98),
(186, 18, '2025-07-18 23:02:21.767', '2025-08-18 23:02:21.767', NULL, 'Activa', 19.98),
(61, 55, '2025-11-29 23:02:21.770', '2025-12-29 23:02:21.770', '2025-12-17 23:02:21.770', 'Cancelada', 7.99),
(71, 13, '2025-05-25 23:02:21.770', '2025-06-25 23:02:21.770', '2025-06-11 23:02:21.770', 'Cancelada', 7.99),
(148, 52, '2025-09-05 23:02:21.773', '2025-10-05 23:02:21.773', NULL, 'Activa', 19.98),
(174, 25, '2025-05-12 23:02:21.777', '2025-06-12 23:02:21.777', NULL, 'Activa', 19.98),
(98, 33, '2025-06-22 23:02:21.777', '2025-07-22 23:02:21.777', NULL, 'Activa', 39.95),
(107, 42, '2025-11-06 23:02:21.780', '2025-12-06 23:02:21.780', NULL, 'Activa', 19.98),
(229, 54, '2025-03-05 23:02:21.783', '2025-04-05 23:02:21.783', NULL, 'Activa', 19.98),
(200, 12, '2025-05-26 23:02:21.783', '2025-06-26 23:02:21.783', '2025-06-14 23:02:21.783', 'Cancelada', 19.98),
(66, 1, '2025-12-28 23:02:21.787', '2026-01-28 23:02:21.787', '2026-04-28 23:02:21.787', 'Vencida', 7.99),
(181, 52, '2025-06-29 23:02:21.790', '2025-07-29 23:02:21.790', NULL, 'Activa', 19.98),
(173, 32, '2025-12-05 23:02:21.793', '2026-01-05 23:02:21.793', NULL, 'Activa', 19.98),
(214, 18, '2026-02-04 23:02:21.797', '2026-03-04 23:02:21.797', '2026-02-16 23:02:21.797', 'Cancelada', 19.98),
(219, 1, '2025-07-14 23:02:21.797', '2025-08-14 23:02:21.797', NULL, 'Activa', 7.99),
(124, 59, '2025-07-14 23:02:21.800', '2025-08-14 23:02:21.800', NULL, 'Activa', 37.48),
(41, 25, '2025-05-15 23:02:21.803', '2025-06-15 23:02:21.803', NULL, 'Activa', 19.98),
(94, 32, '2025-09-21 23:02:21.807', '2025-10-21 23:02:21.807', NULL, 'Activa', 19.98),
(257, 28, '2025-04-02 23:02:21.807', '2025-05-02 23:02:21.807', '2025-05-03 23:02:21.807', 'Cancelada', 37.48),
(172, 31, '2025-12-08 23:02:21.810', '2026-01-08 23:02:21.810', NULL, 'Activa', 7.99),
(122, 11, '2025-04-28 23:02:21.810', '2025-05-28 23:02:21.810', NULL, 'Activa', 7.99),
(92, 28, '2025-03-23 23:02:21.817', '2025-04-23 23:02:21.817', '2025-06-23 23:02:21.817', 'Vencida', 37.48),
(55, 6, '2025-07-16 23:02:21.817', '2025-08-16 23:02:21.817', '2025-09-07 23:02:21.817', 'Cancelada', 39.95),
(42, 46, '2025-07-26 23:02:21.823', '2025-08-26 23:02:21.823', NULL, 'Activa', 39.95),
(73, 15, '2025-08-25 23:02:21.827', '2025-09-25 23:02:21.827', NULL, 'Activa', 39.95),
(42, 27, '2025-06-26 23:02:21.830', '2025-07-26 23:02:21.830', '2025-06-28 23:02:21.830', 'Cancelada', 14.99),
(204, 15, '2025-12-21 23:02:21.830', '2026-01-21 23:02:21.830', NULL, 'Activa', 39.95),
(141, 19, '2025-09-04 23:02:21.833', '2025-10-04 23:02:21.833', '2026-01-04 23:02:21.833', 'Vencida', 39.95),
(178, 48, '2025-05-03 23:02:21.837', '2025-06-03 23:02:21.837', NULL, 'Activa', 19.98),
(51, 21, '2025-12-08 23:02:21.837', '2026-01-08 23:02:21.837', NULL, 'Activa', 7.99),
(223, 9, '2025-05-06 23:02:21.840', '2025-06-06 23:02:21.840', NULL, 'Activa', 39.95),
(176, 45, '2025-09-05 23:02:21.840', '2025-10-05 23:02:21.840', '2025-11-03 23:02:21.840', 'Cancelada', 19.98),
(53, 25, '2025-05-27 23:02:21.843', '2025-06-27 23:02:21.843', NULL, 'Activa', 19.98),
(102, 23, '2025-05-14 23:02:21.843', '2025-06-14 23:02:21.843', '2025-06-26 23:02:21.843', 'Cancelada', 39.95),
(163, 31, '2025-07-24 23:02:21.847', '2025-08-24 23:02:21.847', NULL, 'Activa', 7.99),
(200, 38, '2025-03-04 23:02:21.850', '2025-04-04 23:02:21.850', NULL, 'Activa', 39.95),
(232, 18, '2025-10-16 23:02:21.850', '2025-11-16 23:02:21.850', NULL, 'Activa', 19.98),
(210, 24, '2025-10-16 23:02:21.853', '2025-11-16 23:02:21.853', NULL, 'Activa', 7.99),
(212, 25, '2025-06-23 23:02:21.853', '2025-07-23 23:02:21.853', NULL, 'Activa', 19.98),
(31, 19, '2025-10-26 23:02:21.857', '2025-11-26 23:02:21.857', NULL, 'Activa', 39.95),
(58, 18, '2025-04-07 23:02:21.860', '2025-05-07 23:02:21.860', NULL, 'Activa', 19.98),
(191, 43, '2025-10-18 23:02:21.863', '2025-11-18 23:02:21.863', '2025-12-12 23:02:21.863', 'Cancelada', 39.95),
(72, 46, '2025-12-31 23:02:21.863', '2026-01-31 23:02:21.863', '2026-02-02 23:02:21.863', 'Cancelada', 39.95),
(219, 50, '2026-01-06 23:02:21.867', '2026-02-06 23:02:21.867', NULL, 'Activa', 19.98),
(144, 7, '2025-07-08 23:02:21.870', '2025-08-08 23:02:21.870', NULL, 'Activa', 7.99),
(260, 5, '2025-06-02 23:02:21.870', '2025-07-02 23:02:21.870', NULL, 'Activa', 19.98),
(165, 12, '2025-04-21 23:02:21.873', '2025-05-21 23:02:21.873', '2025-04-29 23:02:21.873', 'Cancelada', 19.98),
(46, 44, '2025-08-02 23:02:21.873', '2025-09-02 23:02:21.873', '2025-08-05 23:02:21.873', 'Cancelada', 7.99),
(76, 25, '2025-10-27 23:02:21.877', '2025-11-27 23:02:21.877', NULL, 'Activa', 19.98),
(254, 26, '2025-06-05 23:02:21.880', '2025-07-05 23:02:21.880', '2025-07-14 23:02:21.880', 'Cancelada', 39.95),
(178, 44, '2025-06-09 23:02:21.880', '2025-07-09 23:02:21.880', '2025-07-01 23:02:21.880', 'Cancelada', 7.99),
(189, 49, '2026-02-12 23:02:21.883', '2026-03-12 23:02:21.883', NULL, 'Activa', 7.99),
(55, 29, '2025-04-18 23:02:21.883', '2025-05-18 23:02:21.883', '2025-08-18 23:02:21.883', 'Vencida', 74.95),
(196, 35, '2026-01-29 23:02:21.887', '2026-02-28 23:02:21.887', '2026-02-07 23:02:21.887', 'Cancelada', 19.98),
(83, 8, '2025-06-12 23:02:21.887', '2025-07-12 23:02:21.887', NULL, 'Activa', 19.98),
(135, 21, '2025-04-12 23:02:21.890', '2025-05-12 23:02:21.890', '2025-05-22 23:02:21.890', 'Cancelada', 7.99),
(87, 53, '2026-02-17 23:02:21.890', '2026-03-17 23:02:21.890', NULL, 'Activa', 7.99),
(132, 8, '2025-05-05 23:02:21.893', '2025-06-05 23:02:21.893', NULL, 'Activa', 19.98),
(120, 42, '2026-01-14 23:02:21.897', '2026-02-14 23:02:21.897', '2026-02-26 23:02:21.897', 'Cancelada', 19.98),
(249, 32, '2025-06-06 23:02:21.897', '2025-07-06 23:02:21.897', NULL, 'Activa', 19.98),
(223, 41, '2025-08-03 23:02:21.900', '2025-09-03 23:02:21.900', '2025-09-30 23:02:21.900', 'Cancelada', 7.99),
(217, 25, '2025-11-08 23:02:21.900', '2025-12-08 23:02:21.900', NULL, 'Activa', 19.98),
(179, 27, '2025-03-13 23:02:21.903', '2025-04-13 23:02:21.903', NULL, 'Activa', 14.99),
(183, 3, '2025-09-24 23:02:21.903', '2025-10-24 23:02:21.903', NULL, 'Activa', 19.98),
(101, 34, '2026-01-24 23:02:21.907', '2026-02-24 23:02:21.907', '2026-03-13 23:02:21.907', 'Cancelada', 7.99),
(167, 49, '2025-05-24 23:02:21.907', '2025-06-24 23:02:21.907', NULL, 'Activa', 7.99),
(252, 30, '2025-09-07 23:02:21.910', '2025-10-07 23:02:21.910', '2025-09-07 23:02:21.910', 'Vencida', 7.99),
(237, 13, '2025-11-27 23:02:21.910', '2025-12-27 23:02:21.910', '2025-12-27 23:02:21.910', 'Vencida', 7.99),
(107, 57, '2025-08-07 23:02:21.913', '2025-09-07 23:02:21.913', NULL, 'Activa', 39.95),
(45, 34, '2025-05-05 23:02:21.920', '2025-06-05 23:02:21.920', NULL, 'Activa', 7.99),
(260, 6, '2025-10-14 23:02:21.923', '2025-11-14 23:02:21.923', NULL, 'Activa', 39.95),
(88, 25, '2025-05-19 23:02:21.927', '2025-06-19 23:02:21.927', NULL, 'Activa', 19.98),
(240, 26, '2025-06-11 23:02:21.927', '2025-07-11 23:02:21.927', '2025-06-18 23:02:21.927', 'Cancelada', 39.95),
(69, 7, '2025-07-03 23:02:21.930', '2025-08-03 23:02:21.930', '2025-07-05 23:02:21.930', 'Cancelada', 7.99),
(205, 14, '2026-01-10 23:02:21.930', '2026-02-10 23:02:21.930', NULL, 'Activa', 19.98),
(30, 58, '2025-08-17 23:02:21.933', '2025-09-17 23:02:21.933', NULL, 'Activa', 14.99),
(114, 23, '2025-10-08 23:02:21.937', '2025-11-08 23:02:21.937', NULL, 'Activa', 39.95),
(171, 36, '2025-11-27 23:02:21.940', '2025-12-27 23:02:21.940', '2026-01-18 23:02:21.940', 'Cancelada', 7.99),
(202, 11, '2025-10-31 23:02:21.940', '2025-11-30 23:02:21.940', NULL, 'Activa', 7.99),
(45, 5, '2025-11-30 23:02:21.943', '2025-12-30 23:02:21.943', NULL, 'Activa', 19.98),
(133, 30, '2025-03-04 23:02:21.943', '2025-04-04 23:02:21.943', '2025-03-19 23:02:21.943', 'Cancelada', 7.99),
(194, 46, '2025-09-18 23:02:21.947', '2025-10-18 23:02:21.947', NULL, 'Activa', 39.95),
(179, 21, '2026-02-04 23:02:21.950', '2026-03-04 23:02:21.950', NULL, 'Activa', 7.99),
(102, 4, '2025-03-08 23:02:21.950', '2025-04-08 23:02:21.950', NULL, 'Activa', 7.99),
(74, 49, '2025-12-22 23:02:21.953', '2026-01-22 23:02:21.953', NULL, 'Activa', 7.99),
(65, 20, '2025-03-16 23:02:21.953', '2025-04-16 23:02:21.953', '2025-03-21 23:02:21.953', 'Cancelada', 7.99),
(103, 40, '2026-01-30 23:02:21.957', '2026-02-28 23:02:21.957', '2026-03-15 23:02:21.957', 'Cancelada', 19.98),
(225, 33, '2026-02-05 23:02:21.960', '2026-03-05 23:02:21.960', NULL, 'Activa', 39.95),
(227, 20, '2025-05-23 23:02:21.960', '2025-06-23 23:02:21.960', NULL, 'Activa', 7.99),
(80, 58, '2026-01-23 23:02:21.963', '2026-02-23 23:02:21.963', '2026-05-23 23:02:21.963', 'Vencida', 14.99),
(235, 28, '2025-04-19 23:02:21.963', '2025-05-19 23:02:21.963', '2025-04-22 23:02:21.963', 'Cancelada', 37.48),
(215, 12, '2025-06-23 23:02:21.967', '2025-07-23 23:02:21.967', '2025-07-04 23:02:21.967', 'Cancelada', 19.98),
(75, 29, '2025-11-20 23:02:21.970', '2025-12-20 23:02:21.970', NULL, 'Activa', 74.95),
(113, 4, '2025-06-10 23:02:21.970', '2025-07-10 23:02:21.970', NULL, 'Activa', 7.99),
(94, 21, '2026-02-21 23:02:21.973', '2026-03-21 23:02:21.973', NULL, 'Activa', 7.99),
(176, 57, '2025-09-06 23:02:21.973', '2025-10-06 23:02:21.973', '2025-09-21 23:02:21.973', 'Cancelada', 39.95),
(155, 36, '2025-03-31 23:02:21.977', '2025-04-30 23:02:21.977', '2025-05-31 23:02:21.977', 'Vencida', 7.99),
(255, 4, '2025-04-20 23:02:21.980', '2025-05-20 23:02:21.980', NULL, 'Activa', 7.99),
(94, 44, '2025-11-06 23:02:21.980', '2025-12-06 23:02:21.980', '2025-12-25 23:02:21.980', 'Cancelada', 7.99),
(210, 55, '2025-04-19 23:02:21.983', '2025-05-19 23:02:21.983', NULL, 'Activa', 7.99),
(30, 36, '2025-05-24 23:02:21.983', '2025-06-24 23:02:21.983', NULL, 'Activa', 7.99),
(55, 14, '2025-10-18 23:02:21.987', '2025-11-18 23:02:21.987', '2025-10-26 23:02:21.987', 'Cancelada', 19.98),
(244, 31, '2025-03-12 23:02:21.990', '2025-04-12 23:02:21.990', NULL, 'Activa', 7.99),
(210, 21, '2025-05-27 23:02:21.990', '2025-06-27 23:02:21.990', NULL, 'Activa', 7.99),
(212, 8, '2025-09-01 23:02:21.993', '2025-10-01 23:02:21.993', '2026-02-01 23:02:21.993', 'Vencida', 19.98),
(144, 29, '2025-09-12 23:02:21.993', '2025-10-12 23:02:21.993', '2025-09-12 23:02:21.993', 'Vencida', 74.95),
(106, 13, '2025-11-03 23:02:21.997', '2025-12-03 23:02:21.997', '2026-04-03 23:02:21.997', 'Vencida', 7.99),
(47, 21, '2025-09-26 23:02:22.000', '2025-10-26 23:02:22.000', '2025-12-26 23:02:22.000', 'Vencida', 7.99),
(223, 48, '2025-03-25 23:02:22.000', '2025-04-25 23:02:22.000', '2025-04-19 23:02:22.000', 'Cancelada', 19.98),
(116, 5, '2025-04-21 23:02:22.000', '2025-05-21 23:02:22.000', '2025-06-13 23:02:22.000', 'Cancelada', 19.98),
(166, 55, '2025-06-17 23:02:22.003', '2025-07-17 23:02:22.003', NULL, 'Activa', 7.99),
(231, 44, '2025-11-02 23:02:22.007', '2025-12-02 23:02:22.007', '2025-11-05 23:02:22.007', 'Cancelada', 7.99),
(230, 52, '2025-12-31 23:02:22.007', '2026-01-31 23:02:22.007', '2026-02-07 23:02:22.007', 'Cancelada', 19.98),
(140, 46, '2025-12-27 23:02:22.010', '2026-01-27 23:02:22.010', NULL, 'Activa', 39.95),
(197, 40, '2025-06-08 23:02:22.010', '2025-07-08 23:02:22.010', NULL, 'Activa', 19.98),
(103, 54, '2026-01-02 23:02:22.013', '2026-02-02 23:02:22.013', NULL, 'Activa', 19.98),
(177, 29, '2025-09-15 23:02:22.013', '2025-10-15 23:02:22.013', '2025-12-15 23:02:22.013', 'Vencida', 74.95),
(87, 15, '2025-06-21 23:02:22.017', '2025-07-21 23:02:22.017', '2025-07-22 23:02:22.017', 'Cancelada', 39.95),
(104, 18, '2025-09-19 23:02:22.020', '2025-10-19 23:02:22.020', NULL, 'Activa', 19.98),
(137, 47, '2025-12-10 23:02:22.020', '2026-01-10 23:02:22.020', NULL, 'Activa', 7.99),
(181, 56, '2025-07-10 23:02:22.023', '2025-08-10 23:02:22.023', '2025-07-21 23:02:22.023', 'Cancelada', 19.98),
(105, 56, '2025-08-20 23:02:22.027', '2025-09-20 23:02:22.027', '2025-09-20 23:02:22.027', 'Vencida', 19.98),
(127, 24, '2025-08-17 23:02:22.030', '2025-09-17 23:02:22.030', NULL, 'Activa', 7.99),
(49, 38, '2025-05-12 23:02:22.030', '2025-06-12 23:02:22.030', '2025-07-08 23:02:22.030', 'Cancelada', 39.95),
(242, 35, '2025-05-30 23:02:22.033', '2025-06-30 23:02:22.033', '2025-09-30 23:02:22.033', 'Vencida', 19.98),
(41, 46, '2025-11-05 23:02:22.033', '2025-12-05 23:02:22.033', NULL, 'Activa', 39.95),
(252, 24, '2025-11-15 23:02:22.037', '2025-12-15 23:02:22.037', NULL, 'Activa', 7.99),
(200, 4, '2025-11-14 23:02:22.040', '2025-12-14 23:02:22.040', NULL, 'Activa', 7.99),
(69, 33, '2025-06-06 23:02:22.040', '2025-07-06 23:02:22.040', '2025-06-26 23:02:22.040', 'Cancelada', 39.95),
(56, 51, '2025-04-06 23:02:22.040', '2025-05-06 23:02:22.040', '2025-05-09 23:02:22.040', 'Cancelada', 7.99),
(93, 42, '2025-04-14 23:02:22.043', '2025-05-14 23:02:22.043', '2025-04-17 23:02:22.043', 'Cancelada', 19.98),
(260, 5, '2025-03-26 23:02:22.047', '2025-04-26 23:02:22.047', NULL, 'Activa', 19.98),
(100, 7, '2025-12-16 23:02:22.050', '2026-01-16 23:02:22.050', NULL, 'Activa', 7.99),
(223, 37, '2025-04-03 23:02:22.050', '2025-05-03 23:02:22.050', NULL, 'Activa', 19.98),
(234, 8, '2025-06-12 23:02:22.053', '2025-07-12 23:02:22.053', '2025-06-16 23:02:22.053', 'Cancelada', 19.98),
(236, 4, '2025-09-15 23:02:22.053', '2025-10-15 23:02:22.053', '2025-10-24 23:02:22.053', 'Cancelada', 7.99),
(160, 23, '2025-06-07 23:02:22.057', '2025-07-07 23:02:22.057', NULL, 'Activa', 39.95),
(148, 48, '2025-03-25 23:02:22.057', '2025-04-25 23:02:22.057', '2025-04-26 23:02:22.057', 'Cancelada', 19.98),
(235, 11, '2026-02-13 23:02:22.060', '2026-03-13 23:02:22.060', '2026-03-01 23:02:22.060', 'Cancelada', 7.99),
(66, 8, '2026-02-21 23:02:22.060', '2026-03-21 23:02:22.060', NULL, 'Activa', 19.98),
(45, 5, '2025-11-12 23:02:22.063', '2025-12-12 23:02:22.063', NULL, 'Activa', 19.98),
(177, 52, '2025-04-28 23:02:22.067', '2025-05-28 23:02:22.067', '2025-06-13 23:02:22.067', 'Cancelada', 19.98),
(234, 3, '2025-09-26 23:02:22.070', '2025-10-26 23:02:22.070', '2025-10-29 23:02:22.070', 'Cancelada', 19.98),
(141, 46, '2025-09-17 23:02:22.070', '2025-10-17 23:02:22.070', '2025-10-31 23:02:22.070', 'Cancelada', 39.95),
(205, 20, '2025-12-15 23:02:22.073', '2026-01-15 23:02:22.073', NULL, 'Activa', 7.99),
(97, 45, '2025-04-20 23:02:22.073', '2025-05-20 23:02:22.073', NULL, 'Activa', 19.98),
(77, 47, '2025-04-22 23:02:22.077', '2025-05-22 23:02:22.077', NULL, 'Activa', 7.99),
(72, 53, '2025-07-09 23:02:22.077', '2025-08-09 23:02:22.077', NULL, 'Activa', 7.99),
(53, 24, '2025-09-09 23:02:22.080', '2025-10-09 23:02:22.080', '2025-09-11 23:02:22.080', 'Cancelada', 7.99),
(162, 23, '2025-09-21 23:02:22.080', '2025-10-21 23:02:22.080', '2025-11-13 23:02:22.080', 'Cancelada', 39.95),
(193, 4, '2025-08-23 23:02:22.083', '2025-09-23 23:02:22.083', NULL, 'Activa', 7.99),
(64, 7, '2025-05-19 23:02:22.087', '2025-06-19 23:02:22.087', '2025-06-19 23:02:22.087', 'Cancelada', 7.99),
(250, 3, '2025-08-03 23:02:22.090', '2025-09-03 23:02:22.090', NULL, 'Activa', 19.98),
(177, 13, '2025-11-04 23:02:22.090', '2025-12-04 23:02:22.090', '2025-12-09 23:02:22.090', 'Cancelada', 7.99),
(100, 17, '2025-04-12 23:02:22.093', '2025-05-12 23:02:22.093', NULL, 'Activa', 7.99),
(77, 35, '2025-08-26 23:02:22.093', '2025-09-26 23:02:22.093', NULL, 'Activa', 19.98),
(187, 23, '2025-11-10 23:02:22.097', '2025-12-10 23:02:22.097', NULL, 'Activa', 39.95),
(94, 44, '2025-12-27 23:02:22.100', '2026-01-27 23:02:22.100', NULL, 'Activa', 7.99),
(222, 7, '2025-06-09 23:02:22.103', '2025-07-09 23:02:22.103', NULL, 'Activa', 7.99),
(148, 43, '2025-03-14 23:02:22.107', '2025-04-14 23:02:22.107', NULL, 'Activa', 39.95),
(111, 50, '2025-04-13 23:02:22.107', '2025-05-13 23:02:22.107', NULL, 'Activa', 19.98),
(107, 49, '2025-05-12 23:02:22.110', '2025-06-12 23:02:22.110', '2025-06-12 23:02:22.110', 'Vencida', 7.99),
(102, 44, '2025-08-30 23:02:22.110', '2025-09-30 23:02:22.110', '2025-09-19 23:02:22.110', 'Cancelada', 7.99),
(141, 10, '2025-11-17 23:02:22.113', '2025-12-17 23:02:22.113', '2026-01-01 23:02:22.113', 'Cancelada', 7.99),
(147, 19, '2026-01-17 23:02:22.117', '2026-02-17 23:02:22.117', NULL, 'Activa', 39.95),
(147, 22, '2025-03-04 23:02:22.117', '2025-04-04 23:02:22.117', '2025-03-10 23:02:22.117', 'Cancelada', 19.98),
(49, 52, '2025-09-28 23:02:22.120', '2025-10-28 23:02:22.120', NULL, 'Activa', 19.98),
(33, 45, '2025-12-20 23:02:22.127', '2026-01-20 23:02:22.127', NULL, 'Activa', 19.98),
(159, 58, '2025-11-19 23:02:22.130', '2025-12-19 23:02:22.130', NULL, 'Activa', 14.99),
(211, 26, '2025-05-01 23:02:22.130', '2025-06-01 23:02:22.130', '2025-05-01 23:02:22.130', 'Vencida', 39.95),
(47, 54, '2026-02-05 23:02:22.133', '2026-03-05 23:02:22.133', NULL, 'Activa', 19.98),
(97, 54, '2026-01-25 23:02:22.137', '2026-02-25 23:02:22.137', '2026-02-28 23:02:22.137', 'Cancelada', 19.98),
(61, 11, '2025-05-18 23:02:22.140', '2025-06-18 23:02:22.140', NULL, 'Activa', 7.99),
(116, 19, '2025-04-12 23:02:22.143', '2025-05-12 23:02:22.143', NULL, 'Activa', 39.95),
(53, 7, '2025-09-29 23:02:22.143', '2025-10-29 23:02:22.143', NULL, 'Activa', 7.99),
(226, 19, '2025-06-10 23:02:22.147', '2025-07-10 23:02:22.147', NULL, 'Activa', 39.95),
(150, 34, '2025-03-17 23:02:22.150', '2025-04-17 23:02:22.150', NULL, 'Activa', 7.99),
(94, 53, '2025-12-13 23:02:22.157', '2026-01-13 23:02:22.157', NULL, 'Activa', 7.99),
(55, 24, '2025-08-01 23:02:22.160', '2025-09-01 23:02:22.160', '2025-09-16 23:02:22.160', 'Cancelada', 7.99),
(122, 3, '2025-09-21 23:02:22.160', '2025-10-21 23:02:22.160', NULL, 'Activa', 19.98),
(52, 53, '2025-11-19 23:02:22.163', '2025-12-19 23:02:22.163', NULL, 'Activa', 7.99),
(199, 9, '2025-07-15 23:02:22.167', '2025-08-15 23:02:22.167', NULL, 'Activa', 39.95),
(49, 14, '2025-10-03 23:02:22.167', '2025-11-03 23:02:22.167', '2025-11-10 23:02:22.167', 'Cancelada', 19.98),
(244, 29, '2025-05-20 23:02:22.170', '2025-06-20 23:02:22.170', NULL, 'Activa', 74.95),
(79, 32, '2025-06-16 23:02:22.170', '2025-07-16 23:02:22.170', '2025-08-01 23:02:22.170', 'Cancelada', 19.98),
(27, 52, '2025-06-03 23:02:22.173', '2025-07-03 23:02:22.173', '2025-07-19 23:02:22.173', 'Cancelada', 19.98),
(255, 26, '2025-12-18 23:02:22.177', '2026-01-18 23:02:22.177', '2026-01-02 23:02:22.177', 'Cancelada', 39.95),
(65, 9, '2025-04-18 23:02:22.177', '2025-05-18 23:02:22.177', '2025-04-21 23:02:22.177', 'Cancelada', 39.95),
(207, 34, '2025-05-12 23:02:22.180', '2025-06-12 23:02:22.180', '2025-06-19 23:02:22.180', 'Cancelada', 7.99),
(156, 14, '2025-06-25 23:02:22.180', '2025-07-25 23:02:22.180', '2025-06-27 23:02:22.180', 'Cancelada', 19.98),
(200, 43, '2025-05-07 23:02:22.183', '2025-06-07 23:02:22.183', '2025-05-26 23:02:22.183', 'Cancelada', 39.95),
(201, 16, '2025-06-24 23:02:22.187', '2025-07-24 23:02:22.187', '2025-06-25 23:02:22.187', 'Cancelada', 7.99),
(165, 52, '2025-11-08 23:02:22.187', '2025-12-08 23:02:22.187', NULL, 'Activa', 19.98),
(33, 52, '2025-08-16 23:02:22.190', '2025-09-16 23:02:22.190', NULL, 'Activa', 19.98),
(208, 20, '2025-09-07 23:02:22.190', '2025-10-07 23:02:22.190', NULL, 'Activa', 7.99),
(183, 56, '2025-04-29 23:02:22.193', '2025-05-29 23:02:22.193', '2025-06-01 23:02:22.193', 'Cancelada', 19.98),
(196, 23, '2026-02-11 23:02:22.193', '2026-03-11 23:02:22.193', '2026-02-26 23:02:22.193', 'Cancelada', 39.95),
(212, 53, '2025-09-23 23:02:22.197', '2025-10-23 23:02:22.197', NULL, 'Activa', 7.99),
(56, 18, '2025-12-11 23:02:22.200', '2026-01-11 23:02:22.200', NULL, 'Activa', 19.98),
(90, 20, '2026-02-17 23:02:22.200', '2026-03-17 23:02:22.200', '2026-07-17 23:02:22.200', 'Vencida', 7.99),
(157, 16, '2025-06-20 23:02:22.203', '2025-07-20 23:02:22.203', NULL, 'Activa', 7.99),
(162, 42, '2025-08-16 23:02:22.203', '2025-09-16 23:02:22.203', '2025-10-16 23:02:22.203', 'Vencida', 19.98),
(78, 37, '2025-12-07 23:02:22.207', '2026-01-07 23:02:22.207', NULL, 'Activa', 19.98),
(47, 39, '2025-11-20 23:02:22.207', '2025-12-20 23:02:22.207', NULL, 'Activa', 7.99),
(256, 45, '2025-12-30 23:02:22.210', '2026-01-30 23:02:22.210', NULL, 'Activa', 19.98),
(53, 32, '2026-02-09 23:02:22.210', '2026-03-09 23:02:22.210', '2026-03-23 23:02:22.210', 'Cancelada', 19.98),
(215, 52, '2025-06-20 23:02:22.213', '2025-07-20 23:02:22.213', NULL, 'Activa', 19.98),
(229, 58, '2025-09-20 23:02:22.217', '2025-10-20 23:02:22.217', NULL, 'Activa', 14.99),
(105, 17, '2025-07-25 23:02:22.217', '2025-08-25 23:02:22.217', NULL, 'Activa', 7.99),
(137, 58, '2025-05-12 23:02:22.220', '2025-06-12 23:02:22.220', NULL, 'Activa', 14.99),
(260, 6, '2025-06-03 23:02:22.220', '2025-07-03 23:02:22.220', '2025-07-31 23:02:22.220', 'Cancelada', 39.95),
(151, 54, '2026-01-15 23:02:22.223', '2026-02-15 23:02:22.223', NULL, 'Activa', 19.98),
(88, 27, '2025-09-20 23:02:22.227', '2025-10-20 23:02:22.227', NULL, 'Activa', 14.99),
(209, 17, '2026-01-26 23:02:22.227', '2026-02-26 23:02:22.227', '2026-02-20 23:02:22.227', 'Cancelada', 7.99),
(29, 37, '2025-06-26 23:02:22.230', '2025-07-26 23:02:22.230', '2025-07-03 23:02:22.230', 'Cancelada', 19.98),
(115, 36, '2025-03-12 23:02:22.230', '2025-04-12 23:02:22.230', '2025-04-05 23:02:22.230', 'Cancelada', 7.99),
(89, 57, '2025-08-30 23:02:22.233', '2025-09-30 23:02:22.233', NULL, 'Activa', 39.95),
(27, 53, '2025-05-07 23:02:22.233', '2025-06-07 23:02:22.233', NULL, 'Activa', 7.99),
(175, 37, '2025-05-10 23:02:22.237', '2025-06-10 23:02:22.237', NULL, 'Activa', 19.98),
(157, 28, '2025-04-12 23:02:22.240', '2025-05-12 23:02:22.240', '2025-04-18 23:02:22.240', 'Cancelada', 37.48),
(46, 18, '2025-03-12 23:02:22.240', '2025-04-12 23:02:22.240', '2025-04-11 23:02:22.240', 'Cancelada', 19.98),
(238, 6, '2025-09-10 23:02:22.243', '2025-10-10 23:02:22.243', '2026-01-10 23:02:22.243', 'Vencida', 39.95),
(76, 59, '2025-07-05 23:02:22.250', '2025-08-05 23:02:22.250', NULL, 'Activa', 37.48),
(200, 53, '2025-10-09 23:02:22.253', '2025-11-09 23:02:22.253', NULL, 'Activa', 7.99),
(210, 42, '2025-06-06 23:02:22.253', '2025-07-06 23:02:22.253', NULL, 'Activa', 19.98),
(197, 50, '2025-07-06 23:02:22.257', '2025-08-06 23:02:22.257', NULL, 'Activa', 19.98),
(196, 21, '2025-06-09 23:02:22.260', '2025-07-09 23:02:22.260', NULL, 'Activa', 7.99),
(178, 57, '2025-07-23 23:02:22.260', '2025-08-23 23:02:22.260', NULL, 'Activa', 39.95),
(231, 21, '2025-06-04 23:02:22.263', '2025-07-04 23:02:22.263', '2025-07-04 23:02:22.263', 'Cancelada', 7.99),
(107, 23, '2026-02-17 23:02:22.267', '2026-03-17 23:02:22.267', NULL, 'Activa', 39.95),
(207, 8, '2025-08-18 23:02:22.267', '2025-09-18 23:02:22.267', NULL, 'Activa', 19.98),
(52, 22, '2025-11-19 23:02:22.270', '2025-12-19 23:02:22.270', NULL, 'Activa', 19.98),
(39, 43, '2025-12-25 23:02:22.270', '2026-01-25 23:02:22.270', NULL, 'Activa', 39.95),
(66, 41, '2025-11-25 23:02:22.273', '2025-12-25 23:02:22.273', NULL, 'Activa', 7.99),
(34, 15, '2025-11-19 23:02:22.273', '2025-12-19 23:02:22.273', NULL, 'Activa', 39.95),
(37, 2, '2025-03-15 23:02:22.277', '2025-04-15 23:02:22.277', NULL, 'Activa', 7.99),
(116, 38, '2025-03-28 23:02:22.280', '2025-04-28 23:02:22.280', '2025-04-19 23:02:22.280', 'Cancelada', 39.95),
(214, 21, '2025-05-21 23:02:22.280', '2025-06-21 23:02:22.280', NULL, 'Activa', 7.99),
(74, 48, '2026-02-08 23:02:22.283', '2026-03-08 23:02:22.283', NULL, 'Activa', 19.98),
(135, 53, '2025-08-06 23:02:22.283', '2025-09-06 23:02:22.283', '2025-09-12 23:02:22.283', 'Cancelada', 7.99),
(196, 46, '2025-12-19 23:02:22.287', '2026-01-19 23:02:22.287', NULL, 'Activa', 39.95),
(230, 10, '2025-08-28 23:02:22.290', '2025-09-28 23:02:22.290', '2025-09-30 23:02:22.290', 'Cancelada', 7.99),
(187, 7, '2025-12-12 23:02:22.290', '2026-01-12 23:02:22.290', NULL, 'Activa', 7.99),
(103, 14, '2025-11-02 23:02:22.290', '2025-12-02 23:02:22.290', NULL, 'Activa', 19.98),
(243, 11, '2025-12-06 23:02:22.293', '2026-01-06 23:02:22.293', NULL, 'Activa', 7.99),
(222, 15, '2025-09-12 23:02:22.293', '2025-10-12 23:02:22.293', NULL, 'Activa', 39.95),
(48, 11, '2025-06-13 23:02:22.297', '2025-07-13 23:02:22.297', NULL, 'Activa', 7.99),
(30, 46, '2025-11-23 23:02:22.300', '2025-12-23 23:02:22.300', NULL, 'Activa', 39.95),
(235, 55, '2025-11-17 23:02:22.300', '2025-12-17 23:02:22.300', NULL, 'Activa', 7.99),
(193, 47, '2025-05-17 23:02:22.300', '2025-06-17 23:02:22.300', NULL, 'Activa', 7.99),
(178, 20, '2025-05-30 23:02:22.303', '2025-06-30 23:02:22.303', NULL, 'Activa', 7.99),
(137, 40, '2025-06-01 23:02:22.307', '2025-07-01 23:02:22.307', NULL, 'Activa', 19.98),
(147, 27, '2025-09-30 23:02:22.310', '2025-10-30 23:02:22.310', '2025-10-07 23:02:22.310', 'Cancelada', 14.99),
(141, 51, '2026-02-09 23:02:22.310', '2026-03-09 23:02:22.310', NULL, 'Activa', 7.99),
(46, 33, '2025-10-16 23:02:22.313', '2025-11-16 23:02:22.313', NULL, 'Activa', 39.95),
(41, 3, '2026-01-25 23:02:22.313', '2026-02-25 23:02:22.313', '2026-01-27 23:02:22.313', 'Cancelada', 19.98),
(117, 28, '2025-08-20 23:02:22.317', '2025-09-20 23:02:22.317', NULL, 'Activa', 37.48),
(74, 19, '2025-08-08 23:02:22.317', '2025-09-08 23:02:22.317', NULL, 'Activa', 39.95),
(60, 45, '2026-01-14 23:02:22.320', '2026-02-14 23:02:22.320', NULL, 'Activa', 19.98),
(115, 8, '2025-11-29 23:02:22.320', '2025-12-29 23:02:22.320', NULL, 'Activa', 19.98),
(150, 22, '2025-08-01 23:02:22.323', '2025-09-01 23:02:22.323', NULL, 'Activa', 19.98),
(178, 33, '2025-12-15 23:02:22.323', '2026-01-15 23:02:22.323', '2026-02-04 23:02:22.323', 'Cancelada', 39.95),
(206, 4, '2026-02-25 23:02:22.327', '2026-03-25 23:02:22.327', NULL, 'Activa', 7.99),
(214, 42, '2025-02-28 23:02:22.330', '2025-03-28 23:02:22.330', '2025-04-26 23:02:22.330', 'Cancelada', 19.98),
(72, 10, '2026-02-21 23:02:22.330', '2026-03-21 23:02:22.330', NULL, 'Activa', 7.99),
(30, 11, '2026-02-14 23:02:22.333', '2026-03-14 23:02:22.333', '2026-02-17 23:02:22.333', 'Cancelada', 7.99),
(191, 36, '2025-11-27 23:02:22.333', '2025-12-27 23:02:22.333', '2026-03-27 23:02:22.333', 'Vencida', 7.99),
(187, 23, '2025-06-01 23:02:22.337', '2025-07-01 23:02:22.337', '2025-10-01 23:02:22.337', 'Vencida', 39.95),
(229, 9, '2025-11-27 23:02:22.340', '2025-12-27 23:02:22.340', NULL, 'Activa', 39.95),
(29, 49, '2025-09-17 23:02:22.340', '2025-10-17 23:02:22.340', NULL, 'Activa', 7.99),
(239, 10, '2025-03-26 23:02:22.343', '2025-04-26 23:02:22.343', '2025-04-16 23:02:22.343', 'Cancelada', 7.99),
(88, 47, '2025-12-13 23:02:22.343', '2026-01-13 23:02:22.343', NULL, 'Activa', 7.99),
(127, 31, '2025-07-27 23:02:22.347', '2025-08-27 23:02:22.347', NULL, 'Activa', 7.99),
(127, 52, '2025-10-24 23:02:22.350', '2025-11-24 23:02:22.350', '2025-11-10 23:02:22.350', 'Cancelada', 19.98),
(42, 51, '2025-08-15 23:02:22.350', '2025-09-15 23:02:22.350', NULL, 'Activa', 7.99),
(119, 6, '2025-07-30 23:02:22.353', '2025-08-30 23:02:22.353', NULL, 'Activa', 39.95),
(222, 57, '2025-03-01 23:02:22.353', '2025-04-01 23:02:22.353', NULL, 'Activa', 39.95),
(32, 33, '2026-01-24 23:02:22.357', '2026-02-24 23:02:22.357', NULL, 'Activa', 39.95),
(41, 22, '2025-08-02 23:02:22.357', '2025-09-02 23:02:22.357', NULL, 'Activa', 19.98),
(144, 51, '2025-05-11 23:02:22.360', '2025-06-11 23:02:22.360', '2025-05-24 23:02:22.360', 'Cancelada', 7.99),
(197, 9, '2025-11-10 23:02:22.360', '2025-12-10 23:02:22.360', '2025-12-22 23:02:22.360', 'Cancelada', 39.95),
(227, 57, '2026-02-15 23:02:22.363', '2026-03-15 23:02:22.363', NULL, 'Activa', 39.95),
(213, 36, '2025-11-12 23:02:22.367', '2025-12-12 23:02:22.367', '2025-11-29 23:02:22.367', 'Cancelada', 7.99),
(240, 2, '2026-01-19 23:02:22.367', '2026-02-19 23:02:22.367', NULL, 'Activa', 7.99),
(169, 3, '2025-10-24 23:02:22.370', '2025-11-24 23:02:22.370', NULL, 'Activa', 19.98),
(240, 5, '2026-01-05 23:02:22.370', '2026-02-05 23:02:22.370', NULL, 'Activa', 19.98),
(201, 34, '2025-07-19 23:02:22.373', '2025-08-19 23:02:22.373', NULL, 'Activa', 7.99),
(135, 54, '2026-02-14 23:02:22.377', '2026-03-14 23:02:22.377', NULL, 'Activa', 19.98),
(222, 34, '2025-06-15 23:02:22.377', '2025-07-15 23:02:22.377', NULL, 'Activa', 7.99),
(245, 49, '2026-02-19 23:02:22.380', '2026-03-19 23:02:22.380', NULL, 'Activa', 7.99),
(132, 55, '2025-08-15 23:02:22.380', '2025-09-15 23:02:22.380', NULL, 'Activa', 7.99),
(235, 18, '2025-07-14 23:02:22.383', '2025-08-14 23:02:22.383', NULL, 'Activa', 19.98),
(66, 13, '2025-06-20 23:02:22.383', '2025-07-20 23:02:22.383', NULL, 'Activa', 7.99),
(186, 47, '2025-06-08 23:02:22.387', '2025-07-08 23:02:22.387', NULL, 'Activa', 7.99),
(118, 19, '2025-05-25 23:02:22.390', '2025-06-25 23:02:22.390', '2025-05-25 23:02:22.390', 'Vencida', 39.95),
(210, 15, '2025-09-03 23:02:22.390', '2025-10-03 23:02:22.390', NULL, 'Activa', 39.95),
(209, 46, '2025-07-29 23:02:22.390', '2025-08-29 23:02:22.390', NULL, 'Activa', 39.95),
(101, 49, '2025-09-26 23:02:22.393', '2025-10-26 23:02:22.393', NULL, 'Activa', 7.99),
(259, 13, '2025-05-20 23:02:22.397', '2025-06-20 23:02:22.397', NULL, 'Activa', 7.99),
(199, 23, '2026-01-21 23:02:22.397', '2026-02-21 23:02:22.397', '2026-01-21 23:02:22.397', 'Cancelada', 39.95),
(60, 18, '2025-08-31 23:02:22.400', '2025-09-30 23:02:22.400', NULL, 'Activa', 19.98),
(230, 22, '2026-02-15 23:02:22.400', '2026-03-15 23:02:22.400', NULL, 'Activa', 19.98),
(110, 2, '2025-12-25 23:02:22.403', '2026-01-25 23:02:22.403', '2026-02-22 23:02:22.403', 'Cancelada', 7.99),
(253, 12, '2025-02-28 23:02:22.403', '2025-03-28 23:02:22.403', NULL, 'Activa', 19.98),
(225, 56, '2026-02-01 23:02:22.407', '2026-03-01 23:02:22.407', '2026-02-27 23:02:22.407', 'Cancelada', 19.98),
(246, 53, '2025-03-08 23:02:22.410', '2025-04-08 23:02:22.410', '2025-05-02 23:02:22.410', 'Cancelada', 7.99),
(181, 20, '2026-01-22 23:02:22.410', '2026-02-22 23:02:22.410', '2026-01-25 23:02:22.410', 'Cancelada', 7.99),
(179, 22, '2025-03-29 23:02:22.413', '2025-04-29 23:02:22.413', NULL, 'Activa', 19.98),
(37, 22, '2025-04-07 23:02:22.417', '2025-05-07 23:02:22.417', '2025-04-13 23:02:22.417', 'Cancelada', 19.98),
(106, 23, '2026-02-09 23:02:22.417', '2026-03-09 23:02:22.417', NULL, 'Activa', 39.95),
(108, 14, '2025-06-07 23:02:22.420', '2025-07-07 23:02:22.420', NULL, 'Activa', 19.98),
(232, 33, '2025-09-21 23:02:22.420', '2025-10-21 23:02:22.420', '2026-02-21 23:02:22.420', 'Vencida', 39.95),
(253, 43, '2025-04-12 23:02:22.423', '2025-05-12 23:02:22.423', NULL, 'Activa', 39.95),
(132, 44, '2025-11-14 23:02:22.423', '2025-12-14 23:02:22.423', NULL, 'Activa', 7.99),
(57, 16, '2025-12-24 23:02:22.427', '2026-01-24 23:02:22.427', NULL, 'Activa', 7.99),
(94, 3, '2026-01-02 23:02:22.430', '2026-02-02 23:02:22.430', NULL, 'Activa', 19.98),
(174, 20, '2025-05-25 23:02:22.430', '2025-06-25 23:02:22.430', '2025-07-08 23:02:22.430', 'Cancelada', 7.99),
(219, 14, '2025-12-09 23:02:22.433', '2026-01-09 23:02:22.433', NULL, 'Activa', 19.98),
(257, 26, '2025-07-22 23:02:22.437', '2025-08-22 23:02:22.437', '2025-07-22 23:02:22.437', 'Cancelada', 39.95),
(217, 42, '2026-01-15 23:02:22.440', '2026-02-15 23:02:22.440', NULL, 'Activa', 19.98),
(48, 39, '2025-03-25 23:02:22.440', '2025-04-25 23:02:22.440', NULL, 'Activa', 7.99),
(253, 37, '2025-03-29 23:02:22.443', '2025-04-29 23:02:22.443', '2025-04-09 23:02:22.443', 'Cancelada', 19.98),
(46, 24, '2025-11-03 23:02:22.443', '2025-12-03 23:02:22.443', '2025-11-15 23:02:22.443', 'Cancelada', 7.99),
(126, 39, '2025-06-25 23:02:22.447', '2025-07-25 23:02:22.447', '2025-08-08 23:02:22.447', 'Cancelada', 7.99),
(149, 34, '2026-01-27 23:02:22.450', '2026-02-27 23:02:22.450', NULL, 'Activa', 7.99),
(207, 10, '2025-10-21 23:02:22.450', '2025-11-21 23:02:22.450', NULL, 'Activa', 7.99),
(177, 7, '2025-03-03 23:02:22.453', '2025-04-03 23:02:22.453', NULL, 'Activa', 7.99),
(39, 50, '2025-11-11 23:02:22.457', '2025-12-11 23:02:22.457', NULL, 'Activa', 19.98),
(190, 38, '2025-11-19 23:02:22.460', '2025-12-19 23:02:22.460', '2026-01-07 23:02:22.460', 'Cancelada', 39.95),
(228, 52, '2025-05-26 23:02:22.460', '2025-06-26 23:02:22.460', '2025-05-29 23:02:22.460', 'Cancelada', 19.98),
(224, 24, '2025-12-23 23:02:22.463', '2026-01-23 23:02:22.463', '2026-02-01 23:02:22.463', 'Cancelada', 7.99),
(95, 29, '2025-10-10 23:02:22.463', '2025-11-10 23:02:22.463', NULL, 'Activa', 74.95),
(132, 23, '2025-09-26 23:02:22.467', '2025-10-26 23:02:22.467', NULL, 'Activa', 39.95),
(35, 42, '2025-09-16 23:02:22.467', '2025-10-16 23:02:22.467', NULL, 'Activa', 19.98),
(125, 25, '2025-05-19 23:02:22.470', '2025-06-19 23:02:22.470', NULL, 'Activa', 19.98),
(258, 17, '2025-04-08 23:02:22.470', '2025-05-08 23:02:22.470', NULL, 'Activa', 7.99),
(129, 46, '2025-06-26 23:02:22.473', '2025-07-26 23:02:22.473', NULL, 'Activa', 39.95),
(174, 50, '2025-09-26 23:02:22.477', '2025-10-26 23:02:22.477', '2025-09-27 23:02:22.477', 'Cancelada', 19.98),
(231, 40, '2025-11-24 23:02:22.477', '2025-12-24 23:02:22.477', '2026-01-05 23:02:22.477', 'Cancelada', 19.98),
(70, 49, '2025-06-06 23:02:22.480', '2025-07-06 23:02:22.480', '2025-07-14 23:02:22.480', 'Cancelada', 7.99),
(225, 25, '2025-10-07 23:02:22.480', '2025-11-07 23:02:22.480', NULL, 'Activa', 19.98),
(136, 39, '2026-01-24 23:02:22.483', '2026-02-24 23:02:22.483', NULL, 'Activa', 7.99),
(197, 7, '2025-04-27 23:02:22.487', '2025-05-27 23:02:22.487', '2025-05-06 23:02:22.487', 'Cancelada', 7.99),
(136, 7, '2025-07-30 23:02:22.487', '2025-08-30 23:02:22.487', NULL, 'Activa', 7.99),
(94, 23, '2025-06-08 23:02:22.490', '2025-07-08 23:02:22.490', NULL, 'Activa', 39.95),
(184, 29, '2026-02-26 23:02:22.490', '2026-03-26 23:02:22.490', NULL, 'Activa', 74.95),
(32, 46, '2025-07-01 23:02:22.490', '2025-08-01 23:02:22.490', '2025-09-01 23:02:22.490', 'Vencida', 39.95),
(79, 20, '2026-01-12 23:02:22.493', '2026-02-12 23:02:22.493', NULL, 'Activa', 7.99),
(48, 36, '2025-06-20 23:02:22.497', '2025-07-20 23:02:22.497', NULL, 'Activa', 7.99),
(144, 4, '2025-03-05 23:02:22.497', '2025-04-05 23:02:22.497', '2025-06-05 23:02:22.497', 'Vencida', 7.99),
(258, 14, '2025-06-23 23:02:22.500', '2025-07-23 23:02:22.500', NULL, 'Activa', 19.98),
(84, 4, '2025-06-11 23:02:22.500', '2025-07-11 23:02:22.500', NULL, 'Activa', 7.99),
(46, 39, '2025-12-14 23:02:22.503', '2026-01-14 23:02:22.503', NULL, 'Activa', 7.99),
(142, 1, '2025-03-19 23:02:22.507', '2025-04-19 23:02:22.507', NULL, 'Activa', 7.99),
(163, 1, '2025-11-07 23:02:22.507', '2025-12-07 23:02:22.507', NULL, 'Activa', 7.99),
(236, 16, '2026-01-18 23:02:22.510', '2026-02-18 23:02:22.510', NULL, 'Activa', 7.99),
(119, 1, '2026-01-09 23:02:22.510', '2026-02-09 23:02:22.510', NULL, 'Activa', 7.99),
(250, 49, '2025-12-09 23:02:22.513', '2026-01-09 23:02:22.513', NULL, 'Activa', 7.99),
(69, 3, '2026-02-13 23:02:22.513', '2026-03-13 23:02:22.513', '2026-07-13 23:02:22.513', 'Vencida', 19.98),
(51, 44, '2025-05-13 23:02:22.517', '2025-06-13 23:02:22.517', '2025-06-13 23:02:22.517', 'Vencida', 7.99),
(194, 21, '2026-01-18 23:02:22.520', '2026-02-18 23:02:22.520', NULL, 'Activa', 7.99),
(155, 14, '2026-02-07 23:02:22.520', '2026-03-07 23:02:22.520', NULL, 'Activa', 19.98),
(45, 21, '2025-10-13 23:02:22.523', '2025-11-13 23:02:22.523', NULL, 'Activa', 7.99),
(110, 14, '2025-06-09 23:02:22.523', '2025-07-09 23:02:22.523', '2025-06-10 23:02:22.523', 'Cancelada', 19.98),
(81, 17, '2025-11-15 23:02:22.527', '2025-12-15 23:02:22.527', '2025-11-22 23:02:22.527', 'Cancelada', 7.99),
(113, 46, '2025-05-15 23:02:22.530', '2025-06-15 23:02:22.530', '2025-06-11 23:02:22.530', 'Cancelada', 39.95),
(228, 41, '2025-11-20 23:02:22.530', '2025-12-20 23:02:22.530', NULL, 'Activa', 7.99),
(85, 16, '2025-11-27 23:02:22.530', '2025-12-27 23:02:22.530', NULL, 'Activa', 7.99),
(79, 11, '2025-04-15 23:02:22.533', '2025-05-15 23:02:22.533', NULL, 'Activa', 7.99),
(126, 12, '2025-08-08 23:02:22.537', '2025-09-08 23:02:22.537', NULL, 'Activa', 19.98),
(189, 30, '2025-08-13 23:02:22.537', '2025-09-13 23:02:22.537', NULL, 'Activa', 7.99),
(207, 25, '2025-08-29 23:02:22.540', '2025-09-29 23:02:22.540', NULL, 'Activa', 19.98),
(134, 14, '2025-04-09 23:02:22.540', '2025-05-09 23:02:22.540', '2025-06-05 23:02:22.540', 'Cancelada', 19.98),
(191, 15, '2025-05-20 23:02:22.543', '2025-06-20 23:02:22.543', NULL, 'Activa', 39.95),
(211, 40, '2025-06-25 23:02:22.547', '2025-07-25 23:02:22.547', NULL, 'Activa', 19.98),
(196, 16, '2025-03-25 23:02:22.550', '2025-04-25 23:02:22.550', NULL, 'Activa', 7.99),
(91, 33, '2025-08-26 23:02:22.550', '2025-09-26 23:02:22.550', NULL, 'Activa', 39.95),
(155, 21, '2025-05-02 23:02:22.553', '2025-06-02 23:02:22.553', NULL, 'Activa', 7.99),
(36, 2, '2025-11-23 23:02:22.553', '2025-12-23 23:02:22.553', '2025-12-08 23:02:22.553', 'Cancelada', 7.99),
(118, 56, '2025-07-01 23:02:22.557', '2025-08-01 23:02:22.557', NULL, 'Activa', 19.98),
(188, 11, '2026-01-24 23:02:22.557', '2026-02-24 23:02:22.557', '2026-02-17 23:02:22.557', 'Cancelada', 7.99),
(85, 54, '2025-09-09 23:02:22.560', '2025-10-09 23:02:22.560', NULL, 'Activa', 19.98),
(256, 13, '2025-05-10 23:02:22.560', '2025-06-10 23:02:22.560', '2025-10-10 23:02:22.560', 'Vencida', 7.99),
(187, 14, '2025-07-03 23:02:22.563', '2025-08-03 23:02:22.563', '2025-08-05 23:02:22.563', 'Cancelada', 19.98),
(47, 48, '2025-06-28 23:02:22.567', '2025-07-28 23:02:22.567', NULL, 'Activa', 19.98),
(84, 24, '2025-08-19 23:02:22.570', '2025-09-19 23:02:22.570', NULL, 'Activa', 7.99),
(169, 33, '2025-11-28 23:02:22.570', '2025-12-28 23:02:22.570', NULL, 'Activa', 39.95),
(157, 5, '2025-12-27 23:02:22.573', '2026-01-27 23:02:22.573', NULL, 'Activa', 19.98),
(72, 39, '2025-04-23 23:02:22.573', '2025-05-23 23:02:22.573', NULL, 'Activa', 7.99),
(155, 42, '2025-09-16 23:02:22.577', '2025-10-16 23:02:22.577', NULL, 'Activa', 19.98),
(100, 54, '2025-11-10 23:02:22.580', '2025-12-10 23:02:22.580', NULL, 'Activa', 19.98),
(86, 19, '2025-08-21 23:02:22.580', '2025-09-21 23:02:22.580', NULL, 'Activa', 39.95),
(64, 1, '2025-05-17 23:02:22.580', '2025-06-17 23:02:22.580', NULL, 'Activa', 7.99),
(31, 56, '2025-12-10 23:02:22.583', '2026-01-10 23:02:22.583', '2026-02-07 23:02:22.583', 'Cancelada', 19.98),
(218, 24, '2025-12-05 23:02:22.587', '2026-01-05 23:02:22.587', NULL, 'Activa', 7.99),
(246, 2, '2025-04-16 23:02:22.587', '2025-05-16 23:02:22.587', NULL, 'Activa', 7.99),
(97, 19, '2025-09-08 23:02:22.590', '2025-10-08 23:02:22.590', '2025-09-19 23:02:22.590', 'Cancelada', 39.95),
(225, 3, '2025-05-21 23:02:22.590', '2025-06-21 23:02:22.590', '2025-09-21 23:02:22.590', 'Vencida', 19.98),
(213, 34, '2026-01-27 23:02:22.593', '2026-02-27 23:02:22.593', '2026-03-23 23:02:22.593', 'Cancelada', 7.99),
(192, 4, '2025-09-20 23:02:22.593', '2025-10-20 23:02:22.593', NULL, 'Activa', 7.99),
(182, 33, '2025-08-09 23:02:22.597', '2025-09-09 23:02:22.597', '2025-08-09 23:02:22.597', 'Cancelada', 39.95),
(260, 18, '2025-04-16 23:02:22.597', '2025-05-16 23:02:22.597', NULL, 'Activa', 19.98),
(144, 2, '2025-03-06 23:02:22.600', '2025-04-06 23:02:22.600', NULL, 'Activa', 7.99),
(35, 47, '2025-10-20 23:02:22.600', '2025-11-20 23:02:22.600', NULL, 'Activa', 7.99),
(241, 7, '2026-01-04 23:02:22.603', '2026-02-04 23:02:22.603', NULL, 'Activa', 7.99),
(161, 30, '2025-05-06 23:02:22.607', '2025-06-06 23:02:22.607', NULL, 'Activa', 7.99),
(67, 48, '2025-12-23 23:02:22.610', '2026-01-23 23:02:22.610', NULL, 'Activa', 19.98),
(111, 2, '2025-12-09 23:02:22.610', '2026-01-09 23:02:22.610', NULL, 'Activa', 7.99),
(75, 16, '2025-03-04 23:02:22.613', '2025-04-04 23:02:22.613', '2025-04-21 23:02:22.613', 'Cancelada', 7.99),
(195, 19, '2025-06-07 23:02:22.613', '2025-07-07 23:02:22.613', NULL, 'Activa', 39.95),
(29, 55, '2025-10-09 23:02:22.617', '2025-11-09 23:02:22.617', '2025-10-13 23:02:22.617', 'Cancelada', 7.99),
(248, 22, '2025-05-30 23:02:22.620', '2025-06-30 23:02:22.620', NULL, 'Activa', 19.98),
(243, 28, '2026-01-01 23:02:22.620', '2026-02-01 23:02:22.620', NULL, 'Activa', 37.48),
(119, 3, '2026-02-06 23:02:22.620', '2026-03-06 23:02:22.620', NULL, 'Activa', 19.98),
(258, 20, '2025-12-22 23:02:22.623', '2026-01-22 23:02:22.623', NULL, 'Activa', 7.99),
(232, 6, '2025-04-25 23:02:22.627', '2025-05-25 23:02:22.627', NULL, 'Activa', 39.95),
(42, 38, '2025-08-08 23:02:22.630', '2025-09-08 23:02:22.630', NULL, 'Activa', 39.95),
(249, 24, '2025-05-08 23:02:22.630', '2025-06-08 23:02:22.630', '2025-07-08 23:02:22.630', 'Vencida', 7.99),
(60, 58, '2025-06-22 23:02:22.633', '2025-07-22 23:02:22.633', NULL, 'Activa', 14.99),
(197, 42, '2025-07-25 23:02:22.633', '2025-08-25 23:02:22.633', NULL, 'Activa', 19.98),
(95, 4, '2025-12-26 23:02:22.637', '2026-01-26 23:02:22.637', NULL, 'Activa', 7.99),
(250, 10, '2026-01-24 23:02:22.637', '2026-02-24 23:02:22.637', NULL, 'Activa', 7.99),
(244, 19, '2025-09-07 23:02:22.640', '2025-10-07 23:02:22.640', '2025-10-21 23:02:22.640', 'Cancelada', 39.95),
(138, 24, '2025-10-18 23:02:22.640', '2025-11-18 23:02:22.640', NULL, 'Activa', 7.99),
(259, 10, '2025-03-25 23:02:22.643', '2025-04-25 23:02:22.643', NULL, 'Activa', 7.99),
(187, 4, '2025-05-06 23:02:22.647', '2025-06-06 23:02:22.647', '2025-07-04 23:02:22.647', 'Cancelada', 7.99),
(71, 30, '2025-08-06 23:02:22.650', '2025-09-06 23:02:22.650', '2025-09-19 23:02:22.650', 'Cancelada', 7.99),
(38, 19, '2025-07-22 23:02:22.650', '2025-08-22 23:02:22.650', NULL, 'Activa', 39.95),
(188, 6, '2025-08-10 23:02:22.653', '2025-09-10 23:02:22.653', NULL, 'Activa', 39.95),
(124, 5, '2025-04-28 23:02:22.653', '2025-05-28 23:02:22.653', NULL, 'Activa', 19.98),
(245, 19, '2025-10-01 23:02:22.657', '2025-11-01 23:02:22.657', '2025-11-16 23:02:22.657', 'Cancelada', 39.95),
(66, 13, '2025-04-23 23:02:22.657', '2025-05-23 23:02:22.657', NULL, 'Activa', 7.99),
(165, 11, '2025-10-14 23:02:22.660', '2025-11-14 23:02:22.660', NULL, 'Activa', 7.99),
(47, 1, '2026-01-19 23:02:22.660', '2026-02-19 23:02:22.660', '2026-02-14 23:02:22.660', 'Cancelada', 7.99),
(230, 51, '2025-11-17 23:02:22.663', '2025-12-17 23:02:22.663', '2026-03-17 23:02:22.663', 'Vencida', 7.99),
(241, 7, '2025-10-07 23:02:22.667', '2025-11-07 23:02:22.667', NULL, 'Activa', 7.99),
(231, 47, '2025-04-14 23:02:22.667', '2025-05-14 23:02:22.667', NULL, 'Activa', 7.99),
(188, 31, '2025-08-25 23:02:22.670', '2025-09-25 23:02:22.670', NULL, 'Activa', 7.99),
(194, 21, '2026-02-05 23:02:22.670', '2026-03-05 23:02:22.670', NULL, 'Activa', 7.99);

PRINT ' 550 suscripciones insertadas correctamente';
GO

-- ==========================================
-- VERIFICAR SUSCRIPCIONES INSERTADAS
-- ==========================================
PRINT '========================================';
PRINT 'VERIFICACIÓN DE SUSCRIPCIONES:';
PRINT '========================================';

SELECT 
    COUNT(*) as TotalSuscripciones,
    MIN(id) as PrimerID,
    MAX(id) as UltimoID
FROM Suscripcion;
GO

PRINT '========================================';
PRINT ' SUSCRIPCIONES INSERTADAS CORRECTAMENTE';
PRINT '========================================';
GO


-- 10. FACTURAS (550 registros reales)
USE FanHub_BD;
GO

PRINT 'Limpiando facturas viejas (por si acaso)...';
DELETE FROM Factura;
GO

PRINT 'Generando Facturas dinámicas para las suscripciones existentes...';

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total)
SELECT 
    id, -- Toma el ID real de la suscripción que sí existe en la BD
    'TXN-' + CAST(id AS NVARCHAR(20)) + '-' + REPLACE(CONVERT(NVARCHAR, fecha_inicio, 112), '/', ''),
    fecha_inicio,
    precio_pactado,
    precio_pactado * 0.16, -- 16% impuesto
    precio_pactado * 1.16  -- Total
FROM Suscripcion;

PRINT ' Facturas generadas exitosamente.';
GO



-- 11. REACCIONES (1600 registros nuevos con distribución realista)
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'GENERANDO NUEVAS REACCIONES';
PRINT '========================================';
GO


-- 1. ELIMINAR REACCIONES EXISTENTES
PRINT 'Eliminando reacciones existentes...';
DELETE FROM UsuarioReaccionPublicacion;
PRINT ' Reacciones eliminadas';
GO


-- 2. GENERAR 1600 NUEVAS REACCIONES
PRINT 'Generando 1600 nuevas reacciones...';

-- Creacion de tabla temporal 
DECLARE @Reacciones TABLE (idTipoReaccion INT, peso INT);
INSERT INTO @Reacciones VALUES 
(1, 235),  -- Me gusta
(2, 222),  -- Me encanta
(3, 232),  -- Me divierte
(4, 228),  -- Fuego
(5, 233),  -- Me entristece
(6, 218),  -- Me asombra
(7, 232);  -- Me enfurece
-- Total: 1600

DECLARE @contador INT = 1;
DECLARE @idUsuario INT;
DECLARE @idPublicacion INT;
DECLARE @idTipoReaccion INT;
DECLARE @fecha DATETIME;

-- Generar las reacciones una por una para controlar la distribución
WHILE @contador <= 1600
BEGIN
    -- Seleccionar tipo de reacción basado en la distribución
    SELECT TOP 1 @idTipoReaccion = idTipoReaccion
    FROM @Reacciones
    WHERE peso > 0
    ORDER BY NEWID();
    
    -- Reducir el peso del tipo seleccionado
    UPDATE @Reacciones SET peso = peso - 1 WHERE idTipoReaccion = @idTipoReaccion;
    
    -- Seleccionar usuario aleatorio (que no sea creador, id > 26)
    SELECT TOP 1 @idUsuario = id 
    FROM Usuario 
    WHERE (id BETWEEN 27 AND 50 OR id > 60) AND esta_activo = 1
    ORDER BY NEWID();
    
    -- Seleccionar publicación aleatoria
    SELECT TOP 1 @idPublicacion = id 
    FROM Publicacion 
    ORDER BY NEWID();
    
    -- Generar fecha aleatoria en los últimos 6 meses
    SET @fecha = DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 180, GETDATE());
    
    -- Evitar duplicados (mismo usuario, misma publicación, mismo tipo)
    IF NOT EXISTS (
        SELECT 1 FROM UsuarioReaccionPublicacion 
        WHERE idUsuario = @idUsuario 
        AND idPublicacion = @idPublicacion 
        AND idTipoReaccion = @idTipoReaccion
    )
    BEGIN
        INSERT INTO UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion)
        VALUES (@idUsuario, @idPublicacion, @idTipoReaccion, @fecha);
        
        SET @contador = @contador + 1;
    END;
    
    -- Mostrar progreso cada 200 reacciones
    IF @contador % 200 = 0
        PRINT '  ✓ ' + CAST(@contador AS VARCHAR) + ' reacciones insertadas...';
END;

PRINT ' 1600 reacciones insertadas correctamente';
GO


-- 3. VERIFICAR DISTRIBUCIÓN FINAL
PRINT '========================================';
PRINT 'VERIFICACIÓN DE DISTRIBUCIÓN:';
PRINT '========================================';

SELECT 
    tr.nombre as TipoReaccion,
    COUNT(*) as Cantidad,
    CAST(COUNT(*) * 100.0 / 1600 AS DECIMAL(10,2)) as Porcentaje
FROM UsuarioReaccionPublicacion urp
JOIN TipoReaccion tr ON urp.idTipoReaccion = tr.id
GROUP BY tr.nombre
ORDER BY Cantidad DESC;
GO


-- 4. ESTADÍSTICAS GENERALES
SELECT 
    'Total reacciones' as Concepto,
    COUNT(*) as Valor
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Usuarios que han reaccionado',
    COUNT(DISTINCT idUsuario)
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Publicaciones con reacciones',
    COUNT(DISTINCT idPublicacion)
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Tipos de reacción utilizados',
    COUNT(DISTINCT idTipoReaccion)
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Promedio reacciones por usuario',
    COUNT(*) / NULLIF(COUNT(DISTINCT idUsuario), 0)
FROM UsuarioReaccionPublicacion
UNION ALL
SELECT 
    'Promedio reacciones por publicación',
    COUNT(*) / NULLIF(COUNT(DISTINCT idPublicacion), 0)
FROM UsuarioReaccionPublicacion;
GO

PRINT '========================================';
PRINT ' REACCIONES GENERADAS EXITOSAMENTE';
PRINT '========================================';
GO


-- 12 COMENTARIOS (1100 registros: 950 principales + 150 hilos)
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'GENERANDO NUEVOS COMENTARIOS';
PRINT '========================================';
GO


-- 1. ELIMINAR COMENTARIOS EXISTENTES
PRINT 'Eliminando comentarios existentes...';
DELETE FROM Comentario;
PRINT ' Comentarios eliminados';
GO


-- 2. CREAR TABLA TEMPORAL (VERIFICAR QUE NO EXISTA)
PRINT 'Creando tabla temporal de textos...';

-- Eliminar si existe
IF OBJECT_ID('tempdb..#TempTextosComentarios') IS NOT NULL
    DROP TABLE #TempTextosComentarios;

CREATE TABLE #TempTextosComentarios (
    id INT IDENTITY(1,1),
    texto VARCHAR(500)
);

INSERT INTO #TempTextosComentarios (texto) VALUES
('Excelente contenido! Sigue así 👏'),
('Me encantó este video, muy útil gracias'),
('Compartido con mis amigos, todos deberían ver esto'),
('¿Cuándo subirás más contenido?'),
('El mejor creador de la plataforma sin duda'),
('No sabía esto, gracias por la info'),
('Me reí mucho con este video'),
('Qué calidad de contenido, mereces más seguidores'),
('Ya me suscribí, vale totalmente la pena'),
('Esperando la siguiente parte con ansias'),
('Muy buen trabajo, sigue así'),
('Me encanta tu forma de explicar'),
('Compartido en mis redes sociales'),
('Esto es justo lo que necesitaba'),
('Gracias por el contenido gratuito'),
('Increíble, no me esperaba ese final'),
('Eres el mejor, gracias por existir'),
('Este video me salvó la vida'),
('Qué buen tutorial, lo entendí perfecto'),
('Me encanta tu canal, eres único'),
('Sos un capo, gracias por compartir'),
('Vine por el título y me quedé por el contenido'),
('Me suscribí al instante'),
('Calidad de contenido como siempre'),
('No puedo creer que sea gratis esto');

PRINT ' Tabla temporal creada';
GO


-- 3. GENERAR COMENTARIOS PRINCIPALES (950)
PRINT 'Generando 950 comentarios principales...';

DECLARE @comentario_id INT = 1;
DECLARE @idUsuario INT;
DECLARE @idPublicacion INT;
DECLARE @texto VARCHAR(500);
DECLARE @fecha DATETIME;

WHILE @comentario_id <= 950
BEGIN
    -- Seleccionar usuario aleatorio (que no sea creador, id > 26)
    SELECT TOP 1 @idUsuario = id 
    FROM Usuario 
    WHERE (id BETWEEN 27 AND 50 OR id > 60) AND esta_activo = 1
    ORDER BY NEWID();
    
    -- Seleccionar publicación aleatoria
    SELECT TOP 1 @idPublicacion = id 
    FROM Publicacion 
    ORDER BY NEWID();
    
    -- Seleccionar texto aleatorio desde la tabla temporal
    SELECT TOP 1 @texto = texto 
    FROM #TempTextosComentarios 
    ORDER BY NEWID();
    
    -- Generar fecha aleatoria en los últimos 6 meses
    SET @fecha = DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 180, GETDATE());
    
    -- Evitar múltiples comentarios del mismo usuario en la misma publicación
    IF NOT EXISTS (
        SELECT 1 FROM Comentario 
        WHERE idUsuario = @idUsuario 
        AND idPublicacion = @idPublicacion 
        AND idComentarioPadre IS NULL
    )
    BEGIN
        INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
        VALUES (@idUsuario, @idPublicacion, NULL, @texto, @fecha);
        
        SET @comentario_id = @comentario_id + 1;
    END;
    
    -- Mostrar progreso cada 100 comentarios
    IF @comentario_id % 100 = 0
        PRINT '  ✓ ' + CAST(@comentario_id AS VARCHAR) + ' comentarios principales insertados...';
END;

PRINT ' 950 comentarios principales insertados';
GO


-- 4. VERIFICAR QUE HAY COMENTARIOS PRINCIPALES
DECLARE @TotalPrincipales INT;
SELECT @TotalPrincipales = COUNT(*) FROM Comentario WHERE idComentarioPadre IS NULL;

IF @TotalPrincipales = 0
BEGIN
    PRINT 'ERROR: No hay comentarios principales para crear hilos.';
END
ELSE
BEGIN
    PRINT 'Hay ' + CAST(@TotalPrincipales AS VARCHAR) + ' comentarios principales para crear hilos.';
END
GO


-- 5. GENERAR HILOS DE CONVERSACIÓN (150 respuestas)
PRINT 'Generando 150 hilos de conversación...';

DECLARE @hilo_id INT = 1;
DECLARE @idUsuarioResp INT;
DECLARE @idComentarioPadre INT;
DECLARE @idPublicacionResp INT;
DECLARE @textoResp VARCHAR(500);
DECLARE @fechaResp DATETIME;

WHILE @hilo_id <= 150
BEGIN
    -- Seleccionar usuario aleatorio
    SELECT TOP 1 @idUsuarioResp = id 
    FROM Usuario 
    WHERE (id BETWEEN 27 AND 50 OR id > 60) AND esta_activo = 1
    ORDER BY NEWID();
    
    -- Seleccionar un comentario principal aleatorio para responder
    SELECT TOP 1 @idComentarioPadre = id, @idPublicacionResp = idPublicacion
    FROM Comentario 
    WHERE idComentarioPadre IS NULL  -- Solo comentarios principales
    ORDER BY NEWID();
    
    -- Verificar que se obtuvieron valores válidos
    IF @idComentarioPadre IS NOT NULL AND @idPublicacionResp IS NOT NULL
    BEGIN
        -- Seleccionar texto de respuesta
        SET @textoResp = CASE ABS(CHECKSUM(NEWID())) % 5
            WHEN 0 THEN 'Totalmente de acuerdo!'
            WHEN 1 THEN 'Yo también pienso igual 👍'
            WHEN 2 THEN 'Gracias por el comentario'
            WHEN 3 THEN 'Comparto tu opinión'
            ELSE 'Qué buena observación'
        END;
        
        -- Generar fecha unos días después del comentario padre
        SELECT @fechaResp = DATEADD(DAY, 1 + ABS(CHECKSUM(NEWID())) % 7, fecha)
        FROM Comentario WHERE id = @idComentarioPadre;
        
        -- Evitar respuestas duplicadas
        IF NOT EXISTS (
            SELECT 1 FROM Comentario 
            WHERE idComentarioPadre = @idComentarioPadre 
            AND idUsuario = @idUsuarioResp
        )
        BEGIN
            INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
            VALUES (@idUsuarioResp, @idPublicacionResp, @idComentarioPadre, @textoResp, @fechaResp);
            
            SET @hilo_id = @hilo_id + 1;
        END;
    END;
    
    -- Mostrar progreso cada 30 hilos
    IF @hilo_id % 30 = 0
        PRINT '  ✓ ' + CAST(@hilo_id AS VARCHAR) + ' hilos insertados...';
END;

PRINT ' 150 hilos de conversación insertados';
GO


-- 5B. AGREGAR COMENTARIOS ADICIONALES PARA CREADORES POLÉMICOS (27-30)
PRINT '========================================';
PRINT 'AGREGANDO COMENTARIOS A PUBLICACIONES POLÉMICAS';
PRINT '========================================';

-- Declarar todas las variables al inicio del bloque
DECLARE @comentarios_polemicos TABLE (texto VARCHAR(500));
DECLARE @polemico_id INT;
DECLARE @pub_polemica_id INT;
DECLARE @usuario_random INT;
DECLARE @texto_polemico VARCHAR(500);
DECLARE @fecha_polemica DATETIME;
DECLARE @comentario_count INT = 0;
DECLARE @objetivo_comentarios INT = 100;
DECLARE @i INT;
DECLARE @temp_id INT;
DECLARE @comentarios_por_pub INT;

INSERT INTO @comentarios_polemicos VALUES
-- Comentarios negativos/confrontativos
('Esto es completamente falso, haz tu investigación'),
('No puedo creer que alguien piense así'),
('Qué ridículo, mejor dedícate a otra cosa'),
('Basado en ninguna evidencia científica'),
('Reportado por desinformación'),
('Deberían eliminar este contenido'),
('Eres parte del problema que criticas'),
('Qué ignorancia por favor'),
('Vete de la plataforma con estas ideas'),
('Este tipo de contenido daña a la comunidad'),
-- Comentarios de apoyo
('Finalmente alguien con valor para decirlo!'),
('Comparto 100% tu opinión, gracias por hablar'),
('Me alegra que alguien diga esto abiertamente'),
('Tienes todo mi respeto y apoyo'),
('Es valiente publicar esto, te admiro'),
-- Comentarios de debate/preguntas
('¿Puedes compartir tus fuentes? Me interesa'),
('No estoy de acuerdo pero respeto tu opinión'),
('Explícame tu punto con más detalle'),
('Desde otra perspectiva, podría ser que...'),
('Interesante punto, pero qué opinas de...'),
-- Comentarios sarcásticos/burlas
('Claro, y yo soy el rey de Inglaterra'),
('Fuente: Arial 12'),
('Ya salió el experto en temas que no sabe'),
('Todo lo que no entiendo es falso, básicamente');

PRINT 'Agregando comentarios a publicaciones polémicas...';

-- Cursor para cada publicación polémica
DECLARE cursor_pubs_polemicas CURSOR FOR 
    SELECT p.id, p.idCreador
    FROM Publicacion p
    WHERE p.idCreador BETWEEN 27 AND 30;

OPEN cursor_pubs_polemicas;
FETCH NEXT FROM cursor_pubs_polemicas INTO @pub_polemica_id, @polemico_id;

WHILE @@FETCH_STATUS = 0 AND @comentario_count < @objetivo_comentarios
BEGIN
    -- Agregar entre 5 y 15 comentarios por publicación polémica
    SET @comentarios_por_pub = 5 + ABS(CHECKSUM(NEWID())) % 11;
    SET @i = 1;
    
    WHILE @i <= @comentarios_por_pub AND @comentario_count < @objetivo_comentarios
    BEGIN
        -- Seleccionar usuario (puede ser cualquier usuario activo, incluso el propio creador)
        SELECT TOP 1 @usuario_random = id 
        FROM Usuario 
        WHERE (id BETWEEN 27 AND 50 OR id > 60) AND esta_activo = 1
        ORDER BY NEWID();
        
        -- Seleccionar texto aleatorio de los comentarios polémicos
        SELECT TOP 1 @texto_polemico = texto 
        FROM @comentarios_polemicos 
        ORDER BY NEWID();
        
        -- Fecha aleatoria más reciente (últimos 15 días)
        SET @fecha_polemica = DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 15, GETDATE());
        
        -- Insertar comentario
        INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
        VALUES (@usuario_random, @pub_polemica_id, NULL, @texto_polemico, @fecha_polemica);
        
        SET @temp_id = SCOPE_IDENTITY();
        SET @comentario_count = @comentario_count + 1;
        
        -- 30% de probabilidad de agregar una respuesta a este comentario
        IF ABS(CHECKSUM(NEWID())) % 10 < 3 AND @comentario_count < @objetivo_comentarios
        BEGIN
            -- Seleccionar otro usuario diferente
            SELECT TOP 1 @usuario_random = id 
            FROM Usuario 
            WHERE esta_activo = 1 AND id != @usuario_random
            ORDER BY NEWID();
            
            SET @texto_polemico = CASE ABS(CHECKSUM(NEWID())) % 4
                WHEN 0 THEN 'Exacto! Eso mismo pienso'
                WHEN 1 THEN 'No estoy de acuerdo con tu comentario'
                WHEN 2 THEN 'Gracias por aportar al debate'
                ELSE 'Jajaja buen punto'
            END;
            
            SET @fecha_polemica = DATEADD(HOUR, 1 + ABS(CHECKSUM(NEWID())) % 24, @fecha_polemica);
            
            INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
            VALUES (@usuario_random, @pub_polemica_id, @temp_id, @texto_polemico, @fecha_polemica);
            
            SET @comentario_count = @comentario_count + 1;
        END;
        
        -- Mostrar progreso
        IF @comentario_count % 20 = 0
            PRINT '  ✓ ' + CAST(@comentario_count AS VARCHAR) + ' comentarios polémicos agregados...';
        
        SET @i = @i + 1;
    END;
    
    FETCH NEXT FROM cursor_pubs_polemicas INTO @pub_polemica_id, @polemico_id;
END;

CLOSE cursor_pubs_polemicas;
DEALLOCATE cursor_pubs_polemicas;

PRINT N'✅ ' + CAST(@comentario_count AS VARCHAR) + ' comentarios adicionales agregados a publicaciones polémicas';
GO


-- 5C. CREAR HILOS DE DISCUSIÓN EN PUBLICACIONES POLÉMICAS
PRINT 'Creando hilos de discusión en publicaciones polémicas...';

-- Declarar variables para este bloque
DECLARE @hilo_polemico_id INT = 1;
DECLARE @hilos_objetivo INT = 40;
DECLARE @comentario_base INT;
DECLARE @respuesta_texto VARCHAR(500);
DECLARE @idPublicacionRespTemp INT;
DECLARE @ultimo_comentario_id INT;
DECLARE @cadena_count INT;
DECLARE @respuestas_en_cadena INT;
DECLARE @usuario_random_hilo INT;
DECLARE @fechaResp_hilo DATETIME;

WHILE @hilo_polemico_id <= @hilos_objetivo
BEGIN
    -- Seleccionar un comentario de una publicación polémica
    SELECT TOP 1 @comentario_base = c.id, @idPublicacionRespTemp = c.idPublicacion
    FROM Comentario c
    JOIN Publicacion p ON c.idPublicacion = p.id
    WHERE p.idCreador BETWEEN 27 AND 30
    AND c.idComentarioPadre IS NULL
    ORDER BY NEWID();
    
    IF @comentario_base IS NOT NULL
    BEGIN
        -- Crear una respuesta en cadena
        SET @respuestas_en_cadena = 2 + ABS(CHECKSUM(NEWID())) % 4;
        SET @ultimo_comentario_id = @comentario_base;
        SET @cadena_count = 1;
        
        WHILE @cadena_count <= @respuestas_en_cadena AND @hilo_polemico_id <= @hilos_objetivo
        BEGIN
            -- Seleccionar usuario diferente
            SELECT TOP 1 @usuario_random_hilo = id 
            FROM Usuario 
            WHERE (id BETWEEN 27 AND 50 OR id > 60) AND esta_activo = 1
            ORDER BY NEWID();
            
            -- Texto según posición en la cadena
            SET @respuesta_texto = CASE @cadena_count
                WHEN 1 THEN 'Totalmente de acuerdo con el comentario original'
                WHEN 2 THEN 'Yo también pienso igual, pero habría que considerar...'
                WHEN 3 THEN 'Exacto! Por eso este post es tan polémico'
                ELSE 'Esta discusión es muy interesante'
            END;
            
            -- Fecha progresiva
            SELECT @fechaResp_hilo = DATEADD(HOUR, 2 + @cadena_count * 3, fecha)
            FROM Comentario WHERE id = @ultimo_comentario_id;
            
            INSERT INTO Comentario (idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
            VALUES (@usuario_random_hilo, @idPublicacionRespTemp, @ultimo_comentario_id, @respuesta_texto, @fechaResp_hilo);
            
            SET @ultimo_comentario_id = SCOPE_IDENTITY();
            SET @hilo_polemico_id = @hilo_polemico_id + 1;
            SET @cadena_count = @cadena_count + 1;
        END;
    END;
END;

PRINT N'✅ ' + CAST(@hilo_polemico_id - 1 AS VARCHAR) + ' hilos de discusión creados';
GO


-- 6. VERIFICAR ESTADÍSTICAS FINALES
PRINT '========================================';
PRINT 'VERIFICACIÓN DE COMENTARIOS:';
PRINT '========================================';

SELECT 
    'Total comentarios' as Concepto,
    COUNT(*) as Valor
FROM Comentario
UNION ALL
SELECT 
    'Comentarios principales',
    COUNT(*)
FROM Comentario
WHERE idComentarioPadre IS NULL
UNION ALL
SELECT 
    'Respuestas (hilos)',
    COUNT(*)
FROM Comentario
WHERE idComentarioPadre IS NOT NULL
UNION ALL
SELECT 
    'Usuarios que comentaron',
    COUNT(DISTINCT idUsuario)
FROM Comentario
UNION ALL
SELECT 
    'Publicaciones con comentarios',
    COUNT(DISTINCT idPublicacion)
FROM Comentario;

PRINT '';
PRINT '========================================';
PRINT 'ESTADÍSTICAS DE PUBLICACIONES POLÉMICAS:';
PRINT '========================================';

SELECT 
    u.nickname AS Creador,
    COUNT(DISTINCT p.id) AS Publicaciones,
    COUNT(c.id) AS TotalComentarios,
    ISNULL(AVG(comentarios_por_pub.cantidad), 0) AS PromedioComentarios,
    ISNULL(MIN(comentarios_por_pub.cantidad), 0) AS MinComentarios,
    ISNULL(MAX(comentarios_por_pub.cantidad), 0) AS MaxComentarios
FROM Creador cr
JOIN Usuario u ON cr.idUsuario = u.id
LEFT JOIN Publicacion p ON cr.idUsuario = p.idCreador
LEFT JOIN Comentario c ON p.id = c.idPublicacion
LEFT JOIN (
    SELECT idPublicacion, COUNT(*) AS cantidad
    FROM Comentario
    GROUP BY idPublicacion
) comentarios_por_pub ON p.id = comentarios_por_pub.idPublicacion
WHERE cr.idUsuario BETWEEN 27 AND 30
GROUP BY u.nickname
ORDER BY TotalComentarios DESC;

PRINT '';
PRINT 'MUESTRA DE COMENTARIOS EN PUBLICACIONES POLÉMICAS:';
SELECT TOP 15
    u.nickname AS Creador,
    p.titulo,
    cu.nickname AS Comentarista,
    LEFT(c.texto, 60) AS Comentario,
    c.fecha,
    CASE WHEN c.idComentarioPadre IS NULL THEN 'PRINCIPAL' ELSE 'RESPUESTA' END AS Tipo
FROM Comentario c
JOIN Publicacion p ON c.idPublicacion = p.id
JOIN Creador cr ON p.idCreador = cr.idUsuario
JOIN Usuario u ON cr.idUsuario = u.id
JOIN Usuario cu ON c.idUsuario = cu.id
WHERE cr.idUsuario BETWEEN 27 AND 30
ORDER BY c.fecha DESC;
GO


-- 7. LIMPIAR TABLA TEMPORAL
IF OBJECT_ID('tempdb..#TempTextosComentarios') IS NOT NULL
    DROP TABLE #TempTextosComentarios;

PRINT '========================================';
PRINT 'COMENTARIOS GENERADOS EXITOSAMENTE';
PRINT '========================================';
GO


USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'CREANDO 10 USUARIOS LURKERS';
PRINT '========================================';
GO

-- 1. creamos nuevos usuarios lurkers (Dejamos que SQL asigne el ID solo)
PRINT 'Insertando 10 usuarios fantasma...';
INSERT INTO Usuario (email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo)
SELECT 
    'lurker_pro_' + CAST(NEWID() AS NVARCHAR(36)) + '@email.com',
    'hash_seguro_123',
    'Fantasma_' + LEFT(CAST(NEWID() AS NVARCHAR(36)), 8),
    DATEADD(DAY, -20, GETDATE()), 
    '1995-05-05', 
    'MX', 
    1 
FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10)) AS numeros(n);
GO

-- 2. CREAR SUSCRIPCIONES (Usamos un ID de Nivel que SÍ exista en nuestra tabla)
PRINT 'Asignando suscripciones a los lurkers...';
DECLARE @idNivelReal INT = (SELECT TOP 1 id FROM NivelSuscripcion);

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_fin, precio_pactado, estado)
SELECT 
    u.id,
    @idNivelReal,
    DATEADD(MONTH, -2, GETDATE()), 
    DATEADD(MONTH, 1, GETDATE()), 
    10.00,
    'Activa'
FROM Usuario u
WHERE u.email LIKE 'lurker_pro_%'  -- Filtramos solo a los que acabamos de crear
  AND NOT EXISTS (SELECT 1 FROM Suscripcion WHERE idUsuario = u.id);
GO

-- 3. VERIFICACIÓN
PRINT '========================================';
PRINT 'LURKERS INYECTADOS EXITOSAMENTE.';
PRINT '========================================';

SELECT 
    u.nickname AS [Nickname Lurker],
    s.estado AS [Estado Suscripción],
    'Sin interacciones' AS [Estatus]
FROM Usuario u
JOIN Suscripcion s ON u.id = s.idUsuario
WHERE u.email LIKE 'lurker_pro_%';
GO



-- 13. DETALLES POR TIPO - IMÁGENES
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'INSERTANDO DETALLES DE IMÁGENES';
PRINT '========================================';
GO

-- Limpiar imágenes existentes
PRINT 'Eliminando imágenes anteriores...';
DELETE FROM Imagen;
PRINT ' Imágenes anteriores eliminadas';
GO

PRINT 'Insertando detalles de imágenes...';
GO

INSERT INTO Imagen (idPublicacion, ancho, alto, formato, alt_text, url_imagen)
SELECT 
    p.id,
    CASE ABS(CHECKSUM(NEWID())) % 4
        WHEN 0 THEN 640
        WHEN 1 THEN 1024
        WHEN 2 THEN 1920
        ELSE 3840
    END as ancho,
    CASE ABS(CHECKSUM(NEWID())) % 4
        WHEN 0 THEN 480
        WHEN 1 THEN 768
        WHEN 2 THEN 1080
        ELSE 2160
    END as alto,
    CASE ABS(CHECKSUM(NEWID())) % 3
        WHEN 0 THEN 'JPEG'
        WHEN 1 THEN 'PNG'
        ELSE 'WEBP'
    END as formato,
    LEFT(p.titulo, 100) as alt_text,
    'https://images.fanhub.com/' + CAST(p.id AS VARCHAR) + '/' + 
    REPLACE(CAST(NEWID() AS VARCHAR(36)), '-', '') + 
    CASE ABS(CHECKSUM(NEWID())) % 3
        WHEN 0 THEN '.jpg'
        WHEN 1 THEN '.png'
        ELSE '.webp'
    END as url_imagen
FROM Publicacion p
WHERE p.tipo_contenido = 'IMAGEN'
AND NOT EXISTS (SELECT 1 FROM Imagen i WHERE i.idPublicacion = p.id);

PRINT ' Imágenes insertadas correctamente';
GO


-- VERIFICAR IMÁGENES INSERTADAS
PRINT '========================================';
PRINT 'VERIFICACIÓN DE IMÁGENES:';
PRINT '========================================';

SELECT 
    COUNT(*) as TotalImagenes,
    MIN(idPublicacion) as PrimeraImagen,
    MAX(idPublicacion) as UltimaImagen,
    COUNT(DISTINCT formato) as FormatosDistintos,
    AVG(ancho) as AnchoPromedio,
    AVG(alto) as AltoPromedio
FROM Imagen;
GO

-- Ver muestra de imágenes insertadas
SELECT TOP 20
    i.idPublicacion,
    p.titulo,
    i.ancho,
    i.alto,
    i.formato,
    LEFT(i.url_imagen, 50) as url_resumida
FROM Imagen i
JOIN Publicacion p ON i.idPublicacion = p.id
ORDER BY i.idPublicacion;
GO

PRINT '========================================';
PRINT ' IMÁGENES INSERTADAS CORRECTAMENTE';
PRINT '========================================';
GO


-- 14. DETALLES POR TIPO - TEXTOS
USE FanHub_BD;
GO

PRINT '========================================';
PRINT 'INSERTANDO DETALLES DE TEXTOS';
PRINT '========================================';
GO

-- Limpiar textos existentes
PRINT 'Eliminando textos anteriores...';
DELETE FROM Texto;
PRINT ' Textos anteriores eliminados';
GO

PRINT 'Insertando detalles de textos...';
GO

INSERT INTO Texto (idPublicacion, contenido_html, resumen_gratuito)
SELECT 
    p.id,
    CASE 
        -- Textos largos para contenido exclusivo
        WHEN p.es_publica = 0 THEN 
            '<div class="contenido-exclusivo">' +
            '<h1>' + p.titulo + '</h1>' +
            '<p class="intro">' + 
            CASE ABS(CHECKSUM(NEWID())) % 5
                WHEN 0 THEN 'En este artículo exclusivo para suscriptores, exploramos en profundidad los temas más relevantes que no encontrarás en ningún otro lugar.'
                WHEN 1 THEN 'Bienvenido al contenido premium. Aquí encontrarás análisis detallados, entrevistas exclusivas y material adicional.'
                WHEN 2 THEN 'Este contenido ha sido creado especialmente para nuestros suscriptores más fieles. Disfruta de esta experiencia única.'
                WHEN 3 THEN 'Accede a material inédito, detrás de cámaras y contenido extendido que solo nuestros suscriptores pueden ver.'
                ELSE 'Gracias por ser parte de nuestra comunidad. Como agradecimiento, te compartimos este contenido exclusivo.'
            END +
            '</p>' +
            '<p>' + REPLICATE('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ', 20) + '</p>' +
            '<h2>Puntos clave</h2>' +
            '<ul>' +
            '<li>Primer punto importante sobre ' + p.titulo + '</li>' +
            '<li>Segundo aspecto fundamental a considerar</li>' +
            '<li>Tercer elemento que no puedes perderte</li>' +
            '</ul>' +
            '<p>' + REPLICATE('Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris. ', 15) + '</p>' +
            '<div class="conclusion">' +
            '<h3>Conclusión</h3>' +
            '<p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>' +
            '</div>' +
            '</div>'
        -- Textos más cortos para contenido público
        ELSE
            '<div class="contenido-publico">' +
            '<h1>' + p.titulo + '</h1>' +
            '<p class="intro">' +
            CASE ABS(CHECKSUM(NEWID())) % 5
                WHEN 0 THEN 'En este artículo gratuito, compartimos contigo información valiosa y consejos prácticos.'
                WHEN 1 THEN 'Descubre los aspectos más interesantes de este tema que hemos preparado para ti.'
                WHEN 2 THEN 'Te presentamos una visión general y los puntos más destacados de este contenido.'
                WHEN 3 THEN 'Aprende los fundamentos y conceptos básicos de una manera sencilla y directa.'
                ELSE 'Explora este contenido abierto a toda la comunidad, diseñado para inspirarte.'
            END +
            '</p>' +
            '<p>' + REPLICATE('Contenido informativo y educativo. ', 10) + '</p>' +
            '<p><strong>¿Quieres acceder al contenido completo?</strong> Suscríbete para obtener análisis detallados, ejemplos prácticos y material exclusivo.</p>' +
            '</div>'
    END as contenido_html,
    -- Resumen gratuito (solo para contenido exclusivo)
    CASE 
        WHEN p.es_publica = 0 THEN
            ' RESUMEN GRATUITO: ' + 
            CASE ABS(CHECKSUM(NEWID())) % 4
                WHEN 0 THEN 'En este artículo exclusivo hablamos sobre ' + p.titulo + '. Los suscriptores acceden al análisis completo, ejemplos detallados y casos prácticos.'
                WHEN 1 THEN 'Descubre los secretos mejor guardados de ' + p.titulo + '. Suscríbete para leer el artículo completo.'
                WHEN 2 THEN 'Este contenido premium incluye información privilegiada sobre ' + p.titulo + '. Hazte suscriptor para acceder.'
                ELSE 'Accede al contenido completo de ' + p.titulo + ' haciéndote suscriptor. Incluye análisis profundo y material adicional.'
            END
        ELSE NULL
    END as resumen_gratuito
FROM Publicacion p
WHERE p.tipo_contenido = 'TEXTO'
AND NOT EXISTS (SELECT 1 FROM Texto t WHERE t.idPublicacion = p.id);

PRINT ' Textos insertados correctamente';
GO

-- VERIFICAR TEXTOS INSERTADOS 
PRINT '========================================';
PRINT 'VERIFICACIÓN DE TEXTOS:';
PRINT '========================================';

SELECT 
    COUNT(*) as TotalTextos,
    MIN(idPublicacion) as PrimerTexto,
    MAX(idPublicacion) as UltimoTexto,
    SUM(CASE WHEN resumen_gratuito IS NOT NULL THEN 1 ELSE 0 END) as TextosConResumen,
    SUM(CASE WHEN resumen_gratuito IS NULL THEN 1 ELSE 0 END) as TextosPublicos
FROM Texto;
GO

-- Ver muestra de textos insertados 
SELECT TOP 10
    t.idPublicacion,
    p.titulo,
    p.es_publica,

    CASE 
        WHEN LEN(CAST(t.contenido_html AS VARCHAR(MAX))) > 100 
        THEN LEFT(CAST(t.contenido_html AS VARCHAR(MAX)), 100) + '...'
        ELSE CAST(t.contenido_html AS VARCHAR(MAX))
    END as contenido_resumido,
    CASE 
        WHEN t.resumen_gratuito IS NOT NULL 
        THEN CASE 
                WHEN LEN(CAST(t.resumen_gratuito AS VARCHAR(MAX))) > 100 
                THEN LEFT(CAST(t.resumen_gratuito AS VARCHAR(MAX)), 100) + '...'
                ELSE CAST(t.resumen_gratuito AS VARCHAR(MAX))
             END
        ELSE 'SIN RESUMEN (CONTENIDO PÚBLICO)' 
    END as resumen
FROM Texto t
JOIN Publicacion p ON t.idPublicacion = p.id
ORDER BY t.idPublicacion;
GO

-- Estadísticas de longitud de contenido
SELECT 
    'Longitud promedio contenido' as Concepto,
    AVG(LEN(CAST(contenido_html AS VARCHAR(MAX)))) as Valor
FROM Texto
UNION ALL
SELECT 
    'Longitud máxima contenido',
    MAX(LEN(CAST(contenido_html AS VARCHAR(MAX))))
FROM Texto
UNION ALL
SELECT 
    'Longitud mínima contenido',
    MIN(LEN(CAST(contenido_html AS VARCHAR(MAX))))
FROM Texto;

PRINT '========================================';
PRINT 'TEXTOS INSERTADOS CORRECTAMENTE';
PRINT '========================================';
GO
