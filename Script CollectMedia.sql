Plataforma-- ¡¡¡Crear Base Datos!!!
DROP DATABASE IF EXISTS CollectMedia;
CREATE DATABASE IF NOT EXISTS CollectMedia;
USE CollectMedia;

-- Tabla Usuario
CREATE TABLE Usuario (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Tabla Plataforma
CREATE TABLE Plataforma (
    plataforma_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_plataforma VARCHAR(100) NOT NULL
);

-- Tabla Genero
CREATE TABLE Genero (
    genero_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_genero VARCHAR(100) NOT NULL,
    tipo_media VARCHAR(50) NOT NULL
);

-- Tabla Media
CREATE TABLE Media (
    media_id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    tipo_media VARCHAR(50) NOT NULL,
    fecha_publicacion DATE,
    plataforma_id INT,
    FOREIGN KEY (plataforma_id) REFERENCES Plataforma(plataforma_id)
);

-- Tabla Opinion
CREATE TABLE Opinion (
    opinion_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    media_id INT,
    numero_estrellas INT CHECK (numero_estrellas BETWEEN 1 AND 5),
    comentario TEXT,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (media_id) REFERENCES Media(media_id)
);

-- Tabla Coleccion
CREATE TABLE Coleccion (
    coleccion_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    media_id INT,
    fecha_agregado DATE,
    opinion_id INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (media_id) REFERENCES Media(media_id),
    FOREIGN KEY (opinion_id) REFERENCES Opinion(opinion_id)
);

-- Tabla Videojuego
CREATE TABLE Videojuego (
    videojuego_id INT PRIMARY KEY AUTO_INCREMENT,
    media_id INT,
    plataforma_id INT,
    genero_id INT,
    FOREIGN KEY (media_id) REFERENCES Media(media_id),
    FOREIGN KEY (plataforma_id) REFERENCES Plataforma(plataforma_id),
    FOREIGN KEY (genero_id) REFERENCES Genero(genero_id)
);

-- Tabla TV
CREATE TABLE TV (
    tv_id INT PRIMARY KEY AUTO_INCREMENT,
    media_id INT,
    genero_id INT,
    total_episodios INT,
    total_temporadas INT,
    FOREIGN KEY (media_id) REFERENCES Media(media_id),
    FOREIGN KEY (genero_id) REFERENCES Genero(genero_id)
);

-- Tabla Anime
CREATE TABLE Anime (
    anime_id INT PRIMARY KEY AUTO_INCREMENT,
    media_id INT,
    genero_id INT,
    total_episodios INT,
    total_temporadas INT,
    FOREIGN KEY (media_id) REFERENCES Media(media_id),
    FOREIGN KEY (genero_id) REFERENCES Genero(genero_id)
);

-- Tabla Pelicula
CREATE TABLE Pelicula (
    pelicula_id INT PRIMARY KEY AUTO_INCREMENT,
    media_id INT,
    director VARCHAR(100),
    genero_id INT,
    FOREIGN KEY (media_id) REFERENCES Media(media_id),
    FOREIGN KEY (genero_id) REFERENCES Genero(genero_id)
);

-- Tabla Episodio
CREATE TABLE Episodio (
    numero_episodio INT,
    media_id INT,
    numero_temporada INT,
    PRIMARY KEY (numero_episodio, media_id, numero_temporada),
    FOREIGN KEY (media_id) REFERENCES Media(media_id)
);

-- ¡¡¡Funciones!!!
-- a) Calcular el promedio de calificaciones para un medio:

DELIMITER //
CREATE FUNCTION calcular_promedio_calificaciones(media_id_param INT) 
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
    DECLARE avg_rating DECIMAL(3,2);
    SELECT AVG(numero_estrellas) INTO avg_rating
    FROM Opinion
    WHERE media_id = media_id_param;
    RETURN avg_rating;
END;
//
DELIMITER ;

-- b) Obtener el número total de medios en la colección de un usuario:
DELIMITER //
CREATE FUNCTION total_medios_usuario(usuario_id_param INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Coleccion
    WHERE usuario_id = usuario_id_param;
    RETURN total;
END;
//
DELIMITER ;

-- ¡¡¡Procedimientos!!!
-- a) Agregar un nuevo medio a la colección de un usuario:

DELIMITER //
CREATE PROCEDURE agregar_a_coleccion(
    IN p_usuario_id INT,
    IN p_media_id INT,
    IN p_fecha_agregado DATE
)
BEGIN
    INSERT INTO Coleccion (usuario_id, media_id, fecha_agregado)
    VALUES (p_usuario_id, p_media_id, p_fecha_agregado);
END;
//
DELIMITER ;

-- b) Actualizar la información de un medio:

DELIMITER //
CREATE PROCEDURE actualizar_media(
    IN p_media_id INT,
    IN p_titulo VARCHAR(255),
    IN p_fecha_publicacion DATE,
    IN p_plataforma_id INT
)
BEGIN
    UPDATE Media
    SET titulo = p_titulo,
        fecha_publicacion = p_fecha_publicacion,
        plataforma_id = p_plataforma_id
    WHERE media_id = p_media_id;
END;
//
DELIMITER ;

-- ¡¡¡Triggers!!!

-- a) Verificar que la fecha de publicación no sea futura al insertar un nuevo medio:

DELIMITER //
CREATE TRIGGER check_fecha_publicacion
BEFORE INSERT ON Media
FOR EACH ROW
BEGIN
    IF NEW.fecha_publicacion > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de publicación no puede ser futura';
    END IF;
END;
//
DELIMITER ;

-- b) Actualizar automáticamente la fecha de agregado en la colección cuando se inserta una nueva opinión:

DELIMITER //
CREATE TRIGGER actualizar_fecha_coleccion
AFTER INSERT ON Opinion
FOR EACH ROW
BEGIN
    UPDATE Coleccion
    SET fecha_agregado = CURDATE()
    WHERE usuario_id = NEW.usuario_id AND media_id = NEW.media_id;
END;
//
DELIMITER ;

-- c) Verificar que el número de estrellas esté entre 1 y 5 al insertar o actualizar una opinión:

DELIMITER //
CREATE TRIGGER check_numero_estrellas
BEFORE INSERT ON Opinion
FOR EACH ROW
BEGIN
    IF NEW.numero_estrellas < 1 OR NEW.numero_estrellas > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El número de estrellas debe estar entre 1 y 5';
    END IF;
END;
//
DELIMITER ;

-- ¡¡Inserts!!
-- Plataformas
INSERT INTO Plataforma (nombre_plataforma) VALUES 
('Netflix'),
('PlayStation 5'),
('Steam'),
('HBO Max'),
('Crunchyroll');

-- Géneros
INSERT INTO Genero (nombre_genero, tipo_media) VALUES 
('Acción', 'videojuego'),
('Drama', 'tv'),
('Aventura', 'anime'),
('Ciencia Ficción', 'pelicula'),
('RPG', 'videojuego');

-- Media
-- Videojuegos
INSERT INTO Media (titulo, tipo_media, fecha_publicacion, plataforma_id) VALUES
('The Last of Us', 'videojuego', '2013-06-14', 2),
('God of War', 'videojuego', '2018-04-20', 2),
('Elden Ring', 'videojuego', '2022-02-25', 3);

INSERT INTO Videojuego (media_id, plataforma_id, genero_id) VALUES
(1, 2, 1),
(2, 2, 1),
(3, 3, 5);

-- Series de TV
INSERT INTO Media (titulo, tipo_media, fecha_publicacion, plataforma_id) VALUES
('Breaking Bad', 'tv', '2008-01-20', 1),
('Game of Thrones', 'tv', '2011-04-17', 4),
('The Wire', 'tv', '2002-06-02', 4);

INSERT INTO TV (media_id, genero_id, total_episodios, total_temporadas) VALUES
(4, 2, 62, 5),
(5, 2, 73, 8),
(6, 2, 60, 5);

-- Anime
INSERT INTO Media (titulo, tipo_media, fecha_publicacion, plataforma_id) VALUES
('Attack on Titan', 'anime', '2013-04-07', 5),
('Death Note', 'anime', '2006-10-03', 5),
('One Piece', 'anime', '1999-10-20', 5);

INSERT INTO Anime (media_id, genero_id, total_episodios, total_temporadas) VALUES
(7, 3, 75, 4),
(8, 3, 37, 1),
(9, 3, 1000, 20);

-- Películas
INSERT INTO Media (titulo, tipo_media, fecha_publicacion, plataforma_id) VALUES
('Inception', 'pelicula', '2010-07-16', 1),
('The Matrix', 'pelicula', '1999-03-31', 1),
('Interstellar', 'pelicula', '2014-11-07', 1);

INSERT INTO Pelicula (media_id, director, genero_id) VALUES
(10, 'Christopher Nolan', 4),
(11, 'Lana y Lilly Wachowski', 4),
(12, 'Christopher Nolan', 4);

-- Consultas de prueba
-- 1. Mostrar todos
SELECT m.titulo, m.tipo_media, p.nombre_plataforma
FROM Media m
JOIN Plataforma p ON m.plataforma_id = p.plataforma_id
ORDER BY m.tipo_media, m.titulo;

-- 2. Encontrar todas las películas dirigidas por Christopher Nolan
SELECT m.titulo, p.director, m.fecha_publicacion
FROM Media m
JOIN Pelicula p ON m.media_id = p.media_id
WHERE p.director LIKE '%Nolan%';

-- 3. Contar cuántos medios hay de cada tipo
SELECT tipo_media, COUNT(*) as total
FROM Media
GROUP BY tipo_media
ORDER BY total DESC;

-- 4. Mostrar todos los videojuegos con su género y plataforma
SELECT m.titulo, g.nombre_genero, p.nombre_plataforma
FROM Media m
JOIN Videojuego v ON m.media_id = v.media_id
JOIN Genero g ON v.genero_id = g.genero_id
JOIN Plataforma p ON m.plataforma_id = p.plataforma_id
WHERE m.tipo_media = 'videojuego'
ORDER BY m.titulo;

-- Pruebas funciones y esas cosas

-- Usuarios para las pruebas
INSERT INTO Usuario (nombre, email, password) VALUES
('Juan Pérez', 'juan@email.com', 'password123'),
('María García', 'maria@email.com', 'password456');

-- Opiniones para las pruebas
INSERT INTO Opinion (usuario_id, media_id, numero_estrellas, comentario) VALUES
(1, 1, 5, '¡Excelente juego!'),
(2, 1, 4, 'Muy bueno'),
(1, 2, 3, 'Regular');

-- funcion
SELECT titulo, calcular_promedio_calificaciones(1) as promedio
FROM Media
WHERE media_id = 1;

-- prueba 2
-- inserts
INSERT INTO Coleccion (usuario_id, media_id, fecha_agregado) VALUES
(1, 1, CURDATE()),
(1, 2, CURDATE()),
(1, 3, CURDATE());

-- prueba
SELECT nombre, total_medios_usuario(1) as total_medios
FROM Usuario
WHERE usuario_id = 1;

-- prueba 3
CALL agregar_a_coleccion(2, 4, CURDATE());

-- comprobar
SELECT * FROM Coleccion WHERE usuario_id = 2;

-- prueba 4
CALL actualizar_media(1, 'The Last of Us Remasterizado', '2014-07-29', 2);

-- comprobacion
SELECT * FROM Media WHERE media_id = 1;

-- prueba fallo trigger
-- fecha a futuro no debe de funcionar
INSERT INTO Media (titulo, tipo_media, fecha_publicacion, plataforma_id)
VALUES ('Juego Futuro', 'videojuego', '2027-01-01', 1);

-- prueba estrellas
-- no debe de funcionar, limitado a 5
INSERT INTO Opinion (usuario_id, media_id, numero_estrellas, comentario)
VALUES (1, 1, 6, 'Demasiadas estrellas');

-- prueba 7
-- fecha antigua
INSERT INTO Coleccion (usuario_id, media_id, fecha_agregado)
VALUES (1, 5, '2023-01-01');

-- agregamos opinion
INSERT INTO Opinion (usuario_id, media_id, numero_estrellas, comentario)
VALUES (1, 5, 4, 'Muy buena serie');

-- fecha actualizada
SELECT * FROM Coleccion WHERE usuario_id = 1 AND media_id = 5;