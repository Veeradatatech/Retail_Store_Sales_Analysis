## 📊 Retail Store Sales Analysis (2022-2025)

# 📝 Project Overview

This project focuses on designing and analyzing a Retail Store Sales Database using MySQL, based on a real-world-like synthetic dataset. The data represents transaction records for a retail company dealing in furniture, electric essentials, food, beverages, and general product supplies spanning data from 2022 to 2025, the project aims to uncover business insights by tracking key metrics such as:

* Product categories and pricing

* Payment methods

* Transaction timestamps

* Sales performance and discounts

The primary goals of this project include:

* Structuring a robust relational database schema

* Cleaning and analyzing large datasets efficiently

* Generating business-critical insights using complex SQL queries

* Applying advanced SQL concepts such as window functions, CTEs, and conditional logic

This end-to-end project demonstrates real-world SQL data analysis skills applicable to roles in data analytics, business intelligence, and database development.

# 📦 Dataset Details

The dataset **Retail_Store_Sales** used for this project is sourced from **Kaggle**, a popular platform for datasets.
It contains real-world sales data, which **Retail Store Sales dataset** contains 12,575 rows of synthetic data representing sales transactions from a retail store.

* **Source**  : Kaggle -  [Download here](https://www.kaggle.com/datasets/ahmedmohamed2003/retail-store-sales-dirty-for-data-cleaning)

* **Volume**  : 12,575 rows

* **Format**  : CSV

* **Key Fields**: Transaction_ID, Customer_ID, Category, Item, Price_Per_Unit, Quantity, Total_Spent, Payment_Method, Location, Transaction_Date, Discount_Applied.

<img width="1322" alt="sales" src="https://github.com/user-attachments/assets/de2d855e-e258-4387-8073-b3f878743787" />

# 🔍 Key Business Questions & Deep-Dive Insights

# Total Spend by Customer
* **Insight** : Highest total spend by customer.
* **Pattern** : Customers prefer higher-priced items and purchase more frequently.
  
     ![sum](https://github.com/user-attachments/assets/b23ec645-7db2-4e00-bd0d-9d45483f4978)
  
# Customer Transaction Frequency vs Average Spend
* **Insight** : High transaction volume across multiple customers, with modest variations in average total spend.
* **Pattern** : Customer CUST_05, CUST_24, and CUST_08 lead both in transaction count and average spend, marking them as high-value and high-engagement users.

     ![3](https://github.com/user-attachments/assets/9a6d3d02-d131-44c0-8107-be59b6448c78)

# Average Spend by Payment Method
* **Insight** : Customers who pay by Cash tend to have the highest average spending, followed by Credit Card users, and then Digital Wallet users.
* **Pattern** : **Cash** payments lead with an average total spend above 124.5, suggesting that these transactions might be larger or bulk purchases. **Credit Card** payments follow closely, indicating it’s a preferred method for moderate to high-value transactions. **Digital Wallets** show the lowest average spend (~122.5), possibly indicating quick, smaller purchases or mobile-first behavior.

     ![1](https://github.com/user-attachments/assets/68246e2d-654c-46ca-9493-b8af1c33ccc0)

# Transaction Volume by Location
* **Insight** : The distribution of transactions is almost evenly split between Online and In-store locations, with a slight tilt toward In-store purchases.
* **Pattern** : This near-even distribution indicates strong presence across both physical and digital channels. **In-store**: 6.35K transactions (50.53%) **Online**: 6.22K transactions (49.47%)

    ![category](https://github.com/user-attachments/assets/2db03572-1eaf-4d56-b88f-11eea5ad5f95)

# Total Sales by Product Category
* **Insight** : Butchers leads in overall spending, followed closely by Electric Home Essentials and Beverages. Milk Products and Patisserie categories see the lowest total spend.
* **Pattern** : This breakdown supports category-specific strategies and pricing decisions.

    ![total spend](https://github.com/user-attachments/assets/511f4744-404c-46bd-bdf2-a861995d838b)

# 🧮 SQL Concepts Used

The development of this project, I used various MySQL syntax and functions to manage and analyze the data,including:
                  
                    **CREATE DATABASE**- To create the database structure.
                    
                    **LOAD DATA INFILE**- To load data from external files into the database.
                    
                    **SELECT,FROM** - To retrieve all data from the tables.
                    
                    **AVG,SUM,COUNT**- For calculating average,sum and count for specific fields.
                    
                    **MAX,MIN**- To find the maximum and minimum values in specific fields.
                    
                    **DISTINCT**- To retrieve unique values from dataset table.
                    
                    **ROW_NUMBER(),OVER(),LAG**- Compare data across rows using window functions.
                   
                    **CASE STATEMENT**- This logic condition used to implement within dataset table.
                    
                    **DATE**- To filter data by date,month,year and week.
                    
                    **PERCENTAGE**- To calculate percentages for sales.
                    
                    **LIMIT**- To restrict the number of records by limit.
                    
# 🛠 Tools & Technologies

* **MS Excel** : For Data Cleaning

* **MySQL**    : For Data Modeling, Transformation, Complex Querying and Analysis of Sales and Customer Data.



