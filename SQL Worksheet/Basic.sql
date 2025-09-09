use mydatabase;
-- This is single line comment
/* this is multi line comment */
-- Retrieve all customer data
SELECT *
FROM customers;
-- Retrieve all orders data
SELECT *
FROM orders;
-- Retrive each customer name,country and score from customer table
select 
	first_name,
	country,
	score
FROM customers;
-- Retrieve customer whose score is not equal to 0
SELECT *
FROM customers
WHERE score !=0;
-- Retrieve customer that come from Germany
SELECT 
	first_name,
	country
FROM customers
WHERE country = 'Germany';
-- Retrieve all the customer and sort reult based of their score in descending order
SELECT *
FROM customers
ORDER BY score DESC;
-- Retrieve all the customers details such that customer with lowest score should come first
SELECT * 
FROM customers
ORDER BY score ASC;
-- Sorting based on multiple column country and score such that country in ASC and score in DESC
SELECT *
FROM customers
ORDER BY country ASC,score DESC;
 -- Find total score for each country
 SELECT 
	 country as customer_counrty,
	 SUM(score) as total_score
 FROM customers
 GROUP BY country;
 --
  SELECT 
	 country as customer_counrty,
	 SUM(score) as total_score,
     first_name
 FROM customers
 GROUP BY country,first_name;
 -- Find total number of customer and total score for each country
 SELECT
	 count(id) as customer_count,
	 SUM(score) as total_score,
	 country
 FROM customers
 GROUP BY country;
 --  Find the average score of each country considering only customer with score not equal to 0 and
 --  return only those country whose average score is greater than 430
 SELECT 
	 country,
	 AVG(score) as avg_score
 FROM customers
 WHERE score != 0
 GROUP BY country
 HAVING AVG(score) > 430;
-- DISTINCT(Expensive Operation): Return unique list of all country
SELECT DISTINCT country 
FROM customers;
-- Limit: Retreive only 3 customers from customer table
SELECT * 
FROM customers
LIMIT 3;
-- Retrieve top 3 customer with Highest score
SELECT *
FROM customers
ORDER BY score DESC
LIMIT 3;
-- Retrieve customer with 2 customer with Lowest score
SELECT * 
FROM customers
ORDER BY score ASC
LIMIT 2;
 --
 select * from orders;
 -- Get two most recent orders
 SELECT * 
 FROM orders
 ORDER BY order_date DESC
 LIMIT 2;
SELECT *
FROM customers;
SELECT * 
FROM orders;
SELECT
	  123 as static_value,
     'hello' as default_message;
 SELECT 
	id,
	first_name,
	'new_customer' as customer_type
 from customers;
 -- Create a table person with id,person_name,birth_date and phone as column
 use  mydatabase;
 CREATE TABLE persons(
 id int not null,
 person_name varchar(50) not null,
 birth_date date ,
 phone varchar(15) not null,
 constraint pk_person PRIMARY KEY (id));
 desc persons;
 ALTER TABLE persons
 ADD email varchar(50) NOT NULL;
 select * from persons;
 ALTER TABLE persons
 DROP COLUMN phone;
 -- Drop person table from mydatabase
 DROP TABLE persons;
 -- Insert into table customers
 INSERT INTO customers (id,first_name,country,score)
 VALUES
 (6,"Anna","USO",NULL),
 (7,"Sam",NULL,100);
 select * from customers;
 INSERT INTO customers
 VALUES (8,"USA","Max",NULL),
 (9,"Andreas","Germany",NULL);
  INSERT INTO customers(id,first_name)
 VALUES(10,"Sahra");
  -- Insert data from customer table to persons table
  INSERT INTO Persons
  SELECT 
    id,first_name,NUll,
    "Unknown"
    from customers;
select * from persons;
--  Update data rows score in existing table of customer id 6 to 0
Update customers
SET score =0 
WHERE id =6;
select * from customers;
UPDATE customers
SET country = "UK",score =0
where id = 10;
-- Update all customer with NULL score to 0;
use mydatabase;
UPDATE customers
SET score = 0
where score is NULL;
-- Delete all the customer whose id is greater than 5
DELETE FROM customers where id>5;
select * from persons;
DELETE FROM persons;
TRUNCATE persons;
-- WHERE Operators
-- LIKE OPERATORS
-- Find all customers whose first name starts with 'M'
Select * from customers where first_name like 'M%';
-- Find all the customers whose first name ends with 'n'
Select * from customers where first_name like '%n';
-- Find all the customer whose first name contains r in their name
select * from customers where first_name like '%r%';
-- Find all the customers name whose first name has 'r' in the third positon
Select * from customers where first_name like '__r%'; 
-- Retrieve result from both table customer and order separate
-- 1. NO JOIN
select * from customers;
select * from orders;
-- 2. INNER JOIN
-- Get all the customers along with thier orders but only for customers who have placed order
SELECT * FROM
customers
INNER JOIN orders
ON customers.id = orders.customer_id;
-- 3. LEFT JOIN:
-- Get all the customers along with their orders and including those who don't have any order
SELECT * FROM 
customers
LEFT JOIN orders 
ON customers.id = orders.customer_id;
 -- 4.RIGHT JOIN
 -- Get all the customer with their orders including orders without any match
 SELECT *
 FROM customers
 RIGHT JOIN orders 
 on customers.id = orders.customer_id;
 -- 5.FULL JOIN:LEFT JOIN + RIGHT JOIN
 -- Get all the customers and all orders even if there is no match
SELECT * FROM 
customers
LEFT JOIN orders 
ON customers.id = orders.customer_id
UNION
 SELECT *
 FROM customers
 RIGHT JOIN orders 
 on customers.id = orders.customer_id;
 -- Advance Join
 -- 1.LEFT ANTI JOIN
 use mydatabase;
 -- Get all the customer who have not placed orders till now
 SELECT * FROM
 customers
 LEFT JOIN orders
 ON customers.id =orders.customer_id
 WHERE orders.customer_id IS NULL; 
 -- RIGHT ANTI JOIN
 -- Find orders details which has not been ordered by customer in customer table
 SELECT * FROM 
 customers
 RIGHT JOIN orders
 ON customers.id = orders.customer_id
 WHERE customers.id IS NULL;
 -- FULL ANTI JOIN
  SELECT * FROM
 customers
 LEFT JOIN orders
 ON customers.id =orders.customer_id
 WHERE orders.customer_id IS NULL
 UNION
  SELECT * FROM 
 customers
 RIGHT JOIN orders
 ON customers.id = orders.customer_id
 WHERE customers.id IS NULL;
 -- CROSS JOIN
 -- Generate all possible combinations from customers and orders table.
 SELECT * FROM customers
 CROSS JOIN orders;
 -- Using salesDB
use salesdb;
 -- Retrieve a list of all orders ,along with the related customer,product and employee details;
 select * from customers;
 select * from products;
 select * from employees;
 select * from orders;
 SELECT * FROM 
 Orders as o LEFT JOIN
 customers as c ON c.id = o.customerid
 JOIN employees e on e.employee_id = o.customerid
 JOIN product  p on p.productid = o.productid;
 -- SET OPERATIONS
-- Combine data from employee and customer table
select * from employees;
select * from customers;
SELECT firstname,lastname
FROM customers
UNION
SELECT firstname,lastname 
FROM employees;
-- UNION ALL
SELECT firstname,lastname
FROM customers
UNION ALL 
SELECT firstname,lastname 
FROM employees;

 
 
 
