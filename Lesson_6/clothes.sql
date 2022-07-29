-- Tạo database quản lý cửa hàng quần áo
-- Sản phẩm (bảng sản phẩm, loại mặt hàng (category), size, màu sắc, chất liệu ...)
-- Khách hàng (bảng khách hàng (id, tên KH, địa chỉ))
-- user (role: 1 - admin, 2 - quản lý sản phẩm, 3 - quản lý đơn hàng)
-- Đơn hàng (id, mã sản phẩm, mã khách hàng, ngày mua, người bán)

-- sản phẩm
-- bảng sản phẩm: id, tên sản phẩm, mô tả, id_size, id_màu sắc, id_chất liệu, id_loại mặt hàng, số lượng,
				-- nhà phân phối, 
-- loại mặt hàng: id, name
-- size: id, size_name
-- màu sắc: id, color_name
-- chất liệu: id, material_name
-- nhà phân phối: id, tên nhà phân phối, địa chỉ, số điện thoại



-- khách hàng
-- bảng khách hàng: id, tên, địa chỉ, số điện thoại
-- đăng ký tài khoản: tên, địa chỉ, số điện thoại, mật khẩu, username
-- 


-- đơn hàng
-- bảng đơn hàng: id, 


-- quản lý đơn hàng: id, mã sản phẩm, mã khách hàng, ngày mua, người bán


-- user
-- bảng user: id, tên user, chức danh (Enum: Admin, quản lý sản phẩm, quản lý đơn hàng), địa chỉ, sđt

-- FINAL
-- product: id, name, desc,  status (còn hàng, hết hàng), gender (male, female, unisex),
			-- thumbnail
            
-- size: id, name

-- product_color: id, id_product, color, thumbnail
            
-- price: id, id_product, price, start_date, end_date

-- brand: id, name, logo, desc

-- category: (male, female, kids, unisex): id, name

-- sub_category: id, id_category, name

-- Customer: id, full_name, address, mobile, email, password

-- user: id, full_name, address, mobile, email, password, role

-- order: id, id_customer, address, id_employee, create_at (date), phương thức giao hàng,
		-- phương thức thanh toán, status

-- order_item: id, id_order, id_product, amount

-- review: id_customer, id_product, point (1->5), content

-- lịch sử mua hàng: id_order, trạng thái,...

CREATE DATABASE clothes;

use clothes;

CREATE TABLE product (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('Còn hàng', 'Hết hàng'),
    gender ENUM('Male', 'Female', 'Unisex'),
    thumbnail TEXT
);

CREATE TABLE size (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE product_color (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_product INT,
    color TEXT NOT NULL,
    thumbnail TEXT NOT NULL,
    FOREIGN KEY (id_product) REFERENCES product (id)
);

CREATE TABLE price (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_product INT,
    price INT NOT NULL,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (id_product) REFERENCES product(id)
);

CREATE TABLE brand (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    logo TEXT,
    description TEXT NOT NULL
);

CREATE TABLE category (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name ENUM ('Male', 'Female', 'Kids', 'Unisex')
);

CREATE TABLE sub_category (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_category INT,
    name VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_category) REFERENCES category (id)
);

CREATE TABLE customer(
	id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(200) NOT NULL,
    address TEXT NOT NULL,
    mobile INT NOT NULL,
    email TEXT,
    password TEXT
);

CREATE TABLE user(
	id INT PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(200) NOT NULL,
    address TEXT NOT NULL,
    mobile INT NOT NULL,
    email TEXT,
    password TEXT,
    role ENUM ('Admin', 'product_management', 'order_management')
);

CREATE TABLE employee (
	id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(200) NOT NULL,
	address TEXT NOT NULL,
    mobile INT NOT NULL,
    email TEXT
);

CREATE TABLE ordered(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_customer INT,
    address TEXT NOT NULL,
    id_employee INT,
    create_at DATE NOT NULL,
    delivery_method TEXT NOT NULL,
    payment_method TEXT NOT NULL,
    status ENUM ('Đặt hàng thành công', 'Đặt hàng thất bại', 'Hủy đơn'),
    FOREIGN KEY (id_customer) REFERENCES customer(id),
    FOREIGN KEY (id_employee) REFERENCES employee(id)
);

CREATE TABLE order_item (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_order INT,
    id_product INT,
    amount INT NOT NULL,
    FOREIGN KEY (id_order) REFERENCES ordered(id),
    FOREIGN KEY (id_product) REFERENCES product(id)
);

CREATE TABLE review(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_customer INT,
    id_product INT,
    point INT NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (id_customer) REFERENCES customer(id),
    FOREIGN KEY (id_product) REFERENCES product(id)
);

-- lịch sử mua hàng: id_order, trạng thái,...
CREATE TABLE purchase_history (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_order INT,
    status ENUM ('Đã nhận hàng' ),
    FOREIGN KEY (id_order) REFERENCES ordered(id)
);