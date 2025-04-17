create database de_projects;

create table test(sno int, name varchar(20));

insert into test values(1,'Alice'),
				   (2,'Bob');

select * from test;

update test set name='John', sno=3 where sno=1;  -- able to update more than 2 columns
select * from test;

delete from test where sno=3;

truncate table test;   -- records in the table will be deleted not the structure

drop table test;  -- drops the entire table

-- --------------------------

# Types of creating table
use de_projects;

-- 1. Default
create table employees(
	empid INT PRIMARY KEY,
     f_name varchar(50) not null,
     l_name varchar(50) not null,
     hire_date date not null,
     salary decimal(10,2)
);

-- 2. CTAS (Create Table AS)
create table high_paid_emp as
select empid, f_name, l_name
from employees
where salary>50000;

-- 3. Temporary Table
create temporary table temp_high_salary(
	empid int,
     salary decimal(10,2)
);

-- 4. CTE
with high_salary_cte as(
	select empid,f_name,l_name,salary
     from employees
     where salary>70000
)

select * from high_salary_cte;
