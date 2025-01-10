-- Creating database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

-- 1. Create table
CREATE TABLE temperature_readings (
    reading_id SERIAL PRIMARY KEY,
    sensor_id INT,
    reading_time TIMESTAMP,
    temperature NUMERIC
);

-- 2. Insert records
INSERT INTO temperature_readings (sensor_id, reading_time, temperature) VALUES
(1, '2024-07-01 08:00:00', 25.4),
(1, '2024-07-01 12:00:00', 27.8),
(1, '2024-07-01 16:00:00', 29.2),
(2, '2024-07-02 08:00:00', 24.7),
(2, '2024-07-02 12:00:00', 26.3),
(2, '2024-07-02 16:00:00', 28.1),
(3, '2024-07-03 08:00:00', 23.5),
(3, '2024-07-03 12:00:00', 25.0),
(3, '2024-07-03 16:00:00', 27.6),
(1, '2024-07-04 08:00:00', 22.9);

-- Questions: Find the Average Temperature for Each Day?

-- Solution 1
SELECT
	DATE(reading_time) AS Reading_Date,
    AVG(temperature) as Avg_Temperature
FROM temperature_readings
GROUP BY DATE(reading_time);

-- Solution 2
WITH readings AS (
	SELECT
		DATE(reading_time) as Reading_Date,
        temperature
	FROM temperature_readings
)
SELECT
	Reading_Date,
    AVG(temperature)
FROM readings
GROUP BY Reading_Date;