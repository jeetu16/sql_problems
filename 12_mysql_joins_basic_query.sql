-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

-- Creating two tables 'table1' and 'table2'
CREATE TABLE table1(id INT);
INSERT INTO table1 VALUES (1), (1),(2),(NULL),(NULL);

CREATE TABLE table2(id INT);
INSERT INTO table2 VALUES (1),(3),(NULL);


-- Question : Given us 2 tables, identify the no of records returned using different type of MySQL Joins. 

-- Solution :

-- INNER JOIN
SELECT *
FROM table1 t1
INNER JOIN table2 t2
ON t1.id = t2.id;
-- Output
-- 	id	id
-- 	1	1
-- 	1	1

-- LEFT JOIN
SELECT *
FROM table1 t1
LEFT JOIN table2 t2
ON t1.id = t2.id;
-- Output
-- 	id		id
-- 	1		1
-- 	1		1
-- 	2		null
-- 	null	null
--  null	null

-- RIGHT JOIN
SELECT *
FROM table1 t1
RIGHT JOIN table2 t2
ON t1.id = t2.id;
-- Output
-- 	id		id
-- 	1		1
-- 	1		1
-- 	null	3
--  null	null

-- CROSS JOIN
SELECT *
FROM table1
CROSS JOIN table2;
-- Output
-- 	id		id
-- 	1		null
-- 	1		3
-- 	1		1
-- 	1		null
-- 	1		3
-- 	1		1
-- 	2		null
-- 	2		3
-- 	2		1
-- 	null	null	
-- 	null	3
-- 	null	1
-- 	null	null	
-- 	null	3
-- 	null	1

