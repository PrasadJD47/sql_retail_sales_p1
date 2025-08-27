--- Check The Data

select * from [dbo].['SQL _Retail_Sales_Analysis_utf$']

--- Check whether it has appropiate count

select count(*) from [dbo].['SQL _Retail_Sales_Analysis_utf$']

--- Checking for null values

select * from [dbo].['SQL _Retail_Sales_Analysis_utf$']
where transactions_id is null

select * from [dbo].['SQL _Retail_Sales_Analysis_utf$']
where total_sale is null

select * from [dbo].['SQL _Retail_Sales_Analysis_utf$']
where sale_time is null

select * from [dbo].['SQL _Retail_Sales_Analysis_utf$']
where sale_time is null

--- Checking for null values (Single Code)

select * from [dbo].['SQL _Retail_Sales_Analysis_utf$']

where transactions_id is null
or
sale_date is null
or
sale_time is null
or 
gender is null
or 
age is null
or 
category is null
or 
quantiy is null
or 
cogs is null
or
total_sale is null
or
price_per_unit is null
or 
customer_id is null

--- Delete the null rows

delete from [dbo].['SQL _Retail_Sales_Analysis_utf$']
where transactions_id is null
or
sale_date is null
or
sale_time is null
or 
gender is null
or 
age is null
or 
category is null
or 
quantiy is null
or 
cogs is null
or
total_sale is null
or
price_per_unit is null
or 
customer_id is null

--- Data Exploration

--- How many sales we have?

select count(*) as total_sale from [dbo].['SQL _Retail_Sales_Analysis_utf$']

---How many distinct customers we have?

select count(distinct customer_id) as total_sale from [dbo].['SQL _Retail_Sales_Analysis_utf$']

--- Unique Categories

select distinct category as unique_category from [dbo].['SQL _Retail_Sales_Analysis_utf$']
select count(distinct category) as unique_category from [dbo].['SQL _Retail_Sales_Analysis_utf$']

--- Data Analysis


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from  [dbo].['SQL _Retail_Sales_Analysis_utf$']
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT 
     category, 
     SUM(case when quantiy >= 4 then 1 else 0 end) AS total_quantity
FROM [dbo].['SQL _Retail_Sales_Analysis_utf$']
WHERE category = 'Clothing'
     AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
GROUP BY category

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
     category,
     sum(total_sale) as net_sale,
     count(*) as total_orders
from -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
     round(avg(age),2) as avg_age_beauty
from [dbo].['SQL _Retail_Sales_Analysis_utf$']
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select 
     * 
from [dbo].['SQL _Retail_Sales_Analysis_utf$']
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
     category,
     gender,
     count(*) as total_trans
from [dbo].['SQL _Retail_Sales_Analysis_utf$']
group by 
     category,
     gender
order by
      total_trans

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * from 
(
    select 
         year(sale_date) as year,
         month(sale_date) as month,
         avg(total_sale) as avg_sale,
         rank () over (partition by year(sale_date) order by avg(total_sale) desc) as rank_within_year
    from [dbo].['SQL _Retail_Sales_Analysis_utf$']
    group by 
         year(sale_date),
         month(sale_date)
) as t1 
where rank_within_year = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select top 5
    customer_id,
    sum(total_sale) as total_sale,
    rank() over(order by sum(total_sale) desc) as customer_rank
from [dbo].['SQL _Retail_Sales_Analysis_utf$']
group by customer_id
order by total_sale desc

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select
    category,
    count(distinct customer_id) as unique_customers
from [dbo].['SQL _Retail_Sales_Analysis_utf$']
group by category 


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sales as (
    select *,
        case 
            when datepart(Hour,sale_time) < 12 then 'Morning'
            when datepart(Hour,sale_time) between 12 and 17 then 'Afternoon'
            else 'Evening'
        end as shift 
    from [dbo].['SQL _Retail_Sales_Analysis_utf$']
)
select 
    shift,
    count(*) as total_orders
from hourly_sales
group by shift;



--- End of Project


