-- Creating Database
CREATE DATABASE IF NOT EXISTS company_db;
-- Selecting Database;
USE company_db;


CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    manager_id INT
);

CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY,
    employee_id INT,
    salary DECIMAL(10,2),
    effective_from DATE,
    effective_to DATE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50)
);

-- ----------------------------------------------------------------------------------

INSERT INTO Employees (employee_id, first_name, last_name, department_id, salary, hire_date) VALUES
(1, 'John', 'Doe', 1, 75000.00, '2018-06-12'),
(2, 'Jane', 'Smith', 2, 65000.00, '2019-08-25'),
(3, 'Robert', 'Johnson', 1, 85000.00, '2017-03-18'),
(4, 'Emily', 'Davis', 3, 60000.00, '2020-10-05'),
(5, 'Michael', 'Brown', 2, 70000.00, '2021-01-15');

INSERT INTO Departments (department_id, department_name, manager_id) VALUES
(1, 'Engineering', 1),
(2, 'Marketing', 2),
(3, 'HR', 4);


INSERT INTO Salaries (salary_id, employee_id, salary, effective_from, effective_to) VALUES
(1, 1, 75000.00, '2018-06-12', NULL),
(2, 2, 65000.00, '2019-08-25', NULL),
(3, 3, 85000.00, '2017-03-18', NULL),
(4, 4, 60000.00, '2020-10-05', NULL),
(5, 5, 70000.00, '2021-01-15', NULL);

INSERT INTO Customers (customer_id, first_name, last_name, city, state, country, signup_date) VALUES
(1, 'Alice', 'Johnson', 'Los Angeles', 'California', 'USA', '2022-03-12'),
(2, 'Bob', 'Williams', 'New York', 'New York', 'USA', '2021-11-15'),
(3, 'Charlie', 'Brown', 'Chicago', 'Illinois', 'USA', '2020-07-08'),
(4, 'David', 'Jones', 'Houston', 'Texas', 'USA', '2023-01-20'),
(5, 'Eve', 'Taylor', 'Phoenix', 'Arizona', 'USA', '2022-09-30');


INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2024-01-10', 250.00),
(2, 2, '2024-02-15', 120.50),
(3, 3, '2024-03-05', 450.75),
(4, 4, '2024-03-18', 300.40),
(5, 5, '2024-04-01', 95.99);

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 2, 50.00),
(2, 1, 2, 1, 150.00),
(3, 2, 3, 3, 40.00),
(4, 3, 4, 1, 450.75),
(5, 4, 5, 2, 150.20);

INSERT INTO Products (product_id, product_name, category_id, price) VALUES
(1, 'Laptop', 1, 1000.00),
(2, 'Headphones', 2, 150.00),
(3, 'Keyboard', 3, 40.00),
(4, 'Monitor', 1, 450.75),
(5, 'Mouse', 3, 25.99);

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Accessories'),
(3, 'Computer Peripherals');

INSERT INTO Payments (payment_id, order_id, payment_date, amount, payment_method) VALUES
(1, 1, '2024-01-11', 250.00, 'Credit Card'),
(2, 2, '2024-02-16', 120.50, 'PayPal'),
(3, 3, '2024-03-06', 450.75, 'Credit Card'),
(4, 4, '2024-03-19', 300.40, 'Debit Card'),
(5, 5, '2024-04-02', 95.99, 'UPI');


-- SQL Problems
-- Easy (10 Questions)
-- 1. Retrieve all employees' names and salaries.
-- Solution :
SELECT
	concat(first_name, ' ', last_name) AS names,
    salary
FROM Employees;

-- 2. Find all departments sorted by name.
-- Solution :
SELECT department_name
FROM Departments
ORDER BY department_name;

-- 3. List all customers who signed up in 2024.
-- Solution :
SELECT
	*
FROM Customers
WHERE YEAR(signup_date) = 2024;

-- 4. Get the total number of products in the database.
-- Solution :
SELECT
	COUNT(*) AS total_products
FROM Products;

-- 5. Retrieve the details of an order with order_id = 1001.
-- Solution :
SELECT *
FROM Orders
WHERE order_id = 1;

-- 6. Find all customers from "California".
-- Solution :
SELECT *
FROM Customers
WHERE State = 'California';

-- 7. Count the number of employees in each department.
SELECT
	department_name,
    COUNT(employee_id)
FROM Departments d
LEFT JOIN Employees e USING (department_id)
GROUP BY department_name;


-- 8. Get all products that cost more than $50.
-- Solution :

SELECT *
FROM Products
WHERE price > 50;


-- 9. Retrieve all payments made via "Credit Card".

-- Solution :
SELECT *
FROM Payments 
WHERE payment_method = 'Credit Card';


-- 10. Get the names of employees hired after 2020.

-- Solution :
SELECT *
FROM Employees
WHERE hire_date > '2020-12-31';


-- Medium (60 Questions)
-- Joins (15 Questions)

-- 11. Retrieve a list of employees along with their department names.

-- Solution :

SELECT
	e.*,
    d.department_name
FROM Employees e
JOIN Departments d USING(department_id);

-- 12. Find all orders along with customer names.

-- Solution :
SELECT
	o.*,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM Orders o
JOIN Customers c USING(customer_id);

-- 13. Get the list of products along with their category names.

-- Solution :

SELECT
	p.*,
    c.category_name
FROM Products p
JOIN Categories c USING (category_id);

-- 14. Show all employees along with their salaries from the Salaries table.

-- Solution :
SELECT
	e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
    e.hire_date,
    s.salary
FROM Salaries s
JOIN Employees e USING(employee_id);

-- 15. List customers who have placed at least one order.

-- Solution :
SELECT
	c.*,
    o.order_id
FROM Customers c
JOIN Orders o USING(customer_id);

-- 16. Find products that have never been ordered.

-- Solution :
SELECT
	p.*
FROM Products p
LEFT JOIN OrderDetails od USING(product_id)
WHERE order_detail_id IS NULL;

-- 17. Get the total number of orders for each customer.

SELECT
	c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(order_id)
FROM Customers c
LEFT JOIN Orders o USING(customer_id)
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 18. Retrieve employees who work in the "Engineering" department.
-- Solution :
SELECT 
	e.*,
	d.department_name
FROM Employees e
JOIN Departments d USING(department_id)
WHERE department_name = 'Engineering';

-- 19. Find customers along with the total amount they spent.

-- Solution :
SELECT
	CONCAT(first_name, ' ', last_name) as name,
	SUM(quantity * unit_price) AS total_spent
FROM Customers c
JOIN Orders o USING(customer_id)
JOIN OrderDetails od USING(order_id)
GROUP BY name;

-- 20. Get employees who have not been assigned to a department.
-- Solution :
SELECT *
FROM Employees
WHERE department_id IS NULL;

-- 21. Retrieve all products that belong to the "Electronics" category.
-- Solution :
SELECT
	p.*,
    c.category_name
FROM Products p
JOIN Categories c USING(category_id)
WHERE c.category_name = 'Electronics';


-- 22. Find employees along with their department and manager details.

-- Solution :
SELECT
	e.*,
    d.manager_id,
    CONCAT(m.first_name, ' ', m.last_name) AS name
FROM Employees e
JOIN Departments d USING(department_id)
JOIN Employees m ON d.manager_id = m.employee_id;


-- 23. Retrieve orders along with payment details.

-- Solution :
SELECT *
FROM Orders o
LEFT JOIN Payments p USING(order_id);


-- 24. Find the most expensive product in each category.

-- Solution :
WITH cte AS (
	SELECT
		c.category_name,
		p.*,
		DENSE_RANK() OVER(PARTITION BY category_name ORDER BY price DESC) AS rnk
	FROM Products p
	LEFT JOIN Categories c USING(category_id)
)
SELECT
	category_name,
    product_id,
    product_name,
    category_id,
    price
FROM cte
WHERE rnk = 1;

-- 25. Get the total amount of payments received for each order.

-- Solution 1:
SELECT
	order_id,
    (
		SELECT SUM(amount)
        FROM Payments
        WHERE order_id = o.order_id
    ) AS total_amount
FROM Orders o;

-- Solution 2:
SELECT
	o.order_id,
    SUM(amount) AS total_amount
FROM Orders o
LEFT JOIN Payments p USING(order_id)
GROUP BY o.order_id;


-- Aggregations (10 Questions)

-- 26. Find the average salary of employees.

-- Solution :
SELECT
	AVG(salary) AS avg_salary_of_employees
FROM Employees;

-- 27. Get the highest-paid employee in each department.

-- Solution 1:
SELECT
	hs.department_name,
    e.*
FROM Employees e
RIGHT JOIN (
SELECT
	d.department_name,
    MAX(salary) AS salary
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_name
) AS hs ON hs.salary = e.salary;

-- Solution 2:
WITH cte AS
(
SELECT
	d.department_name,
	e.*,
    DENSE_RANK() OVER(PARTITION BY d.department_name ORDER BY e.salary DESC) as rnk
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
)
SELECT *
FROM cte
WHERE rnk = 1;

-- 28. Find the total revenue generated by the company.

-- Solution :
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM OrderDetails;

-- 29. Retrieve the total number of orders placed in the last 6 months.

-- Solution : 
SELECT *
FROM Orders
WHERE order_date >= DATE_SUB(DATE(NOW()), INTERVAL 6 MONTH);

-- 30. Find the minimum and maximum salaries for each department.
SELECT
	d.department_name,
    MAX(e.salary) AS max_salary,
    MIN(e.salary) AS min_salary
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_name;


-- 31. Count the number of employees in each department.

-- Solution :
SELECT
	d.department_name,
    COUNT(employee_id) AS total_employee
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_id;

-- 32. Get the total quantity of products sold.

-- Solution :
SELECT
	SUM(quantity) AS total_products_sold
FROM OrderDetails;

-- 33. Find the most frequently purchased product.

-- Solution :
SELECT
	product_name,
    SUM(quantity) AS total_quantity_sold
FROM Products p
LEFT JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

-- 34. Retrieve the average order amount.

-- Solution :
SELECT
	AVG(order_total) AS avg_order_amount
FROM (
	SELECT 
		order_id,
        SUM(quantity*unit_price) AS order_total
	FROM OrderDetails
    GROUP BY order_id
) AS sub;

-- 35. Find the total amount paid via "PayPal".

-- Solution :
SELECT
	SUM(amount) AS total_amount
FROM Payments
WHERE payment_method = 'PayPal';


-- Subqueries (10 Questions)

-- 36. Find employees who earn more than the average salary.

-- Solution
SELECT *
FROM Employees
WHERE salary > (
	SELECT AVG(salary)
    FROM Employees
);

-- 37. Get products that have never been ordered.

-- Solution :
SELECT *
FROM Products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
    FROM OrderDetails
);

-- 38. Retrieve customers who placed the highest order amount.

-- Solution :
SELECT
	c.*,
    total_amount
FROM Orders o
JOIN Customers c USING(customer_id)
ORDER BY total_amount DESC
LIMIT 1;

-- 39. Find employees who joined before their department's manager.

-- Solution 1:
SELECT *
FROM Employees e
WHERE e.hire_date < (
	SELECT m.hire_date
    FROM Departments d
    JOIN Employees m ON d.manager_id = m.employee_id
    WHERE d.department_id = e.department_id
);

-- Solution 2:
SELECT
	e.*,
    d.manager_id,
    m.employee_id AS manager_employee_id,
    m.hire_date AS mananger_hire_date
FROM Employees e
JOIN Departments d USING(department_id)
JOIN Employees m ON d.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;

-- 40. Get departments where all employees earn more than $50,000.

-- Solution :
SELECT
	e1.department_id
FROM Employees e1
WHERE EXISTS (
	SELECT 1
    FROM Employees e2
    WHERE e1.department_id = e2.department_id AND e2.salary > 70000
)
GROUP BY department_id;


-- 41. Find orders that have payments made on a different date.

-- Solution 1 :
SELECT *
FROM Orders o
WHERE order_id IN (
	SELECT p.order_id
    FROM Payments p
    WHERE p.order_id = o.order_id AND p.payment_date != o.order_date
);

-- Solution 2 :
SELECT o.*
FROM Orders o
JOIN Payments p USING(order_id)
WHERE o.order_date != p.payment_date;

-- 42. Retrieve employees whose salaries are higher than the department average.

-- 43. Find products with a price higher than the category average.

-- 44. Get customers who have placed more orders than the average number of orders.

-- 45. Find employees with the second-highest salary.

/*
-- Window Functions (10 Questions)

-- 46. Rank employees based on salary within each department.

-- 47. Find the cumulative revenue of all orders.

-- 48. Retrieve the three most recent orders for each customer.

-- 49. Get the moving average of salaries for employees hired in the last 5 years.

-- 50. Find the total salary expenditure per department using window functions.

-- 51. Retrieve the first order placed by each customer.

-- 52. Find the difference in salary between each employee and the department average.

-- 53. Rank products based on total sales quantity.

-- 54. Retrieve the order ID, total amount, and rank based on order amount.

-- 55. Get the most recent salary record for each employee.

CTEs & Recursive Queries (10 Questions)

-- 56. Find employees with a higher salary than their manager.

-- 57. Get the department hierarchy using a recursive CTE.

-- 58. Retrieve the monthly revenue trend for the last year.

-- 59. Find the total number of employees reporting to each manager.

-- 60. Retrieve the list of employees and their reporting hierarchy.

-- 61. Get the top-selling products in each category.

-- 62. Retrieve employees along with their promotion history.

-- 63. Find the revenue trend for each customer.

-- 64. Retrieve customers whose spending has increased year over year.

-- 65. Get the cumulative order amount for each customer.

Date & Time Functions (10 Questions)

-- 66.Find employees who have completed exactly 5 years in the company.

-- 67. Get the total number of orders placed in each month of 2024.

-- 68. Retrieve all customers who placed an order in the last 30 days.

-- 69. Find the average time between orders for each customer.

-- 70. Get the first and last order date for each customer.

-- 71. Find employees hired on a Monday.

-- 72. Retrieve orders that were placed on weekends.

-- 73. Get the total revenue generated in the last quarter.

-- 74. Find the highest single-day revenue.

-- 75. Retrieve the total number of orders placed in each hour of the day.

Hard (30 Questions)

-- 76. Find the top 5 customers by total spend.

-- 77. Retrieve employees whose salaries have increased by more than 10% in a year.

-- 78. Get products that contributed to at least 10% of total revenue.

-- 79. Find customers who made their first order in 2023.

-- 80. Retrieve employees who were hired as interns and later became managers.

-- 81. Get customers who placed an order every month in the last year.

-- 82. Find departments where the employee count has decreased over time.

-- 83. Retrieve the most profitable category over the last 3 years.

-- 84. Find employees whose salaries are in the top 10% of the company.

-- 85. Get products that have been continuously in demand for the last 6 months.

-- 86. Find customers whose order frequency has dropped in the last 3 months.

-- 87. Retrieve the month with the highest order volume.

-- 88. Get employees who have received the highest raise in the last 2 years.

-- 89. Find customers who placed an order but never made a payment.

-- 90. Retrieve orders that had a partial payment.

-- 91. Find customers with an order refund history.

-- 92. Get the revenue trend for each state.

-- 93. Retrieve customers who downgraded their order value over time.

-- 94. Find the seasonality trend of order volume.

-- 95. Retrieve employees who got a salary cut.

-- 96. Get orders where the payment was delayed by more than a week.

-- 97. Find employees who have worked under multiple managers.

-- 98. Retrieve the list of products that have been discontinued.

-- 99. Find customers who have returned more than 20% of their orders.

-- 100. Get the lifetime value of each customer.

*/
