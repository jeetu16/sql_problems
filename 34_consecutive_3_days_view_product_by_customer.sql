-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create ProductViews Table
CREATE TABLE ProductViews (
    ViewID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    ViewDate DATE NOT NULL
);


-- Inser values into ProductViews table
INSERT INTO ProductViews (CustomerID, ProductID, ViewDate) VALUES
(101, 5001, '2099-02-10'),
(101, 5001, '2099-02-11'),
(101, 5001, '2099-02-12'),
(101, 5001, '2099-02-13'),
(101, 5001, '2099-02-15'),
(102, 6002, '2099-02-08'),
(102, 6002, '2099-02-09'),
(102, 6002, '2099-02-10'),
(102, 6002, '2099-02-11'),
(103, 7003, '2099-02-15'),
(103, 7003, '2099-02-17'),
(104, 8004, '2099-03-01'),
(104, 8004, '2099-03-02'),
(104, 8004, '2099-03-03'),
(104, 8004, '2099-03-04'),
(104, 8004, '2099-03-06');

SELECT 
-- Question : Write an SQL query to identify customer who have viewed the same product for than 3 consecutive days.

-- Solution :

WITH cte AS (
	SELECT 
		*,
		LAG(ViewDate, 1, null) OVER(PARTITION BY CustomerID, ProductID ORDER BY ViewDate ASC) as ViewDate1,
		LAG(ViewDate, 2, null) OVER(PARTITION BY CustomerID, ProductID ORDER BY ViewDate ASC) as ViewDate2,
		LAG(ViewDate, 3, null) OVER(PARTITION BY CustomerID, ProductID ORDER BY ViewDate ASC) as ViewDate3
	FROM ProductViews
)
SELECT CustomerID, ProductID
FROM cte
WHERE DATEDIFF(ViewDate, ViewDate1) = 1 AND
DATEDIFF(ViewDate1, ViewDate2) = 1 AND
DATEDIFF(ViewDate2, ViewDate3) = 1;