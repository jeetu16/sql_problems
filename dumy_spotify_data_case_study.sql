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

select * from activity;

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
-- Q4: percentage of paid users in India, USA and any other countries should be tagged as others 
-- Q5: among all the users who installed the app on a given day, how many users did app purchased on the very next day.

