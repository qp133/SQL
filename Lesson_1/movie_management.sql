CREATE DATABASE movie_management;

use movie_management;

CREATE TABLE director(
	id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE movie(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    length INT,
    rating ENUM('G','PG','PG-13','R','NC-17','NR'),
    poster TEXT,
    studio TEXT,
    status ENUM('public', 'hidden'),
    release_date DATE,
    id_director INT,
    FOREIGN KEY (id_director) REFERENCES director(id)
);

CREATE TABLE category(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE movie_category(
	id_movie INT,
    id_category INT,
    PRIMARY KEY(id_movie, id_category),
    FOREIGN KEY (id_movie) REFERENCES movie(id),
    FOREIGN KEY (id_category) REFERENCES category(id)
);

CREATE TABLE format(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name ENUM('2D','3D','4DX','IMAX','SCREENX')
);

CREATE TABLE movie_format(
	id_movie INT,
    id_format INT,
    PRIMARY KEY (id_movie, id_format),
    FOREIGN KEY (id_movie) REFERENCES movie(id),
    FOREIGN KEY (id_format) REFERENCES format(id)
);

CREATE TABLE actor(
	id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(200) NOT NULL
);

CREATE TABLE movie_actor(
	id_movie INT,
    id_actor INT,
    PRIMARY KEY(id_movie, id_actor),
    FOREIGN KEY (id_movie) REFERENCES movie(id),
    FOREIGN KEY (id_actor) REFERENCES actor(id)
);

CREATE TABLE language(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL
);

CREATE TABLE movie_language(
	id_movie INT,
    id_language INT,
    PRIMARY KEY(id_movie, id_language),
    FOREIGN KEY (id_movie) REFERENCES movie(id),
    FOREIGN KEY (id_language) REFERENCES language(id)
);

CREATE TABLE trailer(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_movie INT,
    link TEXT,
    FOREIGN KEY (id_movie) REFERENCES movie(id)
);