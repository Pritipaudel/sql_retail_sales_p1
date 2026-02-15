--- Sql retail sales analysis --- first project

---create table---
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT

);


--- Data Cleaning ---
SELECT * FROM retail_sales LIMIT 10;


SELECT COUNT(*) FROM retail_sales;


select * from retail_sales
where transactions_id is NULL
or sale_date is NULL
or sale_time is NULL
or gender is NULL
or category is NULL
or quantity is null
or cogs is NULL
or total_sale is NULL;

--delete--
DELETE FROM retail_sales
where transactions_id is NULL
or sale_date is NULL
or sale_time is NULL
or gender is NULL
or category is NULL
or quantity is null
or cogs is NULL
or total_sale is NULL;   


--- Data Exploration---

-- how many sales we have--

select count(*) as total_sales from retail_sales

--- how many customers we have? -- 
select count(customer_id) as customers from retail_sales

--- how many unique customers we have? -- 
select count(distinct customer_id) as customers from retail_sales


--- how many categories we have---
select count(distinct category) as categories from retail_sales

-- name of the distinct categories--
select distinct(category) from retail_sales


---Data analysis and business key problems and answer

--write a sql query to retrieve all coulmns for sales made  on '2022-11-05'
select * from retail_sales
where sale_date = '2022-11-05';

---write a sql query to retrieve all transactions where the category is clothing and the quantity sold is more than 4 in the month of nov-2022
select * from retail_sales
where category = 'Clothing' and to_char(sale_date, 'YYYY-MM') = '2022-11' AND quantity >= 4

---write a sql query to calculate the total sales for each category---
select category, sum(total_sale) as sum_by_category, count(*) as total_order  from retail_sales group by category



---write a sql query to find the average age of customers who purchased item from the beauty category
select round(avg(age), 2) as avg_age from retail_sales where category = 'Beauty'

---write a sql query to find all transactions where the total_sale is greater than 1000---
select category,quantity,price_per_unit,total_sale from retail_sales
where total_sale > 1000

---write a sql query to find the total number of transactions (transactions_id) made by each gender in each category
select gender, category, count(*) as total_trans from retail_sales
group by gender,category

--write a sql query to calculate the average sale for each month find out the best selling in each year
select 
EXTRACT(YEAR FROM sale_date) as year,  ---used to extract year from the date--
EXTRACT(MONTH FROM sale_Date) as month,
avg(total_sale) as avg_sale from retail_sales
group by 1, 2
order by 1,3 desc

---write a sql query to find the total 5 customers based on the highest total sale
select customer_id, SUM(total_sale) as total_sale from retail_sales
group by customer_id
order by 2 desc
limit 5

---write a sql query to find the number of unique customers who purchased item from each category
select category, count(distinct customer_id) as no_of_customers from retail_sales
group by category


---write a sql query to create each shift and number of orders (example morning <=12)
select *,
CASE
when EXTRACT(HOUR FROM sale_time) < 12 then 'morning'
when EXTRACT(HOUR FROM sale_time) between 12 and 17 then 'afternoon'
else
'evening'
end as shift
from retail_sales


---end of project---