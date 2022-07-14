CREATE DATABASE blog;

use blog;
CREATE TABLE users(
	id INT PRIMARY KEY,
    email VARCHAR(200) NOT NULL,
    password TEXT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    avatar TEXT,
    status ENUM('active','disable')
);

CREATE TABLE category(
	id INT PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE post(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    content TEXT NOT NULL,
    thumbnail TEXT,
    id_category INT,
    id_user INT,
	create_at DATE,
    status ENUM('public','hidden','draft'),
    FOREIGN KEY (id_category) REFERENCES category(id),
    FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE RESTRICT
);

CREATE TABLE tag(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE discuss(
	id INT PRIMARY KEY,
    id_post INT,
    id_user INT,
    FOREIGN KEY(id_post) REFERENCES post(id) ON DELETE CASCADE, 
    FOREIGN KEY(id_user) REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    create_at DATE
);

CREATE TABLE post_tag(
	id_post INT,
    id_tag INT,
    PRIMARY KEY(id_post, id_tag),
    FOREIGN KEY (id_post) REFERENCES post(id),
    FOREIGN KEY (id_tag) REFERENCES tag(id)
);
	
