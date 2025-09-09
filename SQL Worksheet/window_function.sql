-- Find the total sales across all orders
select * from orders;
select SUM(sales)
from orders;
-- Find the total sales for each product
select 
	productid,
	sum(sales) as total_sales
from orders
group by productid;
-- Find the total sales for each product,addtionally provide orderid and order date
select 
	orderid,
	orderdate,
	productid,
	sum(sales) over() as total_sales_done_by_department
from orders;
-- Find the total sale for each product and additonally display order id and order date
select 
	orderid,
	orderdate,
    productid,
	sum(sales) over(partition by productid) 
from salesdb.orders;
-- Find the total sales for each product 
-- Find the total sales across all orders 
-- Find the total sales for each combination of prdoduct and order status 
-- and additonally display order id and order date
select * from orders;
select 
	orderid,
	orderdate,
    productid,
    sales,
    orderstatus,
	sum(sales) over(partition by productid) ,
    sum(sales) over(),
    sum(sales) over(partition by productid,orderstatus)
from salesdb.orders;
-- Rank each order based on their sales from highest to lowest and also provide additional data
select 
	orderid,
	orderdate,
	sales,
	RANK() OVER(order by sales ASC) as sales_rank
 from orders;
-- Using frame
select 
	orderid,
	orderdate,
	sales,
    orderstatus,
	sum(sales) OVER(partition by orderstatus order by orderdate rows between current row and 2 following ) 
    as sales_rank
 from orders;
-- Rank customer based on their total sales
use salesdb;
select * from orders;
select 
	customerid,
	sum(sales) as sum_sales,
	RANK() OVER(order by sum(sales) DESC )
from orders
group by customerid;
-- Aggreate window function :COUNT
select COUNT(*) from orders;
-- Find the total number of orders along with order id and order date
-- Find the total number of order for each customer
select 
	orderid,
    customerid,
	orderdate,
	count(*) Over() as total_row_count,
    count(*) over(partition by customerid)  as customer_row_count
from orders;
-- FInd the total number of customer with additional details
select * from customers;
	select *,
	count(*) over() as customercount
from customers;
-- Find the total number of scores for the customers
select 
	*,
	count(score) over() as scorecount,
	count(country) over() as countrycount
from customers;
-- Check whether orders table contains duplicate or not
select * from orders;
select orderid,count(orderid) over(partition by orderid) from orders;
select * from orders_archive;
select * from (
select 
	orderid,
	count(orderid) over(partition by orderid) as countorder
from orders_archive) as X
where countorder>1;
-- Find the total sales across all orders and the total sales for each product additionally ,provide details such as orderID and order date
select 
	orderid,
	orderdate,
    productid,
    SUM(sales) over() as total_sales_sum,
    sum(sales) over(partition by productid) as total_product_sold
from orders;
-- Find the percentage contribution of each product sales to the sales table
select * from orders;
select * from (
 select orderid,productid,sales,
 Sum(sales) over() as total_Sales,
 ROUND((CAST(sales AS Float)/ Sum(sales) over()) * 100,2) as percentageContribution
 from orders) X;
 -- AVG: Window Function
 -- Find the average sales across all the orders and the average sales for each product and include order id and order date
 select orderid,
 sales,
 AVG(sales) over() as AvgSales,
 AVG(sales) over(partition by productid) as AvgSalesByProduct,
 orderdate
 from orders;
 select * from orders;
 -- Find average score of customers and include customer id and last name
 select * from customers;
 select customerid,lastname,score,
 ROUND(AVG(score) over(),2) as AvgScoreWithNull,
ROUND(AVG(coalesce(score,0)) over(),2) as AvgScoreWithOutNull
 from customers;
 -- Find the orders where sales are higher than the average sales across all orders
 select * from (
 select orderid,sales,productid,
 AVG(sales) over() as AvgSales
 from orders) Y
 where sales> AvgSales;
 -- MIN|MAX function
-- Find the highest and lowest sales across all products
-- FInd the highest and lowest sales for each products and additionally fetch order id and order date
select
   orderid,
   orderdate,
   productid,
   sales,
   MAX(sales) over() as MaxSales,
   MIN(Sales) over() as MinSales,
   MAX(sales) over(partition by productid) as MaxByEachProduct,
   MIN(sales) over(partition by productid) as MinByEachProduct
from orders;
 select * from orders;
 -- Show the employees with the highest salary
 select * from employees;
 select * from 
 (
 select 
     *,
     MAX(salary) over() as MaxSalary
from employees) X
where salary = MaxSalary;
-- Calculate the deviation of each sale from both the minimum and maximum sales amount
select
   orderid,
   orderdate,
   productid,
   sales,
   MAX(sales) over() as MaxSales,
   MIN(Sales) over() as MinSales,
   MAX(sales) over(partition by productid) as MaxByEachProduct,
   MIN(sales) over(partition by productid) as MinByEachProduct,
   sales -  MIN(Sales) over()  as DeviationFromMin,
    MAX(sales) over()  - sales as DeviationFromMax
from orders;
--


 