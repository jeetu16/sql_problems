-- Creating Database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting Database;
USE local_mysql;


-- Create reviews Table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    user_id INT,
    submit_date DATE,
    restaurant_id INT,
    rating INT
);

-- Insert values into reviews table
INSERT INTO reviews (review_id, user_id, submit_date, restaurant_id, rating) VALUES
(1001, 501, '2022-01-15', 101, 4),
(1002, 502, '2022-01-20', 101, 5),
(1003, 503, '2022-01-25', 102, 3),
(1004, 504, '2022-01-15', 102, 4),
(1005, 505, '2022-02-20', 101, 5),
(1006, 506, '2022-02-26', 101, 4),
(1007, 507, '2022-03-01', 101, 4),
(1008, 508, '2022-03-05', 102, 2);


-- Question : Write an SQL query to find Average rating for each restaurant for each month.
--            Includes restaurants that have received at least 2 reviews in a given month.

-- Solution 1:
WITH cte AS (
	SELECT 
		restaurant_id,
		MONTH(submit_date) AS month,
		COUNT(review_id) AS total_review,
		SUM(rating) AS total_rating
	FROM reviews
	GROUP BY restaurant_id, MONTH(submit_date)
	HAVING total_review > 1
)
SELECT
	restaurant_id,
    MONTH,
    (total_rating/total_review) AS avg_review
FROM cte;

-- Solution 2:
SELECT 
	restaurant_id,
    MONTH(submit_date) AS month,
    AVG(rating) AS avg_rating
FROM reviews
GROUP BY restaurant_id, MONTH(submit_date)
HAVING COUNT(rating) >= 2;