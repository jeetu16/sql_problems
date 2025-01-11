-- Create Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Select Database
USE local_mysql;

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductPrice DECIMAL(10, 2)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert records into Products table
INSERT INTO Products (ProductID, ProductName, ProductPrice) VALUES
(1, 'Product A', 10.00),
(2, 'Product B', 15.00),
(3, 'Product C', 20.00),
(4, 'Product D', 25.00),
(5, 'Product E', 30.00),
(6, 'Product F', 35.00),
(7, 'Product G', 40.00),
(8, 'Product H', 45.00),
(9, 'Product I', 50.00),
(10, 'Product J', 55.00);

-- Insert records into Orders table
INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2023-07-01'),
(2, 2, 1, '2023-07-02'),
(3, 3, 5, '2023-07-03'),
(4, 1, 3, '2023-07-04'),
(5, 5, 2, '2023-07-05'),
(6, 6, 1, '2023-07-06'),
(7, 2, 4, '2023-07-07'),
(8, 8, 3, '2023-07-08'),
(9, 9, 1, '2023-07-09'),
(10, 10, 2, '2023-07-10');


-- 1. Retrieve the total revenue generated from each product.

-- Solution 1  
SELECT
    p.ProductID,
    p.ProductName,
    p.ProductPrice,
    COALESCE(SUM(o.Quantity), 0) AS Total_Quantity_Sold,
    COALESCE(SUM(p.ProductPrice * o.Quantity), 0) AS Total_Revenue
FROM Products p
LEFT JOIN Orders o
    ON o.ProductID = p.ProductID
GROUP BY p.ProductID;

-- Solution 2
SELECT 
	p.ProductID,
    p.ProductName,
    p.ProductPrice,
    COALESCE(Total_Quantity_Sold) AS Total_Quantity_Sold,
    COALESCE(Total_Quantity_Sold * ProductPrice) AS Total_Revenue
FROM Products p
LEFT JOIN (
	SELECT
		ProductID,
		SUM(Quantity) AS Total_Quantity_Sold
	FROM Orders
    GROUP BY ProductID
) AS o
ON p.ProductID = o.ProductID;

-- 2. Find products that have not been ordered at all.

-- Solution 1

SELECT *
FROM Products
WHERE ProductID NOT IN (
	SELECT DISTINCT ProductID
    FROM Orders
);

-- Solution 2 (more efficient way) 

SELECT p.*
FROM Products p
LEFT JOIN Orders o
ON p.ProductID = o.ProductID
WHERE o.OrderID is null;

-- Solution 3

SELECT p.*
FROM Products p
LEFT JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.ProductID
HAVING COUNT(o.OrderID) = 0;

-- Solution 4

SELECT p.*
FROM Products p
WHERE NOT EXISTS (
	SELECT *
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);

