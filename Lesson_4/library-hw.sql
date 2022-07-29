-- DATABASE library
use newlibrary;

-- Lấy thông tin tất cả các quyển sách thuộc thể loại Comedy hoặc Drama
SELECT *
FROM book b
INNER JOIN book_category bc ON b.id = bc.id_book
INNER JOIN category c ON bc.id_category = c.id
WHERE c.name IN ('Comedy', 'Drama');

-- Lấy ra id_book, title, author, category của quyển sách được xuất bản từ năm 1800 đến 1900
SELECT b.id, b.title, a.full_name AS author, c.name AS category
FROM book b
INNER JOIN book_author ba ON b.id = ba.id_book
INNER JOIN author a ON ba.id_author = a.id
INNER JOIN book_category bc ON b.id = bc.id_book
INNER JOIN category c ON bc.id_category = c.id
WHERE b.year_of_publication BETWEEN 1800 AND 1900;

-- Đếm số sách dựa theo nhà xuất bản
-- (Hiển thị tên nhà xuất bản và số sách thuộc nhà xuất bản đó)
SELECT p.name AS pulisher, COUNT(b.id) AS numbers_of_book
FROM publisher p
INNER JOIN book b ON p.id = b.id_publisher
GROUP BY p.id;

-- DATABASE movie_website
use movie_website;

-- Lấy ra tên phim, title_type, năm công chiếu, rating, điểm imdb, thời lượng, thể loại (mảng),
-- tên đạo diễn , tên diễn viên (mảng) 
-- của phim có id = 1
SELECT m.title, m.release_date, m.rating, m.imdb, m.length, 
	tt.name AS title_type, d.full_name AS director, a.full_name AS actor 
FROM movie m
INNER JOIN title_type tt ON m.id_title_type = tt.id
INNER JOIN director d ON m.id_director = d.id
INNER JOIN movie_actor ma ON m.id = ma.id_movie
INNER JOIN actor a ON ma.id_actor = a.id
WHERE m.id = 1;

-- Lấy ra 5 dữ liệu: tên phim, mô tả, số tập, số tập đã chiếu, thể loại(mảng), đạo diễn, poster,
-- rating , điểm imdb của phim có thể loại TV Series, sắp xếp theo điểm giảm dần
SELECT m.title, m.description, m.episode, m.current_episode, tt.name AS title_type, 
	 d.full_name AS director, m.poster, m.rating, m.imdb
FROM movie m
INNER JOIN title_type tt ON m.id_title_type = tt.id
INNER JOIN director d ON m.id_director = d.id
WHERE tt.name = 'TV Series'
ORDER BY m.imdb DESC;

-- Lấy ra tiêu đề, poster, năm công chiếu, của các bộ phim có diễn viên ‘Oralie Harrowing’ tham gia
SELECT m.title, m.poster, m.release_date
FROM movie m
INNER JOIN movie_actor ma ON m.id = ma.id_movie
INNER JOIN actor a ON ma.id_actor = a.id
WHERE a.full_name = 'Oralie Harrowing';

-- Lấy ra thông tin diễn viên (tên, mô tả, ảnh, ngày sinh, nơi sinh)
-- và các phim mà diễn viên đó đã tham gia (tên phim, năm công chiếu) của diễn viên ‘Oralie Harrowing’
SELECT a.full_name, a.description, a.avatar, a.date_of_birth AS DOB, a.place_of_birth AS POB,
	JSON_ARRAYAGG(JSON_OBJECT(m.title, m.release_date)) AS movie
FROM actor a
INNER JOIN movie_actor ma ON a.id = ma.id_actor
INNER JOIN movie m ON ma.id_movie = m.id
WHERE a.full_name = 'Oralie Harrowing';