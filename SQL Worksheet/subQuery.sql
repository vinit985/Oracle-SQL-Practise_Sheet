-- Find the employee whose salary is more than average salary earned by all employee
select * from employee;
select * from employee where salary > (select AVG(salary) from employee);
--Scalar subquery:It will return one row and one coulmn always.
select * from employee e
join (select AVG(salary) as avg_salary from employee ) as avg_sal
on e.salary > avg_salary;
--Multiple row subquery
-- Multiple row and multiple column
--One coulmn and multiple rows
-- Find the employees who earn the highest salary in each department
select * from employee;
select * from department;
-- Multiple coulmn with multiple row
select * from employee where (dept_id,salary) IN (
select dept_id ,max(salary)
from employee
group by dept_id);
-- Single coulmn and multiple row
select * from employee;
select * from department;
-- Find the department which has no employee;
select id,dept_name from department where
id not in (select DISTINCT dept_id from employee);
-- Correlated subquery
-- Find the employees in each department who earn more than the average salary in that department.
select * from employee e where salary > (select avg(salary) from employee ee
                                         where ee.dept_id = e.dept_id);
-- Another way
select * from employee e
join (select dept_id,avg(salary) as av_sala from employee group by dept_id) avg_salry
on e.dept_id = avg_salry.dept_id
where e.salary > avg_salry.av_sala;
-- Find the department who do not have any employee
select * from department where id NOT IN (select DISTINCT dept_id from employee);
select * from department d where id NOT IN
                                  (select DISTINCT dept_id from employee e where d.id = e.dept_id);
-- SUBQUERY -- Query inside query
-- Find the stores whose sales is better than average sales across all stores
--1) Find average of each stores.
--2) Find average of all stores.
--3)Combine 1 and 2
select * from sales;
select  *
from (select store_name,sum(price) as total_sales
      from sales
	  group by store_name) sales
join (select AVG(total_sales) as sales
      from (select store_name,sum(price) as total_sales
	   from sales
	   group by store_name) x) avg_sales
	   on sales.total_sales>avg_sales.sales;
-- Using With clause
with sales as (select store_name,sum(price) as total_sales
      from sales
	  group by store_name)
select * 
from sales
join (select AVG(total_sales) as sales
      from sales x) avg_sales
	   on sales.total_sales>avg_sales.sales;
-- Four clause that we need in subquery
--SELECT,FROM,WHERE,HAVING
--Subquery in select clause
-- Fetch all the employee details and remark to those employee who earns more than average pay
select *,(
CASE
 WHEN e.salary > (select avg(salary) from employee) then 'Higher than average salary'
 else NUll
 END) as remark
 from employee e
 ;
 -- USing join 
 select *,(
CASE
 WHEN e.salary >avg_salary.sal then 'Higher than average salary'
 else NUll
 END) as remark
 from employee e
 cross join (select avg(salary) sal from employee)  as avg_salary
  ;
-- HAVING
-- Find the stores which has sold more units than the average units sold by all the stores
select store_name,sum(quantity) as total_unit_by_each_store
from sales
group by store_name
having sum(quantity) > (select avg(quantity) from sales);

------------------------------------Another subquery video-------------------------------------;
use salesdb;
select * from orders;
select AVG(sales) from orders;
select orderid from orders;
select * from orders;
-- Using subquery with from clause
-- Find the product that have price greater than average price of all the products
select * from products;
select * from products where
price >
       (select AVG(price) from products);
       