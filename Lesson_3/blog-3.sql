use blog;

SELECT *
FROM post;

SELECT title, content
FROM post;

SELECT id, title, description, thumbnail, create_at
FROM post;

-- Lấy tất cả thông tin của user
SELECT *
FROM users;

-- Lấy ra email, password, full_name của user
SELECT email, password, full_name
FROM users;

-- Lấy ra tất cả thông tin của user có trạng thái active
SELECT *
FROM users
WHERE status = 'active';

-- Lấy ra những bài viết có trạng thái public
SELECT *
FROM post
WHERE status = 'public';

SELECT *
FROM post
WHERE title LIKE '%e';

SELECT NOW();

-- Lấy ra các bài viết được viết vào ngày hôm nay
SELECT *
FROM post
WHERE create_at = current_date();

-- Cập nhật ngày giờ hôm nay cho các bài viết có id_user = 10 
UPDATE post
SET create_at = current_date()
WHERE id_user = 10;

-- bài viết vào ngày hôm nay và trạng thái là public
SELECT *
FROM post
WHERE create_at = current_date()
AND status = 'public';

-- lấy ra các bài viết có trạng thái public HOẶC hidden
SELECT *
FROM post
WHERE (status = 'public' OR status = 'hidden')
AND title LIKE '%the%';
-- kết hợp thêm điều kiện AND

-- Lấy ra toàn bộ user có full_name có chữ A đứng đầu
-- và có trạng thái là active
SELECT *
FROM users
WHERE full_name LIKE 'A%' 
AND status = 'active';