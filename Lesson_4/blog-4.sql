use blog;

SELECT title, full_name
FROM post p INNER JOIN users u
ON p.id_user = u.id;

SELECT title, full_name
FROM post p LEFT JOIN users u
ON p.id_user = u.id;

SELECT title, full_name
FROM post p RIGHT JOIN users u
ON p.id_user = u.id;

-- Union
SELECT title, full_name
FROM post p LEFT JOIN users u
ON p.id_user = u.id
UNION
SELECT title, full_name
FROM post p RIGHT JOIN users u
ON p.id_user = u.id;

-- Lấy ra id, title, content, comment (id_user, content, create_at)
-- của bài post có id 2
SELECT p.id, p.title, p.content, d.id_user, d.content AS comment, d.create_at
FROM post p INNER JOIN discuss d
ON p.id_user = d.id_user
WHERE p.id = 2;