use movie_website;

-- Lấy ra title, description, length, rating, release_date
-- của các bộ phim có thể loại là Action
SELECT title, description, length, rating, release_date
FROM movie m INNER JOIN movie_genres mg ON m.id = mg.id_movie
INNER JOIN genres g ON mg.id_genres = g.id
WHERE g.name = 'Action';

-- Lấy ra title, description, length, rating, release_date
-- của các phim thuộc loại Movie (title-type)
SELECT title, description, length, rating, release_date
FROM movie m INNER JOIN title_type tt
ON m.id_title_type = tt.id
WHERE tt.name = 'Movie';

-- Lấy ra title, description, release_date, full_name (actor), name (genres)
-- của bộ phim có id = 3
SELECT m.title, m.description, m.release_date, a.full_name AS fullname_actor, g.name AS genres_name
FROM movie m
INNER JOIN movie_actor ma ON m.id = ma.id_movie
INNER JOIN actor a ON ma.id_actor = a.id 
INNER JOIN movie_genres mg ON mg.id_movie = m.id 
INNER JOIN genres g ON g.id = mg.id_genres
WHERE m.id = 3;


-- Gom giá trị thành 1 mảng
SELECT m.title, m.description, m.release_date, JSON_ARRAYAGG(a.full_name) AS fullname_actor
FROM movie m
INNER JOIN movie_actor ma ON m.id = ma.id_movie
INNER JOIN actor a ON ma.id_actor = a.id 
WHERE m.id = 3;

-- Gom thành 1 đối tượng
SELECT m.title, m.description, m.release_date,
JSON_ARRAYAGG(JSON_OBJECT('id', a.id, 'name', a.full_name)) AS fullname_actor
FROM movie m
INNER JOIN movie_actor ma ON m.id = ma.id_movie
INNER JOIN actor a ON ma.id_actor = a.id 
WHERE m.id = 3;

-- Lấy ra title, description, genres (trả về 1 mảng)
-- của phim có rating là PG
SELECT m.title, m.description, JSON_ARRAYAGG(g.name)
FROM movie m
INNER JOIN movie_genres mg ON m.id = mg.id_movie
INNER JOIN genres g ON mg.id_genres = g.id
WHERE m.rating = 'PG';