CREATE DATABASE customer;
use customer;

CREATE TABLE users(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL,
    password TEXT NOT NULL
);

INSERT INTO users(id, user_name, email, password)
VALUES (null, 'ngoc', 'ngoc@gmail.com', '123456789');

SELECT * FROM users;

SELECT *
FROM users
WHERE id = ?;