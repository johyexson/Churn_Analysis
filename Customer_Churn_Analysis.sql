-- Performing analysis to extract insights from the data --
SELECT *
FROM customer_churn.telecom_customer_churn;

-- Adding an extra column to calculate tenure of customers in years --
ALTER TABLE customer_churn.telecom_customer_churn
ADD Tenure_Range VARCHAR (50);

UPDATE customer_churn.telecom_customer_churn
SET Tenure_Range =
CASE 
	WHEN Tenure < 12 THEN "Less than a year"
    WHEN Tenure = 12 THEN "1 year"
    WHEN Tenure > 12 AND Tenure <= 24 THEN "2 years"
    WHEN Tenure > 24 AND Tenure <= 36 THEN "3 years"
    WHEN Tenure > 36 AND Tenure <= 48 THEN "4 years"
    WHEN Tenure > 48 AND Tenure <= 60 THEN "5 years"
    WHEN Tenure > 60 AND Tenure <= 72 THEN "6 years"
END;

-- Checking to confirm the update of the new column in the table --
SELECT *
FROM customer_churn.telecom_customer_churn;

-- How many customers were newly acquired? --
SELECT COUNT(*) AS New_Customers
FROM customer_churn.telecom_customer_churn
WHERE Customer_Status = 'Joined';

-- How many customers stayed? --
SELECT COUNT(*) AS Existing_Customers
FROM customer_churn.telecom_customer_churn
WHERE Customer_Status = 'Stayed';

-- What is the overall churn rate of customers --
SELECT Total_Customers, Churned_Customers,
CAST((Churned_Customers * 0.1 /Total_Customers * 0.1 * 100) AS DECIMAL (10,2)) AS Churn_Rate
FROM (SELECT 
		COUNT(*) AS Total_Customers
FROM customer_churn.telecom_customer_churn) AS Total,
	(SELECT COUNT(*) AS Churned_Customers
FROM customer_churn.telecom_customer_churn
		WHERE Customer_Status = 'Churned') AS Churned;

-- Adding new columns to the table in order to calculate churn rates of customers based on various categories --
ALTER TABLE customer_churn.telecom_customer_churn
ADD Churned VARCHAR (10);

UPDATE customer_churn.telecom_customer_churn
SET Churned =
CASE 
	WHEN Customer_Status = 'Churned' THEN 'Yes'
    ELSE 'No'
    END;

-- Confirm the update --
SELECT *
FROM customer_churn.telecom_customer_churn;

ALTER TABLE customer_churn.telecom_customer_churn
ADD Churn INTEGER (10);

UPDATE customer_churn.telecom_customer_churn
SET Churn =
CASE 
	WHEN Churned = 'Yes' THEN 1
    ELSE 0
    END;

-- Confirm the update --    
SELECT *
FROM customer_churn.telecom_customer_churn;

-- Which is the most preferred payment method among churned customers? --
SELECT Payment_Method,
	COUNT(*) AS Total_Customers,
    SUM(Churn) AS Churned_Customers,
    CAST(SUM(Churn) * 1.0/ COUNT(*) * 100 AS DECIMAL (10,2)) AS Churn_Rate
FROM customer_churn.telecom_customer_churn
GROUP BY Payment_Method
ORDER BY Churn_Rate DESC;

-- What is the typical tenure for churned customers? --
SELECT Tenure_Range,
	COUNT(*) AS Total_Customers,
    SUM(Churn) AS Churned_Customers,
    CAST(SUM(Churn) * 1.0/ COUNT(*) * 100 AS DECIMAL (10,2)) AS Churn_Rate
FROM customer_churn.telecom_customer_churn
GROUP BY Tenure_Range
ORDER BY Churn_Rate DESC;

-- Are there differences in churn rate between male and female customers? --
SELECT Gender,
	COUNT(*) AS Total_Customers,
    SUM(Churn) AS Churned_Customers,
    CAST(SUM(Churn) * 1.0/ COUNT(*) * 100 AS DECIMAL (10,2)) AS Churn_Rate
FROM customer_churn.telecom_customer_churn
GROUP BY Gender
ORDER BY Churn_Rate DESC;

-- Does the marital status of customers influence churn behaviour? --
SELECT Married,
	COUNT(*) AS Total_Customers,
    SUM(Churn) AS Churned_Customers,
    CAST(SUM(Churn) * 1.0/ COUNT(*) * 100 AS DECIMAL (10,2)) AS Churn_Rate
FROM customer_churn.telecom_customer_churn
GROUP BY Married
ORDER BY Churn_Rate DESC;

-- Does the number of dependents influence customer churn? --
SELECT Dependents,
	COUNT(*) AS Total_Customers,
    SUM(Churn) AS Churned_Customers,
    CAST(SUM(Churn) * 1.0/ COUNT(*) * 100 AS DECIMAL (10,2)) AS Churn_Rate
FROM customer_churn.telecom_customer_churn
GROUP BY Dependents
ORDER BY Churn_Rate DESC;

-- Does average monthly charges based on contract impact customer churn? --
SELECT Customer_Status, avg(Total_Charges) AS Average_Total_Charges, Contract
FROM customer_churn.telecom_customer_churn
GROUP BY Customer_Status;

-- What are the key drivers of customer churn? --
SELECT Churn_Reason, SUM(Churn) AS Churned_Customers
FROM customer_churn.telecom_customer_churn
GROUP BY Churn_Reason
ORDER BY Churn DESC;

-- Is the company losing high value customers? --
SELECT Customer_Status, SUM(Total_Revenue) AS SumTotal_of_Revenue
FROM customer_churn.telecom_customer_churn
GROUP BY Customer_Status;
    
