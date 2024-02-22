# Customer-Churn-Analysis
![](Intro-Image.png)
# Table of Contents
- [Introduction](#introduction)
- [Business Task](#business-task)
- [Data Source](#data-source)
- [Tools](#tools)
- [Methods](#methods)
- [Graphs](#graphs)
- [Summary of Findings](#summary-of-findings)
- [Recommendations](#Recommendations)
- [Limitations](#limitations)
- [Code](#code)
- [Dashboard](#dashboard)
# Introduction 
Customers remain indispensable in any part of an organisation being that the loss of a customer can have adverse effect on the growth of the company. Hence, most organisations evaluate their customer churn rates in order to make predictions and devise strategies to prevent fall outs.
For this project however, an analysis was conducted on churn data for a fictional Telecommunications Company that provides phone and internet services to 7,043 customers in California.
# Business Tasks
1. How many customers joined the company during the last quarter?
2. What is the customer profile for a customer that churned, joined and stayed? Are they different?
3. What seem to be the key drivers of customer churn?
4. Is the company losing high value customers? If so, how can they retain them?
# Data Source
The data was gotten from Maven Analytics Data Playground which is a website where datasets are made available for download in order to practice using real world data for carrying out analysis. The churn data includes details about customer demographics, location, services and current status. It consists of multiple tables, 7043 records and 34 fields stored in a csv file. [Link](https://mavenanalytics.io/data-playground?search=customer%20churn)
# Tools
- Excel
- SQL(MySQL)
- [Power BI](https://app.powerbi.com/view?r=eyJrIjoiZGZjZWZjNzYtODhlMS00MzFiLWIxYTMtMjAyZjllMjc3ZmM4IiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9)
# Methods
- Loaded the CSV file in Excel for data wrangling
- Checked for duplicates, renamed the columns and and ensured consistent formatting
- Imputed the data in order to eliminate null values
- Imported the data into MySQL to conduct analysis
- Executed queries to extract insights from the data
- Used clauses and functions(such as ALTER TABLE, UPDATE, CASE,etc.) to answer questions related to the business task
- Exported the data into Power BI for visualization and further analysis
- Developed a dashboard for visualising the results using Power BI desktop
# Codes 
```sql
SELECT Tenure_Range,
	COUNT(*) AS Total_Customers,
    SUM(Churn) AS Churned_Customers,
    CAST(SUM(Churn) * 1.0/ COUNT(*) * 100 AS DECIMAL (10,2)) AS Churn_Rate
FROM customer_churn.telecom_customer_churn
GROUP BY Tenure_Range
ORDER BY Churn_Rate DESC;
```
# Graphs
The following questions were answered and the results are visualized below:
 1. What is the typical tenure for churned customers?

![](Insight_1.png)

 2. What are the key drivers of customer churn?

![](Insight_2.png)

 3. Is the company losing high value customers?

![](Insight_3.png)

