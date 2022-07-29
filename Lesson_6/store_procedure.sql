use movie_website;

SELECT COUNT(*)
FROM movie;

DELIMITER $$
CREATE PROCEDURE sp_count_movie()
BEGIN
	SELECT COUNT(*)
    FROM movie;
END$$
DELIMITER ;

CALL sp_count_movie;

DELIMITER $$
CREATE PROCEDURE sp_count_movie_by_rating(
	IN rating_input TEXT,
    OUT result INT 
) 
BEGIN
	SELECT COUNT(*) INTO result
    FROM movie
    WHERE rating = rating_input;
END $$
DELIMITER ;

CALL sp_count_movie_by_rating('PG-13', @result);
SELECT @result;

DROP PROCEDURE IF EXISTS sp_count_movie_by_rating;

-- Tạo sp lấy thông tin phim theo thể loại (tham số: thể loại)
DELIMITER $$
CREATE PROCEDURE sp_movie_by_genres(
	IN genres_input TEXT
)
BEGIN
	SELECT m.*
    FROM movie m
    INNER JOIN movie_genres mg ON m.id = mg.id_movie
    INNER JOIN genres g ON mg.id_genres = g.id
    WHERE g.name = genres_input;
END $$
DELIMITER ;

CALL sp_movie_by_genres('Action');

DROP PROCEDURE IF EXISTS sp_movie_by_genres;

-- Tạo sp đếm phim theo title_type (Tham số: title_type)
DELIMITER $$
CREATE PROCEDURE sp_count_movie_by_title_type (
	IN title_type_input TEXT
)
BEGIN
	SELECT tt.name AS title_type, COUNT(*) AS number_of_movie
    FROM movie m
    INNER JOIN title_type tt ON m.id_title_type = tt.id
    WHERE tt.name = title_type_input;
END $$
DELIMITER ;

CALL sp_count_movie_by_title_type ('Movie');

DROP PROCEDURE IF EXISTS sp_count_movie_by_title_type;

-- kiểm tra title xem có tồn tại bộ phim nào không
DELIMITER $$
CREATE PROCEDURE sp_found_movie (
	IN title_input TEXT,
    OUT result TEXT
)
BEGIN
	DECLARE count_movie INT;		-- Khai báo biến count_movie
    SELECT count(*) INTO count_movie
    FROM movie 
    WHERE title LIKE title_input;
	
    IF count_movie = 0 THEN
		SET result = 'Không tìm thấy phim';
	ELSE
		SET result = CONCAT('Tìm thấy ', count_movie);
	END IF;
END $$
DELIMITER ;

CALL sp_found_movie('Jet Pilot', @rs);
SELECT @rs;

DROP PROCEDURE sp_found_movie;

-- Đếm phim theo quốc gia
-- Nếu quốc gia đó không có phim nào -> Thông báo không tìm thấy
-- Nếu có -> Liệt kê số lượng phim của quốc gia đó
DELIMITER $$
CREATE PROCEDURE sp_found_nation(
	IN nation_input TEXT,
    OUT result TEXT
)
BEGIN
	DECLARE count_movie_by_nation INT;
    SELECT COUNT(*) INTO count_movie_by_nation
    FROM movie m
    INNER JOIN movie_nation mn ON m.id = mn.id_movie
    INNER JOIN nation n ON mn.id_nation = n.id
    WHERE n.name LIKE nation_input;
    
    IF count_movie_by_nation = 0 THEN
		SET result = 'Không tìm thấy bộ phim nào theo quốc gia này';
	ELSE
		SET result = CONCAT('Quốc gia có ', count_movie_by_nation, ' bộ phim');
	END IF;
END $$
DELIMITER ;

CALL sp_found_nation('Malaysia', @rs);
SELECT @rs;

DROP PROCEDURE sp_found_nation;