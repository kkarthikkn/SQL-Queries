-- Alter
drop table if exists employees;

create table employees(
	empid int primary key,
     f_name varchar(20) not null,
     l_name varchar(20) not null
);

desc employees;

-- adding column
alter table employees
add email varchar(50);

-- dropping column
alter table employees
drop column l_name;

-- renaming table
alter table employees
rename to emp;

desc emp;

alter database de_projects
rename to sql_practice;