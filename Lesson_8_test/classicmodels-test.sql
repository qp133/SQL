use classicmodels;

-- Liệt kê tên các văn phòng theo tên thành phố và số lượng nhân viên thuộc các văn phòng đó
SELECT o.city, COUNT(e.employeeNumber) AS numbers_of_employees 
FROM offices o
INNER JOIN employees e ON o.officeCode = e.officeCode
GROUP BY city;

-- Liệt kê nước nào có số lượng văn phòng nhiều nhất
SELECT country, COUNT(country) AS numbers_of_offices
FROM offices
WHERE country = (
	SELECT MAX(country)
    FROM offices
);

-- Liệt kê tình trạng các đơn hàng và số lượng đơn hàng thuộc tình trạng đó
SELECT status, COUNT(status) AS numbers_of_orders
FROM orders
GROUP BY status;

-- Liệt kê productLine và số lượng sản phẩm thuộc các line đó
SELECT pl.productLine, COUNT(p.productLine) AS numbers_of_productLine
FROM productLines pl
INNER JOIN products p ON pl.productLine = p.productLine
GROUP BY pl.productLine;

-- Liệt kê thông tin những đơn hàng bị hủy gồm: id đơn hàng, id khách hàng, tên khách hàng, orderDate,
-- requireDate, nguyên nhân đơn hàng bị hủy (comment)
SELECT o.orderNumber, o.customerNumber, c.customerName, o.orderDate, o.requiredDate, o.comments
FROM orders o
INNER JOIN customers c ON o.customerNumber = c.customerNumber
WHERE o.status LIKE '%Cancelled%';

-- Liệt kê id đơn hàng, id khách hàng, tên khách hàng, orderDate, requireDate, sản phẩm (id, tên, số lượng),
-- comment của đơn hàng có id 10165
SELECT o.orderNumber, o.customerNumber, c.customerName, o.orderDate, o.requiredDate,
	p.productCode, p.productName, od.quantityOrdered, o.comments
FROM orders o
INNER JOIN customers c ON o.customerNumber = c.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products p ON od.productCode = p.productCode
WHERE o.orderNumber = 10165;

-- Liệt kê thông tin các nhân viên thực hiện công việc Sales Rep làm việc ở văn phòng San Francisco
SELECT e.*, o.city
FROM employees e
INNER JOIN offices o ON e.officeCode = o.officeCode
WHERE e.jobTitle LIKE '%Sales Rep%' AND o.city LIKE '%San Francisco%';

-- Liệt kê thông tin 5 khách hàng order nhiều nhất
SELECT c.*, COUNT(o.customerNumber) AS max_order
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY customerNumber
ORDER BY max_order DESC
LIMIT 5;
    
-- Tạo store procedure lấy ra thông tin id đơn hàng, id khách hàng, tên khách hàng, orderDate,
-- requireDate, shippedDate, sản phẩm (id, tên, số lượng), comment, với tham số truyền vào là status
DELIMITER $$
CREATE PROCEDURE orders_products(
	IN status_input TEXT
)
BEGIN 
	SELECT o.orderNumber, o.customerNumber, c.customerName, o.orderDate, o.requiredDate, o.shippedDate,
			p.productCode, p.productName,  od.quantityOrdered, o.comments
	FROM orders o
    INNER JOIN customers c ON o.customerNumber = c.customerNumber
	INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
	INNER JOIN products p ON od.productCode = p.productCode
    WHERE o.status = status_input;
END $$
DELIMITER ;

CALL orders_products('Shipped');