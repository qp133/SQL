use newlibrary;
CREATE TABLE borrow (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_reader INT NOT NULL,
    id_employee INT NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (id_reader) REFERENCES reader(id),
    FOREIGN KEY (id_employee) REFERENCES employee(id)
);

INSERT INTO borrow(id, id_reader, id_employee, date)
VALUES (NULL, 196156160, 196156140, '2022-07-12');

INSERT INTO borrow(id, id_reader, id_employee, date)
VALUES (NULL, 196156161, 196156140, '2022-07-17');

INSERT INTO borrow(id, id_reader, id_employee, date)
VALUES (NULL, 196156162, 196156140, '2022-07-22');

INSERT INTO borrow(id, id_reader, id_employee, date)
VALUES (NULL, 196156162, 196156140, '2022-06-12');

SELECT id, DATEDIFF(CURRENT_DATE(), date)
FROM borrow
WHERE datediff(current_date(), date) > 7
AND id NOT IN (
	SELECT id_borrow
	FROM return_book
);

-- Tìm thông tin những người mượn sách quá hạn mà chưa trả sách
SELECT b.id AS id_borrow, DATEDIFF(CURRENT_DATE(), date) AS overdue_day, r.*
FROM borrow b
INNER JOIN reader r ON b.id_reader = r.id
WHERE datediff(current_date(), date) > 7
AND b.id NOT IN (
	SELECT id_borrow
	FROM return_book
);

CREATE TABLE item_borrow(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_borrow INT NOT NULL,
    id_book INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (id_borrow) REFERENCES borrow(id),
    FOREIGN KEY (id_book) REFERENCES book(id)
);

CREATE TABLE return_book(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_borrow INT NOT NULL,
    date DATE NOT NULL,
    id_employee INT NOT NULL,
    FOREIGN KEY (id_borrow) REFERENCES borrow(id),
    FOREIGN KEY (id_employee) REFERENCES employee(id)
);

INSERT INTO return_book (id, id_borrow, date, id_employee)
VALUES (null, 4, '2022-06-18', 196156140);

