-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;


-- Create Employee_Shifts Table
CREATE TABLE Employee_Shifts (
    emp_id INT,
    shift_date DATE,
    shift_type VARCHAR(20),
    PRIMARY KEY (emp_id, shift_date)  -- Assuming one shift per employee per day
);

-- Insert values into Employee_Shifts table
INSERT INTO Employee_Shifts (emp_id, shift_date, shift_type) VALUES
(101, '2099-01-01', 'Morning'),
(101, '2099-01-02', 'Night'),
(102, '2099-01-01', 'Evening'),
(103, '2099-01-01', 'Morning'),
(103, '2099-01-02', 'Morning'),
(103, '2099-01-03', 'Night');

-- Question : Transform the table to show each employee's shift schedule in a comma-separated format for each date.

-- Solution :
SELECT 
	shift_date,
	group_concat(' ',emp_id, '(', shift_type, ')') as shifts
FROM Employee_Shifts
GROUP BY shift_date;

