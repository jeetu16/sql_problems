-- Creating a database
CREATE DATABASE IF NOT EXISTS local_mysql;
-- Selecting database
USE local_mysql;

-- Creating ey_transactions table
CREATE TABLE ey_transactions(
	TranDate DATETIME, 
    TranID VARCHAR(20), 
	TranType VARCHAR(20),
    Amount INT
);

-- Inserting records into ey_transactions table:
INSERT INTO ey_transactions(TranDate, TranID, TranType, Amount)
VALUES
	('2099-05-12 05:29:44.120','A10001','Credit',50000),
	('2099-05-13 10:30:20.100','B10001','Debit',10000),
	('2099-05-13 11:27:50.130','B10002','Credit',20000),
	('2099-05-14 08:35:30.123','C10001','Debit',5000),
	('2099-05-14 09:43:51.100','C10002','Debit',5000),
	('2099-05-15 05:51:11.117','D10001','Credit',30000);

-- Question : Write a query to derive the Net_Balance column based on Credit/Debit of the Amount column ?
SELECT 
	*,
    SUM(CASE WHEN TranType = 'Credit' THEN Amount ELSE -Amount END) OVER(ORDER BY TranDate ASC) AS NetBalance
FROM ey_transactions;