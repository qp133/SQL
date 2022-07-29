use newlibrary;

-- Lấy ra các quyển sách được xuất bản bởi 'Wyman LLC'
SELECT b.*
FROM book b
INNER JOIN book_author ba ON b.id = ba.id_book
INNER JOIN author a ON ba.id_author = a.id
WHERE a.full_name = 'Wyman LLC';

-- Liệt kê tên các nhà xuất bản và số sách họ đã xuất bản
SELECT p.name, COUNT(b.id) AS number_of_book
FROM publisher p
INNER JOIN book b ON p.id = b.id_publisher
GROUP BY p.id;

-- Liệt kê id, tiêu đề, năm xuất bản của các quyển sách
-- thuộc thể loại action
SELECT b.id, b.title, b.year_of_publication AS public_year
FROM book b
INNER JOIN book_category bc ON b.id = bc.id_book
INNER JOIN category c ON bc.id_category = c.id
WHERE c.name = 'Action';

-- Đếm mỗi thể loại có bao nhiêu quyển sách
SELECT c.name, COUNT(b.id) AS number_of_book
FROM book b 
INNER JOIN book_category bc ON b.id = bc.id_book
INNER JOIN category c ON bc.id_category = c.id
GROUP BY c.id;

-- Lấy ra tên sách, năm xuất bản, tên tác giả của những quyển sách
-- được xuất bản sau năm 1900
SELECT b.title, b.year_of_publication, a.full_name AS author_name
FROM book b
INNER JOIN book_author ba ON b.id = ba.id_book
INNER JOIN author a ON ba.id_author = a.id
WHERE b.year_of_publication > 1900;


-- mượn: id, id_user, ngày mượn, id-employee
-- trả: id, id_mượn, ngày trả, id_employee
-- item-mượn: id, id_mượn, id_book, số lượng