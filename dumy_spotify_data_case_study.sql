-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

CREATE TABLE activity
(
user_id VARCHAR(20),
event_name VARCHAR(20),
event_date DATE,
country VARCHAR(20)
);

INSERT INTO activity 
VALUES 
	(1,'app-installed','2022-01-01','India'),
	(1,'app-purchase','2022-01-02','India'),
    (2,'app-installed','2022-01-01','USA'),
    (3,'app-installed','2022-01-01','USA'),
    (3,'app-purchase','2022-01-03','USA'),
    (4,'app-installed','2022-01-03','India'),
    (4,'app-purchase','2022-01-03','India'),
    (5,'app-installed','2022-01-03','SL'),
    (5,'app-purchase','2022-01-03','SL'),
    (6,'app-installed','2022-01-04','Pakistan'),
    (6,'app-purchase','2022-01-04','Pakistan');

-- Q1 : find total active users each day.
-- Solution :
SELECT
	event_date,
    COUNT(DISTINCT user_id) as active_user
FROM activity
WHERE event_name = 'app-installed'
GROUP BY event_date;

-- Q2 : find total active users each week.
-- Solution :
SELECT
	WEEK(event_date) AS week,
    COUNT(DISTINCT user_id) as active_user
FROM activity
WHERE event_name = 'app-installed'
GROUP BY week;

-- Q3: find date wise total number of users who made the purchase same day they installed the app.
-- Solution :
SELECT 
	user_id,
	event_date,
	COUNT(DISTINCT event_name) AS users
FROM activity
GROUP BY user_id, event_date
HAVING users = 2;

-- Q4: percentage of paid users in India, USA and any other countries should be tagged as others
-- Solution :

WITH cte_paid_users as (
	 SELECT 
		country,
		count(1) AS paid_users
	FROM activity
	WHERE event_name = 'app-purchase'
	GROUP BY country
),
cte_countries AS (
	SELECT
		CASE
			WHEN country = 'India' THEN country
			WHEN country = 'USA' THEN country
			ELSE 'Others'
		END AS country,
		paid_users
	FROM cte_paid_users
),
cte_paid_users_countrywise AS (
	SELECT
		country,
        SUM(paid_users) AS paid_users
	FROM cte_countries
    GROUP BY country
)
SELECT
	country,
	(paid_users / (SELECT SUM(paid_users) FROM cte_paid_users_countrywise)) * 100 AS paid_users_percentage
FROM cte_paid_users_countrywise;

 
-- Q5: among all the users who installed the app on a given day, how many users did app purchased on the very next day.


