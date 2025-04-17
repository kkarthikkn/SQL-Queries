# View
-- A view in SQL is essentially a virtual table that is defined by a SQL query. Unlike a regular table, a view does not store data physically & doesn't occupy space in database. 
-- Instead, it dynamically retrieves data from one or more underlying tables (or even other views) whenever you query it.

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName  VARCHAR(50),
    LastName   VARCHAR(50),
    Salary     DECIMAL(10,2),
    Department VARCHAR(50)
);


INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, Department)
VALUES
    (1, 'Alice', 'Johnson', 55000.00, 'Sales'),
    (2, 'Bob',   'Smith',   60000.00, 'IT'),
    (3, 'Carol', 'Davis',   52000.00, 'Sales'),
    (4, 'Dave',  'Wilson',  58000.00, 'HR');
    
select * from employees;

drop view if exists high_earners;

create view high_earners as
select concat(firstname,' ', lastname) as Fullname, salary
from employees
where salary>=55000
order by 2 desc;

select * from high_earners;

INSERT INTO Employees VALUES
(5, 'Tom', 'Smith', 70000.00, 'Sr.Manager');  # it automatically adds to the views



#Advantages:
-- Simplifies complex queries
-- Improves data security
-- Encapsulates business logic
-- Provides data abstraction