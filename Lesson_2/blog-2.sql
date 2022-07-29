-- Cập nhật dữ liệu
UPDATE author
SET address = 'Tuyên Quang'
WHERE id = 2;

UPDATE author
SET gender = 'Male', address = 'Hà Nội'
WHERE id = 2;

-- Xóa dữ liệu
DELETE FROM category 
WHERE name = 'Adventure';

DELETE FROM author
WHERE id = 1;



insert into category (id, name) values (1, 'Comedy');
insert into category (id, name) values (2, 'Musical');
insert into category (id, name) values (3, 'Action');
insert into category (id, name) values (4, 'Drama');
insert into category (id, name) values (5, 'Horror');
insert into category (id, name) values (6, 'War');
insert into category (id, name) values (7, 'Romance');
insert into category (id, name) values (8, 'Mystery');
insert into category (id, name) values (9, 'Children');
insert into category (id, name) values (10, 'Animation');


