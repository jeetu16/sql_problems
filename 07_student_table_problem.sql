-- Creating database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

-- Create the student table
CREATE TABLE students (
    student_name VARCHAR(50),
    subject VARCHAR(50),
    marks INT
);

-- Insert records into the student table
INSERT INTO students (student_name, subject, marks) VALUES
('Alice', 'Math', 65),
('Alice', 'Science', 80),
('Alice', 'English', 80),
('Bob', 'Math', 82),
('Bob', 'Science', 85),
('Bob', 'English', 88),
('Catherine', 'Math', 70),
('Catherine', 'Science', 72),
('Catherine', 'English', 68),
('Daniel', 'Math', 99);


-- Find out the Studentwise Total Marks for Top 2 Subjects?

-- Solution 1
SELECT
	student_name,
    SUM(marks) AS marks
FROM (
	SELECT 
		*,
        ROW_NUMBER() OVER (PARTITION BY student_name ORDER BY marks DESC) AS markRank
	FROM students
) AS s
WHERE markRank < 3
GROUP BY student_name;

-- Solution 2
WITH top_marks AS (
	SELECT
		*,
        ROW_NUMBER() OVER (PARTITION BY student_name ORDER BY marks DESC) AS markRank
	FROM students
) SELECT student_name,sum(marks) AS marks FROM top_marks
WHERE markRank < 3
GROUP BY student_name;
