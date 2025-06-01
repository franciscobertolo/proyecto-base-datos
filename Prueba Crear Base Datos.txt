-- Crear Base Datos
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