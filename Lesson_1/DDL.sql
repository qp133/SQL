CREATE DATABASE library;
CREATE DATABASE blog;

use library;
DROP TABLE author;
CREATE TABLE author(
	id INT PRIMARY KEY, 
    name VARCHAR(100),
    dob DATE,
    gender ENUM('male', 'female'),
    address TEXT
);

CREATE TABLE book(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    author_id INT,
    release_year YEAR,
    FOREIGN KEY (author_id) REFERENCES author(id)
);

CREATE TABLE category(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE book_category(
	id_book INT,
    id_category INT,
    PRIMARY KEY(id_book, id_category),
    FOREIGN KEY(id_book) REFERENCES book(id),
    FOREIGN KEY(id_category) REFERENCES category(id)
);

-- Thêm cột page_number vào bảng book

ALTER TABLE book
ADD page_number INT;

-- Thêm email vào bảng author
ALTER TABLE author ADD email VARCHAR(200);

-- Đổi kiểu dữ liệu của cột email sang TEXT
ALTER TABLE author MODIFY COLUMN email TEXT;

-- Xóa cột email trong bảng author
ALTER TABLE author DROP COLUMN email;

-- Bổ sung thêm ràng buộc: NOT NULL cho cột name, đổi tên cột thành fullname
ALTER TABLE author CHANGE COLUMN name fullname VARCHAR(100) NOT NULL;

-- Bổ sung khóa phụ
ALTER TABLE book ADD CONSTRAINT FOREIGN KEY (<cột muốn đặt khóa phụ>) REFERENCES tên bảng(tên cột);

ALTER TABLE category ADD CONSTRAINT UNIQUE (name);

-- insert into
INSERT INTO author (id, fullname, dob, gender, address)
VALUES (1,'Ngọc', '1996-08-19','Male','Hà Giang');

INSERT INTO author (id, fullname, dob, gender, address)
VALUES (2,'Quang', '2001-03-13','Female','Hà Nội');

INSERT INTO book (id, title, description, author_id, release_year, page_number)
VALUES (NULL, 'Cuốn theo chiều gió', 'Tiểu thuyết', 1, 1990, 200);

INSERT INTO book (id, title, description, author_id, release_year, page_number)
VALUES (NULL, 'Dế mèn phiêu lưu ký', 'Tiểu thuyết', 2, 1990, 200);

insert into author (id, fullname, dob, gender, address) values (3, 'Trev Gebb', '1993-08-22', 'Male', 'Alqueva');
insert into author (id, fullname, dob, gender, address) values (4, 'Creighton Ellacombe', '1997-06-14', 'Male', 'Chocope');
insert into author (id, fullname, dob, gender, address) values (5, 'Martino Bridges', '1999-06-02', 'Male', 'Hadabei');
insert into author (id, fullname, dob, gender, address) values (6, 'Delbert Josephy', '1992-01-23', 'Male', 'Xubu');
insert into author (id, fullname, dob, gender, address) values (7, 'Karim Paunton', '1998-08-21', 'Male', 'Täby');
insert into author (id, fullname, dob, gender, address) values (8, 'Urbano Palfreyman', '1993-01-08', 'Male', 'Shifang');
insert into author (id, fullname, dob, gender, address) values (9, 'Alisun Coutthart', '1992-11-14', 'Female', 'Xiaochuan');
insert into author (id, fullname, dob, gender, address) values (10, 'Amery McAneny', '1992-07-26', 'Male', 'Světlá nad Sázavou');
insert into author (id, fullname, dob, gender, address) values (11, 'Anderea Clampin', '1996-05-21', 'Female', 'El Cobre');
insert into author (id, fullname, dob, gender, address) values (12, 'Gipsy Vandrill', '1991-07-15', 'Female', 'Vyborg');
insert into author (id, fullname, dob, gender, address) values (13, 'Archibold Ledingham', '1992-11-07', 'Male', 'Pindaré Mirim');
insert into author (id, fullname, dob, gender, address) values (14, 'Heddie Terrell', '1991-11-01', 'Female', 'Solna');
insert into author (id, fullname, dob, gender, address) values (15, 'Reggie Camies', '1998-03-30', 'Female', 'Payabon');
insert into author (id, fullname, dob, gender, address) values (16, 'Nicholas Cartin', '1993-12-05', 'Male', 'Kahuripan');
insert into author (id, fullname, dob, gender, address) values (17, 'Drusy Waliszek', '1993-11-09', 'Female', 'Kotatengah');
insert into author (id, fullname, dob, gender, address) values (18, 'Bob Diver', '1999-02-16', 'Male', 'Monte Carmelo');
insert into author (id, fullname, dob, gender, address) values (19, 'Ivonne Kinnerk', '1991-11-12', 'Female', 'Komsomolsk');
insert into author (id, fullname, dob, gender, address) values (20, 'Syd Breadon', '1994-06-02', 'Male', 'Heyu');

