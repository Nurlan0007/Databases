CREATE DATABASE lab8;

CREATE TABLE salesman (
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4, 2)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT REFERENCES salesman(salesman_id)
);

CREATE TABLE orders (
    ord_no SERIAL PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT REFERENCES customers(customer_id),
    salesman_id INT REFERENCES salesman(salesman_id)
);

CREATE ROLE junior_dev WITH LOGIN PASSWORD 'password';

CREATE VIEW ny_salesmen AS
SELECT * FROM salesman
WHERE city = 'New York';

CREATE VIEW order_details AS
SELECT
    o.ord_no,
    o.purch_amt,
    o.ord_date,
    s.name AS salesman_name,
    c.cust_name AS customer_name
FROM orders o
JOIN salesman s ON o.salesman_id = s.salesman_id
JOIN customers c ON o.customer_id = c.customer_id;

GRANT ALL PRIVILEGES ON order_details TO junior_dev;

CREATE VIEW top_customers AS
SELECT * FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON top_customers TO junior_dev;

CREATE VIEW salesman_count AS
SELECT city, COUNT(*) AS salesman_count
FROM salesman
GROUP BY city;

CREATE VIEW multi_customer_salesmen AS
SELECT s.salesman_id, s.name, COUNT(c.customer_id) AS customer_count
FROM salesman s
JOIN customers c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(c.customer_id) > 1;

CREATE ROLE intern;
GRANT junior_dev TO intern;



