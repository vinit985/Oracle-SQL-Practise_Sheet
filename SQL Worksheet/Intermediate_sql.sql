select * from employee;
select * from department;
select * from manager;
select * from projects;

--Fetch the employee name and department they belong to
-- INNER JOIN: COMMON DATA FROM BOTH TABLE.
select e.emp_name,d.dept_name from employee e
join department d on 
e.dept_id = d.id;
--Fetch all the employee and their department associated with it.
--LEFT JOIN : LEFT TABLE + COMMON DATA FROM BOTH TABLE. 
select e.emp_name,d.dept_name 
from employee e
left join department d
on e.dept_id = d.id;
-- RIGHT JOIN : COMMON DATA FROM BOTH TABLE + ALL DATA FROM RIGHT TABLE
select e.emp_name,d.dept_name 
from employee e
right join department d
on e.dept_id = d.id;
-- Write a query of all employee ,their mananger ,their department and the projects they work on
select * from manager;
select * from projects;
select * from employee;
select * from department;
select
	e.emp_name,
	m.manager_name,
	d.dept_name,
	p.project_name
from employee e
left join manager m on e.manager_id = m.manager_id
left join department d on d.id = e.dept_id
left join projects p on e.emp_id = p.team_member_id; 
-- FULL join : Inner Join + all reamaining data from left table + all remaining data from right table
select e.emp_name,d.dept_name from employee e
full join department d ON
d.id = e.dept_id;
--Cross Join : Cartesian Product 
select * from employee 
cross join department
order by emp_id;
select * from company;
select * from employee;
-- Write a query to fetch the employee name and their corresponding department name and make sure to display the company code and company location for corresponding
--to each employee
select * from employee e 
join department d 
on e.dept_id = d.id
cross join company;
-- Natural Join : Sql will decide join condition not SQL user
select * from employee e
natural join department d;
Alter table department rename column dept_id to id;
--Important point to remember -->
--if two table have same name then INNER JOIN
--if two table have different name then Cartesian product(Cross Join)
-- Self Join
--Join table with itself
-- Write a query to fetch the child name ,their age and their corresponding parent name and their age
select * from family;
select parent_name,count(child_name) from
(
select 
	c.name as child_name,
	c.age as child_age,
	p.name as parent_name,
	p.age as parent_age
from family as c
join family as p
on c.parent_id = p.member_id)
group by parent_name;
;