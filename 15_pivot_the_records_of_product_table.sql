-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

--  Creating table
CREATE TABLE product(
 product varchar(15) NULL,
 amount int NULL,
 country varchar(10) NULL
); 

-- Inserting Records into the table
INSERT into product 
VALUES 
	('banana', 1000, 'usa'), 
    ('carrots', 1500, 'usa'),
	('beans', 1600, 'usa'),
	('orange', 2000, 'usa'),
	('banana', 400, 'china'),
	('carrots', 1200, 'china'),
	('beans', 1500, 'china'),
	('orange', 4000, 'china'),
	('banana', 2000, 'canada'),
	('carrots', 2000, 'canada'),
	('beans', 2000, 'mexico');

-- Question : Write a Query to pivot the dataset?

-- Solution 1 :
SELECT 
	DISTINCT country,
    (SELECT amount FROM product WHERE product = 'banana' AND country = p.country) AS banana,
    (SELECT amount FROM product WHERE product = 'carrots' AND country = p.country) AS carrots,
    (SELECT amount FROM product WHERE product = 'beans' AND country = p.country) AS beans,
    (SELECT amount FROM product WHERE product = 'orange' AND country = p.country) AS orange
FROM product p
ORDER BY country;

-- Solution 2 (Efficient Solution) :
SELECT 
	country,
	MAX(CASE WHEN product = 'banana' THEN amount ELSE null END) AS banana,
	MAX(CASE WHEN product = 'carrots' THEN amount ELSE null END) AS carrots,
	MAX(CASE WHEN product = 'beans' THEN amount ELSE null END) AS beans,
    MAX(CASE WHEN product = 'orange' THEN amount ELSE null END) AS orange
FROM product
GROUP BY country
ORDER BY country;

