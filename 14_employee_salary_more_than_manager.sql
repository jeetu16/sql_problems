-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database
USE local_mysql;

-- Creating Table :
DROP TABLE IF EXISTS emp;
CREATE TABLE emp(emp_id INT PRIMARY KEY AUTO_INCREMENT, emp_name VARCHAR(15), salary INT, manager_id INT);

-- Inserting records into the table:
INSERT INTO emp(emp_name, salary, manager_id) 
VALUES 
	('navin',1300,2), 
    ('ankit',1200,3),
	('kavya',1250,4),
    ('ranjit',1600,5),
    ('john',3000,4),
	('yash',1800,3),
	('tom',1500,2),
	('subham',1700,6);
    
    
-- Quetion : Write a SQL query to find emp name who's salary is more than manager salary?

-- Solution :
SELECT *
FROM emp e
JOIN emp m
ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;