CREATE DATABASE InventoryAndOrder;

-- Create the products table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Create the customers table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create the orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    order_date DATE NOT NULL
);

-- Create the order_items table
CREATE TABLE order_items (
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

-- Insert data into the products table
INSERT INTO products (product_name, price, stock_quantity)
VALUES
('Laptop', 1200.00, 10),
('Smartphone', 800.00, 20),
('Headphones', 150.00, 50),
('Keyboard', 50.00, 100),
('Mouse', 30.00, 200);

-- Insert data into the customers table
INSERT INTO customers (first_name, last_name, email)
VALUES
('Mo', 'Abdul', 'moabdul@icloud.com'),
('Johnny', 'Smart', 'jsmart@yahoo.com'),
('Alice', 'Johnson', 'alice.johnson@gmail.com'),
('Yemi', 'Brown', 'yemibrown@gmail.com');

-- Insert data into the orders table
INSERT INTO orders (customer_id, order_date)
VALUES
(1, '2023-09-01'),
(2, '2023-09-02'),
(3, '2023-09-03'),
(4, '2023-09-04'),
(1, '2023-09-05');

-- Insert data into the order_items table
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 1), 
(1, 3, 2), 
(2, 2, 1), 
(2, 5, 3), 
(3, 4, 1), 
(3, 5, 2), 
(4, 3, 3), 
(4, 4, 1), 
(5, 1, 1), 
(5, 2, 1);

--Query to retrieve names and stock quantity
SELECT product_name, stock_quantity
FROM products;

-- Query to retrieve product name and quantities for orders placed
SELECT products.product_name, order_items.quantity
FROM order_items
JOIN products ON order_items.product_id = products.id
WHERE order_items.order_id = 1; 

--Query to retrieve all orders placed with specific customer
SELECT orders.id AS order_id, products.product_name, order_items.quantity
FROM orders
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
WHERE orders.customer_id = 1; 

-- Reduce the stock for each product in Order ID 1
UPDATE products
SET stock_quantity = stock_quantity - order_items.quantity
FROM order_items
WHERE products.id = order_items.product_id
AND order_items.order_id = 1;

-- Delete Order ID 2 and all its associated order items
DELETE FROM orders
WHERE id = 2;