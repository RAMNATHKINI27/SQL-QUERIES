-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50)
);

-- Create Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(100),
    sales_amount DECIMAL(10, 2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert Sample Data into Customers
INSERT INTO customers (customer_id, customer_name, region) VALUES
(1, 'Riya Sharma', 'North'),
(2, 'Amit Verma', 'West'),
(3, 'Sneha Rao', 'South'),
(4, 'Karan Mehta', 'East');

-- Insert Sample Data into Sales
INSERT INTO sales (sale_id, customer_id, product, sales_amount, order_date) VALUES
(101, 1, 'Laptop', 85000.00, '2024-01-15'),
(102, 2, 'Keyboard', 1200.00, '2024-01-20'),
(103, 3, 'Monitor', 15000.00, '2024-02-10'),
(104, 1, 'Mouse', 700.00, '2024-02-25'),
(105, 4, 'Laptop', 92000.00, '2024-03-05'),
(106, 1, 'Monitor', 14000.00, '2024-04-18');

-- JOIN: Show all sales with customer names and regions
SELECT 
    c.customer_name,
    c.region,
    s.product,
    s.sales_amount,
    s.order_date
FROM 
    sales s
JOIN 
    customers c ON s.customer_id = c.customer_id;

-- AGGREGATION: Total Sales by Region
SELECT 
    c.region,
    SUM(s.sales_amount) AS total_sales
FROM 
    sales s
JOIN 
    customers c ON s.customer_id = c.customer_id
GROUP BY 
    c.region;

-- CTE: Find customers with total purchases over ₹50,000
WITH customer_totals AS (
    SELECT 
        s.customer_id,
        c.customer_name,
        SUM(s.sales_amount) AS total_spent
    FROM 
        sales s
    JOIN 
        customers c ON s.customer_id = c.customer_id
    GROUP BY 
        s.customer_id, c.customer_name
)
SELECT * 
FROM customer_totals
WHERE total_spent > 50000;