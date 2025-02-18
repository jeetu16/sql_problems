-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

-- Create the table
CREATE TABLE credit_card_issuance (
    card_name VARCHAR(50) NOT NULL,
    issued_amount INT NOT NULL,
    issue_month TINYINT NOT NULL CHECK (issue_month BETWEEN 1 AND 12),
    issue_year YEAR NOT NULL,
    PRIMARY KEY (card_name, issue_month, issue_year)
);

-- Insert the data
INSERT INTO credit_card_issuance (card_name, issued_amount, issue_month, issue_year) VALUES
('Chase Freedom Flex', 55000, 1, 2021),
('Chase Freedom Flex', 60000, 2, 2021),
('Chase Freedom Flex', 65000, 3, 2021),
('Chase Freedom Flex', 70000, 4, 2021),
('Chase Sapphire Reserve', 170000, 1, 2021),
('Chase Sapphire Reserve', 175000, 2, 2021),
('Chase Sapphire Reserve', 180000, 3, 2021);

-- Question : Write a query that outputs the name of each credit card and the difference in 
--            the number of issued cards between the month with the highest issuance cards and the lowest issuance. 
--            Arrange the results based on the largest disparity.


-- Solution :
SELECT card_name, MAX(issued_amount) - MIN(issued_amount) AS difference
FROM credit_card_issuance GROUP BY card_name;

