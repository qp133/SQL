use movie_website;

-- Tìm các bộ phim có điểm imdb lớn hơn trung bình cộng điểm imdb
SELECT AVG(imdb)
FROM movie ;

SELECT *
FROM movie
WHERE imdb > (
	SELECT AVG(imdb)
	FROM movie 
);

-- Lấy ra bộ phim có độ dài lớn hơn trung bình cộng độ dài tất cả các phim
SELECT m.*
FROM movie m, (SELECT AVG(length) AS avg_length FROM movie) s
WHERE m.length > s.avg_length;

SELECT m.id, m.title, m.length,
		(SELECT AVG(length) AS avg_length FROM movie) AS avg_length
FROM movie m;


-- Cách 1
SELECT m.* 
FROM movie m
INNER JOIN title_type tt ON m.id_title_type = tt.id
WHERE t.name = 'Movie';

-- Cách 2
SELECT id
FROM title_type
WHERE name = 'Movie';

SELECT *
FROM movie 
WHERE id_title_type = (
	SELECT id
	FROM title_type
	WHERE name = 'Movie'
);

-- Lấy ra những bộ phim có điểm imdb cao nhất 
SELECT m.*
FROM movie m
WHERE imdb = (
	SELECT MAX(imdb)
    FROM movie
);

-- Lấy ra những bộ phim có thời lượng dài nhất
SELECT m.*
FROM movie m
WHERE length = (
	SELECT MAX(length)
    FROM movie
);

-- Lấy ra đạo diễn tham gia nhiều bộ phim nhất

-- bước 1
SELECT id_director, COUNT(id) AS movie_number
FROM movie
GROUP BY id_director
ORDER BY movie_number DESC;

-- bước 2
SELECT MAX(movie_number)
FROM (
	SELECT COUNT(id) AS movie_number
	FROM movie
	GROUP BY id_director) AS sub_movie;
    
-- bước 3
SELECT id_director, movie_number
FROM (
	SELECT id_director, COUNT(id) AS movie_number
	FROM movie
	GROUP BY id_director) AS sub_movie
WHERE movie_number = (
	SELECT MAX(movie_number)
	FROM (
		SELECT COUNT(id) AS movie_number
		FROM movie
		GROUP BY id_director) AS sub_movie
);

-- bước 4
SELECT *
FROM director
WHERE id IN (
	SELECT id_director
	FROM (
		SELECT id_director, COUNT(id) AS movie_number
		FROM movie
		GROUP BY id_director ) AS sub_movie
	WHERE movie_number = (
		SELECT MAX(movie_number)
		FROM (
			SELECT COUNT(id) AS movie_number
			FROM movie
			GROUP BY id_director) AS sub_movie)
);