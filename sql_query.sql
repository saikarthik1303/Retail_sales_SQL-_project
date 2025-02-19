
__SQL RETAIL PROJECT__
create database sql_project_p2;
Drop table if exists retail_sales

create table (
	transactions_id INT primary key,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(10),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
)

select * from retail_sales
limit 10

select count(*) from retail_sales
-------

select * from retail_sales
where transactions_id IS NULL

select * from retail_sales
where sale_date IS NULL

select * from retail_sales 
where
     transactions_id IS NULL
	 or
	 sale_date IS NULL
	 or 
	 sale_time is NULL
	 or 
	 customer_id is NULL
	 or 
	 gender is NULL
	 or 
	 age is null
	 or 
	 category is null
	 or 
	 quantiy is Null
	 or 
	 price_per_unit is null
	 or 
	 cogs is null
	 or 
	 total_sale is null
	 
	 
	 
------data cleaning----
delete from retail_sales where
 transactions_id IS NULL
	 or
	 sale_date IS NULL
	 or 
	 sale_time is NULL
	 or 
	 customer_id is NULL
	 or 
	 gender is NULL
	 or 
	 age is null
	 or 
	 category is null
	 or 
	 quantiy is Null
	 or 
	 price_per_unit is null
	 or 
	 cogs is null
	 or 
	 total_sale is null

-----
--DATA exploration---

---How many sales we have??
select count(*) as total_sales  from retail_sales  

---How many distinct customers we have?
select count(distinct(customer_id)) as total_customers from retail_sales

---How many distinct categories we have?
select distinct(category) as total_customers from retail_sales

--Data/ Business Analysis
----- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


--1.
select * from retail_sales where sale_date='2022-11-05'

--2.
select * from retail_sales where category='Clothing' and to_char(sale_date,'YYYY-MM')='2022-11'and quantiy>=4

--3.
select category,sum(total_sale) as net_sale, 
count(*) as total_orders 
from retail_sales 
group by category 

--4.
select round(avg(age),2) as avgAge from retail_sales
where category='Beauty' 

--5.
select  * from retail_sales where total_sale>1000

--6.
select category, gender, count(*) as total_transs from retail_sales 
group by category,gender

--7.
select year,month,avg_sale from(
select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale)desc)
from retail_sales group by 1,2) as t1 
where rank=1

--8.
select  customer_id, sum(total_sale) as total_sale from retail_sales group by 1
order by 2 desc limit 5

--9.
select category,
count(distinct(customer_id)) as uniqueid from retail_sales 
group by 1


--10.
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- End

