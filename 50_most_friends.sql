-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;

-- Create request Table
CREATE TABLE request(
	send_id INT, 
    receive_id INT,
    date_id DATE
);

-- Insert values into request table
INSERT INTO request 
VALUES
	(1,2,'2024-01-01'),
	(1,3,'2024-01-02'),
	(1,4,'2024-01-03'),
	(2,3,'2024-01-04'),
	(3,4,'2024-01-05'),
	(5,1,'2024-01-06');
    
-- Question : Write a SQL query to find the people who have the most friends and total friends count

-- Solution :

WITH cte AS (
	SELECT
		send_id as user_id,
		receive_id as friend_id
	FROM request
	UNION ALL
	SELECT
	 receive_id as user_id,
	 send_id as friend_id
	FROM request
)
SELECT
	user_id,
    COUNT(friend_id) as total_friends
FROM cte
GROUP BY user_id
ORDER BY total_friends DESC
LIMIT 1;