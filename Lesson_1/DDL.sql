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
    release_year INT,
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

