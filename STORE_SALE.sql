-- before creating table we need database
CREATE DATABASE StoreRetailSales;
USE StoreRetailSales;

-- To create table by column name
CREATE TABLE Store_sales (
	Transaction_ID Varchar(50),
	Customer_ID	Varchar(50),
    Category Varchar(255),
	Item Varchar(50),
	Price_Per_Unit INT,
	Quantity INT,
	Total_Spent INT,
	Payment_Method Varchar(50),
	Location Varchar(50),
	Transaction_Date DATE,
	Discount_Applied BOOLEAN
);
 -- To load table from local disk
LOAD DATA INFILE 'D:\\MySQL project\\sales\\Sales.csv'
INTO TABLE Store_sales
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@var1,@var2,@var3,@var4,@var5,@var6,@var7,@var8,@var9,@var10,@var11)
SET
    Transaction_ID = @var1,
    Customer_ID = @var2,
    Category = @var3,
    Item = NULLIF(@var4, 'N/A'),
    Price_Per_Unit = NULLIF(@var5, 'N/A'),
    Quantity = NULLIF(@var6, 'N/A'),
    Total_Spent = NULLIF(@var7, 'N/A'),
    Payment_Method = @var8,
    Location = @var9,
    Transaction_Date = STR_TO_DATE(@var10, '%d-%m-%Y'),
    Discount_Applied = CASE 
                         WHEN TRIM(REPLACE(@var11, '\r', '')) = 'TRUE' THEN 1
                         WHEN TRIM(REPLACE(@var11, '\r', '')) = 'FALSE' THEN 0
                         ELSE NULL
                       END;

USE StoreRetailSales;
-- To retrieve all rows and column
SELECT * FROM store_sales;

SELECT DISTINCT Discount_Applied 
FROM   Store_sales;

SELECT HEX(@var11);
#1.	What is the average 'Total_Spent' for transactions paid with 'Credit Card'? 
SELECT
	AVG(Total_Spent) AS avg_total_spent
FROM
	store_sales
WHERE
	Payment_method = 'Credit Card';

#2.How many transactions were made in 'Online' locations? 
SELECT
	COUNT(Transaction_ID) AS total_transactions
FROM
	store_sales
WHERE
	Location = 'Online';

#3.Which 'Customer_ID' has the highest total 'Total_Spent'? 
SELECT
	Customer_ID,
    MAX(Total_Spent) AS highest_total_spent
FROM
	store_sales
GROUP BY
	Customer_ID;

SELECT * FROM store_sales;

#4.What is the total 'Quantity' of 'Item 16 BEV' sold? 
SELECT
	SUM(Quantity) AS total_quantity
FROM
	store_sales
WHERE
	Item = 'Item_16_BEV';
#5.Calculate the average 'Price_Per_Unit' for items in the 'Butchers' category.
SELECT
	AVG(Price_Per_Unit) AS avg_price_perunit
FROM
	store_sales
WHERE
	Category = 'Butchers';
    
SELECT * FROM store_sales;

#6.How many transactions have a 'Discount_Applied' value of '1'?
SELECT
	COUNT(Transaction_ID) AS total_transactions
FROM
	store_sales
WHERE
	Discount_Applied = '1';
#7.What is the 'Total_Spent' for 'CUST_09' in 'Patisserie' category? 
SELECT
	Customer_ID,
    Category,
	SUM(Total_Spent) AS Total_spent
FROM
	store_sales
WHERE
	Customer_ID = 'CUST_09' AND
    Category = 'Patisserie';

#8.List all the unique 'Payment_Method' used in 'Online' transactions. 
SELECT
	DISTINCT(Payment_method)AS unique_payment_method
FROM
	store_sales
WHERE
	Location = 'Online';
    
#9.What is the earliest 'Transaction_Date' in the dataset?
SELECT
	MIN(Transaction_Date)
FROM
	store_sales;

#10.	Calculate the total revenue generated from 'Food' category items. 
SELECT
	SUM(Total_Spent) AS total_revenue
FROM
	store_sales
WHERE
	Category = 'Food';

SELECT * FROM store_sales;

#11. Identify the top 3 customers who spent the most money on a category 'Milk Products' in year 2022.
SELECT 
    Customer_ID,
    SUM(Total_Spent) AS Total_Spent
FROM 
    Store_sales
WHERE 
    Category = 'Milk Products' AND YEAR(Transaction_Date) = 2022
GROUP BY 
    Customer_ID
ORDER BY 
    Total_Spent DESC
LIMIT 3;

#12.Generate a report showing the percentage change in total sales for each month compared to the previous month.
WITH MonthlySales AS (
	SELECT
		MONTH(Transaction_Date) AS month,
        SUM(Total_Spent) AS total_sales
	FROM
		store_sales
	GROUP BY
		MONTH(Transaction_Date)
)
SELECT
	month,
    total_sales,
    LAG(total_sales,1,0)OVER(ORDER BY month) AS Previous_Month_Sales,
    CASE
		WHEN LAG(total_sales,1,0) OVER(ORDER BY month) = 0 THEN NULL
        ELSE
			(total_sales - LAG(total_sales,1,0)OVER(ORDER BY month)) * 100.0 /
            LAG(total_sales,1,0)OVER(ORDER BY month)
    END AS Percentage_change
FROM
    MonthlySales
ORDER BY
    month;
    
#13.List all items where the total revenue generated exceeds the average revenue for all items.
SELECT
    Item,
    SUM(Total_Spent) AS Item_revenue
FROM
    store_sales
GROUP BY
    Item
HAVING
    SUM(Total_Spent) > (SELECT AVG(Total_Spent) FROM store_sales);
    
#14.Identify the month with the highest revenue for each payment method.
WITH MonthlyPaymentMethod AS (
	SELECT
		Payment_Method,
		MONTH(Transaction_Date)AS month,
		SUM(Total_Spent)AS total_revenue,
        ROW_NUMBER()OVER(PARTITION BY Payment_Method ORDER BY SUM(Total_Spent) DESC) AS rn
	FROM
		store_sales
	GROUP BY
		Payment_Method,
		MONTH(Transaction_Date)
)
SELECT
	Payment_Method,
	month,
    total_revenue
FROM
	MonthlyPaymentMethod
WHERE
	rn = 1;
    
#15.Find the percentage of transactions that were made with a discount, compared to those without a discount.
SELECT
	Discount_Applied,
    COUNT(Transaction_ID) AS Transaction_Count,
    COUNT(Transaction_ID)*100.0 / (SELECT COUNT(*) FROM store_sales) AS Percentage
FROM
	store_sales
GROUP BY 
    Discount_Applied;

SELECT * FROM store_sales;

#16.Create a new column called 'Revenue_Per_Unit' by dividing 'Total_Spent' by 'Quantity'. Calculate the average 'Revenue_Per_Unit' for each category. 
SELECT
	Category,
	AVG(Revenue_Per_Unit) AS Avg_Revenue_Per_Unit
FROM 
	(SELECT
		Category,
        Total_Spent * 100.0 / Quantity AS Revenue_Per_Unit
	FROM
		store_sales) AS revenue
GROUP BY
	Category;

#17.Identify customers who have made purchases in both 'Online' and 'In-store' locations.
SELECT
	DISTINCT(s.Customer_ID)
FROM
	store_sales s 
INNER JOIN
	store_sales s1 ON s.Customer_ID = s1.Customer_ID
WHERE
	s.Location = 'Online' AND s1.Location = 'In-store';


#18.Create a pivot table showing the total 'Total_Spent' for each 'Category' and 'Payment_Method' combination. (Requires pivot table creation) */
SELECT DISTINCT Payment_Method
FROM store_sales;

SELECT
	Category,
    SUM(CASE WHEN Payment_Method = 'Digital Wallet' THEN Total_Spent ELSE 0 END) AS 'Digital Wallet',
    SUM(CASE WHEN Payment_Method = 'Credit Card' THEN Total_Spent ELSE 0 END) AS 'Credit Card',
    SUM(CASE WHEN Payment_Method = 'Cash' THEN Total_Spent ELSE 0 END) AS 'Cash'
FROM
    store_sales
GROUP BY
    Category;

#19.Identify 'Customer_ID' who have made more than 2 transactions and have an average 'Total_Spent' above 100.
SELECT
	Customer_ID,
    COUNT(Transaction_ID) AS transactions,
    AVG(Total_Spent) AS avg_total_spent
FROM
	store_sales
GROUP BY
	Customer_ID
HAVING
	transactions > 2 AND avg_total_spent >100;

#20.Create a new column called 'Day_of_Week' based on the 'Transaction_Date'.Analyze which day of the week has the highest 'Total_Spent'. 
SELECT
    DAYNAME(Transaction_Date) AS Day_of_Week,
    SUM(Total_Spent) AS Total_Spent
FROM
    store_sales
GROUP BY
    DAYNAME(Transaction_Date)
ORDER BY
    Total_Spent DESC
LIMIT 1;