-- 1. Generating a Sequence of Numbers: Generate a sequence of numbers from 1 to 10.
-- Solution : 

WITH RECURSIVE numbers as (
-- anchor query
	SELECT 1 as num
    UNION ALL
-- recursive query
    SELECT num + 1
    FROM numbers
    WHERE num < 10
)
SELECT * FROM numbers;


-- 2. Generate a Series of Dates: Generate a list of dates between two given dates (e.g., 2024-12-15 to 2025-01-10).
-- Solution : 

WITH RECURSIVE series_of_date AS (
-- anchor query
	SELECT '2024-12-15' as dates
    UNION ALL
-- recursive query
    SELECT dates + INTERVAL 1 DAY
    FROM series_of_date
    WHERE dates < '2025-01-10'
)
SELECT * FROM series_of_date;



-- 3. Calculating Factorial: Compute the factorial of a number 5 using a recursive CTE.
-- Solution : 

WITH RECURSIVE factorial_cte AS (
-- anchor query
	SELECT 0 AS num, 1 as factorial
    UNION ALL
-- recursive query
    SELECT  num+1, factorial * (num+1)
    FROM factorial_cte
    WHERE num < 5
)
SELECT * FROM factorial_cte ORDER BY num DESC LIMIT 1;