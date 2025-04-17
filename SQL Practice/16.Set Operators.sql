# Set Operators

-- ======================================================
-- Table: Customers
-- ======================================================
drop table if exists customers;
CREATE TABLE Customers (
    CustomerID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INT,
    PRIMARY KEY (CustomerID)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Country, Score) VALUES
    (1, 'Jossef', 'Goldberg', 'Germany', 350),
    (2, 'Kevin', 'Brown', 'USA', 900),
    (3, 'Mary', NULL, 'USA', 750),
    (4, 'Mark', 'Schwarz', 'Germany', 500),
    (5, 'Anna', 'Adams', 'USA', NULL);

-- ======================================================
-- Table: Employees
-- ======================================================
CREATE TABLE Emp2 (
    EmployeeID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    BirthDate DATE,
    Gender CHAR(1),
    Salary INT,
    ManagerID INT,
    PRIMARY KEY (EmployeeID)
);

INSERT INTO Emp2(EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID) VALUES
    (1, 'Frank', 'Lee', 'Marketing', '1988-12-05', 'M', 55000, NULL),
    (2, 'Kevin', 'Brown', 'Marketing', '1972-11-25', 'M', 65000, 1),
    (3, 'Mary', NULL, 'Sales', '1986-01-05', 'F', 75000, 1),
    (4, 'Michael', 'Ray', 'Sales', '1977-02-10', 'M', 90000, 2),
    (5, 'Carol', 'Baker', 'Sales', '1982-02-11', 'F', 55000, 3);

# Rules: * Number of columns should be same in the queries performing set operation
#	    * Matching Datatype of columns 
#	    * Ordering of columns should be same 
#	    * For aliasing, it totally depends on the first query. it ignores the aliases for the next query
#  	    * Make sure that, mapping correct columns or not
# 	    * 'Order By' can be used only once

# NOTE--> Try to avoid asterisk(*) while selecting in set operation. So, specify the column names

# Union : NO duplicates allowed

select firstname,lastname
from customers
union
select firstname,lastname
from emp2;

-- =================================
# Union all: Duplicates are allowed. It is fastest compared to 'Union'

select firstname,lastname
from customers
union all
select firstname,lastname
from emp2;

-- =================================
# Except(Minus): returns distinct rows from th 1st query that are not found in 2nd query
# emp2 - customers, it ignores the common records in each table & displays the records in 1st table

select firstname,lastname
from emp2
except
select firstname,lastname
from customers;

-- =================================
# Intersect: returns the common rows in both queries

select firstname,lastname
from emp2
intersect
select firstname,lastname
from customers;
















