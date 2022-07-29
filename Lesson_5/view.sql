-- id sách, title, image, tên nhà xuất bản, tên tác giả (mảng)
CREATE OR REPLACE VIEW book_author_publisher AS 
SELECT b.id, b.title, b.image, p.name AS publisher_name, JSON_ARRAYAGG(a.full_name) AS authors
FROM book b
INNER JOIN publisher p ON b.id_publisher = p.id
INNER JOIN book_author ba ON b.id = ba.id_book
INNER JOIN author a ON ba.id_author = a.id
GROUP BY b.id;


-- Lấy ra những quyển sách có nhà xuất bản là tên 'abc...'
SELECT id, title
FROM book_author_publisher
WHERE publisher_name = 'Wyman LLC';

use movie_website;
-- id, title, poster, năm công chiếu, thể loại (mảng), title_type
CREATE OR REPLACE VIEW movie_genres_titletype AS
SELECT m.id, m.title, m.poster, m.release_date,
	JSON_ARRAYAGG(g.name) AS genres, tt.name AS title_type
FROM movie m
INNER JOIN movie_genres mg ON m.id = mg.id_movie
INNER JOIN genres g ON mg.id_genres = g.id
INNER JOIN title_type tt ON m.id_title_type = tt.id
GROUP BY m.id;

-- Lấy ra id, title, năm công chiếu, thể loại
-- của các phim có title_type là Movie, được công chiếu trong năm nay
SELECT id, title, release_date, genres
FROM movie_genres_titletype
WHERE title_type = 'Movie' 
AND year(release_date) = year(current_date());

-- Lấy ra id, tiêu đề, thể loại, năm công chiếu
-- của các phim có thể loại là Action
SELECT id, title, genres, release_date
FROM movie_genres_titletype
WHERE genres LIKE '%Action%';
