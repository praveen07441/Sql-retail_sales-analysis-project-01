DROP TABLE retail_sales;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT *
FROM retail_sales;


SELECT * FROM retail_sales
WHERE 
     transaction_id IS NULL
	 OR 
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

--DELETE THOSE NULL VALUES
DELETE FROM retail_sales
WHERE 
     transaction_id IS NULL
	 OR 
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

	 

-- how many sales in total we have 
	 SELECT COUNT(*)
	 FROM retail_sales;


--1.how many customers we have 
    SELECT COUNT(customer_id) 
	FROM retail_sales;

--2. how many unique customers
   SELECT DISTINCT customer_id
   FROM retail_sales;

--3. how many category
   SELECT DISTINCT category
   FROM retail_sales;


--DATA ANALYSIS AND BUSINESS PROBLEMS
--1.retrieve all the columns for the sales made on 2022-11-05
  SELECT *
  FROM retail_sales
  WHERE sale_date='2022-11-05';
	 
--2.  retrieve all the transactions made in the category 'clothing' and quantity>=4 and in month of november
	  SELECT *
	  FROM retail_sales
	  WHERE TO_CHAR(sale_date,'YYYY-MM')='2022-11' AND quantity>=4 AND category='Clothing'
	  
	 
-- Q3 SQL query to calculate the total sales for each category 
     SELECT 
	 category,
	 SUM(total_sale) AS net_sale,
	 COUNT(*) AS total_orders
	 FROM retail_sales
	 GROUP BY 1;


--Q.4 Find the average of the customers who purchased from the 'beauty' category
     SELECT 
	 ROUND(AVG(age)) AS avg_age
	 FROM retail_sales
	 WHERE category='Beauty'
	 
--Q.5 SQL QUERY to find all the transactions where the total_sale is greater than 1000
     SELECT  *
	 from retail_sales
	 WHERE total_sale>1000;

--Q.6 SQL query find all the transactions based on  each gender and  each category
     SELECT category,gender,
	 COUNT(*) AS total_trans
	 FROM retail_sales
	 GROUP BY category,gender
	 ORDER BY category,gender DESC;

--Q.7 SQL query average sale for each month and best selling month in each year
     SELECT year,month,avg_sale
	 from 
	 (
	 SELECT 
	 EXTRACT(YEAR FROM sale_date)AS year,
	 EXTRACT(MONTH FROM sale_date)AS month,
	 AVG(total_sale)AS avg_sale,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)AS Rank
	 FROM retail_sales
	 GROUP BY 1,2
	 )
	 WHERE Rank=1;


--Q.8 Find the top 5 customers based on the highest total sales

    SELECT customer_id,SUM(total_sale)AS total_sales
	FROM retail_saleS
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;
	
--Q.9 unique customers who purchased items from each category
   SELECT category,
   COUNT(DISTINCT customer_id)AS unique_customer
   FROM retail_sales
   GROUP BY category;


--Q.10 calculate the total orders based on morning like time<12,afternoon time between 12 and 17 and evening >17
   SELECT *,
   CASE 
       WHEN EXTRACT(HOUR FROM sale_time )<12 THEN 'Morning'
	   WHEN EXTRACT(HOUR FROM sale_time)BETWEEN 12 AND 17 THEN 'Afternoon'
	   ELSE 'Evening'
	   END AS shift
	   FROM retail_sales;


	   WITH hourly_sales AS
	   (
	   SELECT *,
       CASE 
          WHEN EXTRACT(HOUR FROM sale_time )<12 THEN 'Morning'
	      WHEN EXTRACT(HOUR FROM sale_time)BETWEEN 12 AND 17 THEN 'Afternoon'
	      ELSE 'Evening'
	      END AS shift
	      FROM retail_sales
	   )

	   SELECT shift,
	   COUNT(*) AS total_orders
	   FROM hourly_sales
	   GROUP BY shift
	   ORDER BY 2 DESC;
	 

  -- END OF retail_sales project
 
  
  
	 
	

