️/* Overall Churn Rate*/
SELECT COUNT(*) AS total_customers,
       SUM(CASE WHEN Exited THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(SUM(CASE WHEN Exited THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling;
--output:~20% of customers have churned.

/*Churn by Geography*/
SELECT Geography,
       COUNT(*) AS total,
       SUM(CASE WHEN Exited THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Exited THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY Geography;
--output:Germany has the highest churn rate among all countries.

/* Churn by Age Group*/
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Above 50'
    END AS age_group,
    ROUND(AVG(Balance), 2) AS avg_balance,
    ROUND(AVG(EstimatedSalary), 2) AS avg_salary
FROM churn_modelling
GROUP BY age_group;
--output:Older customers (above 50) have higher balances and slightly higher churn.

/*Churn vs Active Membership*/
SELECT IsActiveMember,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Exited THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Exited THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY IsActiveMember;
--output:Inactive members are more likely to churn.

/*Inactive members are more likely to churn*/
SELECT NumOfProducts,
       COUNT(*) AS total,
       SUM(CASE WHEN Exited THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Exited THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY NumOfProducts;
--output:Customers with 3+ products have a significantly higher churn rate

/*Gender-wise Churn*/
SELECT Gender,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Exited THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Exited THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM churn_modelling
GROUP BY Gender;
--output: Churn rate is slightly higher among female customers.

/*High-Value Customers at Risk*/
SELECT *
FROM churn_modelling
WHERE Balance > 100000 AND EstimatedSalary > 100000 AND Exited = TRUE;
--output:These are VIP customers that need urgent retention strategy.
