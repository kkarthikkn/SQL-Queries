# Window Functions

-- TYPES: 
	  ----->Aggregate() ---> AVG()
	  |				---> MAX()
       |                 ---> MIN()
       |                 ---> SUM()
       |				---> COUNT()
       |                  
	  ----->Ranking()   ---> ROW_NUMBER()
	  |				---> RANK()
       |                 ---> DENSE_RANK()
       |                 ---> PERCENT_RANK()
	  |				---> NTILE()
       |
       ----->Value()     ---> LAG()
	  |				---> LEAD()
       |                 ---> FIRST_VALUE()
       |                 ---> LAST_VALUE()
	  |				---> NTH_VALUE()
;


-- TABLE STRUCTURE WON'T CHANGE & IT ADDS NEW COLUMN[WINDOW FUN]

drop table if exists sales;
CREATE TABLE Sales (
    TransactionID INT,
    Store VARCHAR(50),
    SalesAmount DECIMAL(10, 2)
);

INSERT INTO Sales (TransactionID, Store, SalesAmount)
VALUES
    (1, 'A', 100.00),
    (2, 'A', 200.00),
    (3, 'A', 150.00),
    (4, 'B', 250.00),
    (5, 'B', 300.00);
    
select * from sales;

-- window fun with AGG()
select * ,
sum(SalesAmount) over(partition by store order by SalesAmount desc) as rownum
from sales;

select * ,
MAX(SalesAmount) over(order by SalesAmount desc) as rownum
from sales;

-- =======================================================
-- window fun with RANK()
select * ,
row_number() over(partition by store order by SalesAmount desc) as rownum
from sales;

select * ,
row_number() over(order by SalesAmount desc) as rownum
from sales;

-- DE-DUPLICATION using window() & cte
drop table if exists Emp1;
CREATE TABLE Emp1 (
    EmployeeID INT,
    Emp_Name VARCHAR(100),
    Department VARCHAR(50),
    HireDate DATE
);


INSERT INTO Emp1 (EmployeeID, Emp_Name, Department, HireDate)
VALUES
    (1, 'Alice', 'HR', '2020-05-01'),
    (1, 'Alice', 'HR', '2022-06-15'),
    (2, 'Bob', 'IT', '2021-07-10'),
    (3, 'Charlie', 'Finance', '2020-09-30'),
    (3, 'Charlie', 'Finance', '2022-05-22');

# RealWorld Usecase of window function: 
-- 	There are 2 duplicate records of the employees with different hire_date,
--    now it need to filtered out by keeping the record of earlier hire_date by row_number()


with duplicate_cte as(
	select *,
	row_number() over(partition by employeeid order by hiredate) rownum
	from emp1
     )
select employeeId,Emp_Name,department,hiredate from duplicate_cte where rownum=1;

 
-- rank()
CREATE TABLE Students (
    StudentID INT,
    StudentName VARCHAR(100),
    ExamScore INT
);

INSERT INTO Students (StudentID, StudentName, ExamScore)
VALUES
    (1, 'Alice', 95),
    (2, 'Bob', 90),
    (3, 'Charlie', 95),
    (4, 'David', 85),
    (5, 'Eva', 90);
    
-- 🥇 RANK():
-- 	Assigns the same rank to tied rows.
-- 	Skips the next rank(s) for tied rows — creates gaps.
-- 	Ex: If 2 people tie at rank 2, the next rank will be 4 (not 3).
-- 	Ranks are not continuous if there are ties.
-- 	Useful when you want to preserve the ranking gap caused by ties.

-- 🥈 DENSE_RANK():
-- 	Assigns the same rank to tied rows.
-- 	Does not skip the next rank after ties — no gaps.
-- 	Ex: If 2 people tie at rank 2, the next rank will be 3.
-- 	Ranks are always continuous.
-- 	Useful when you want to show compact rankings, especially in leaderboards.

-- rank()    
select *,
rank() over(order by examscore desc) Ranking
from students;
    
-- dense_rank()
select *,
dense_rank() over(order by examscore desc) Ranking
from students;

-- percent_rank() --> * Returns the relative rank of a row as a decimal (0 to 1).
-- 				  * Tied rows get the same percent rank.
--     			  * Used to analyze relative position in a dataset (like percentiles).
-- 				  * Must be used with OVER(ORDER BY ...).
-- 				  * Working of percent_rank() formula: (RANK() - 1) / (total_rows - 1)

#1.
select *,
percent_rank() over(order by examscore desc) Ranking
from students;

#2.
CREATE TABLE ProductSales (
    ProductID INT,
    ProductName VARCHAR(100),
    SalesAmount INT
);


INSERT INTO ProductSales (ProductID, ProductName, SalesAmount) VALUES
(1, 'Product 1', 500),
(2, 'Product 2', 600),
(3, 'Product 3', 550),
(4, 'Product 4', 700),
(5, 'Product 5', 750),
(6, 'Product 6', 800),
(7, 'Product 7', 850),
(8, 'Product 8', 900),
(9, 'Product 9', 950),
(10, 'Product 10', 1000),
(11, 'Product 11', 600),
(12, 'Product 12', 650),
(13, 'Product 13', 700),
(14, 'Product 14', 750),
(15, 'Product 15', 800),
(16, 'Product 16', 850),
(17, 'Product 17', 900),
(18, 'Product 18', 950),
(19, 'Product 19', 1000),
(20, 'Product 20', 100),
(21, 'Product 21', 200),
(22, 'Product 22', 250),
(23, 'Product 23', 300),
(24, 'Product 24', 350),
(25, 'Product 25', 400),
(26, 'Product 26', 450),
(27, 'Product 27', 500),
(28, 'Product 28', 550),
(29, 'Product 29', 600),
(30, 'Product 30', 650),
(31, 'Product 31', 700),
(32, 'Product 32', 750),
(33, 'Product 33', 800),
(34, 'Product 34', 850),
(35, 'Product 35', 900),
(36, 'Product 36', 950),
(37, 'Product 37', 1000),
(38, 'Product 38', 550),
(39, 'Product 39', 600),
(40, 'Product 40', 650),
(41, 'Product 41', 700),
(42, 'Product 42', 750),
(43, 'Product 43', 800),
(44, 'Product 44', 850),
(45, 'Product 45', 900),
(46, 'Product 46', 950),
(47, 'Product 47', 1000),
(48, 'Product 48', 550),
(49, 'Product 49', 600),
(50, 'Product 50', 650);

select *,
round(percent_rank() over(order by salesamount),2) as percent_ranking
from ProductSales;

SELECT ProductID, ProductName, SalesAmount,
PERCENT_RANK() OVER (ORDER BY SalesAmount DESC) AS PercentRank,
RANK() OVER (ORDER BY SalesAmount DESC) AS Rank_sale
FROM ProductSales;
# apply formula: (RANK() - 1) / (total_rows - 1) for understanding


-- NTILE : breaking up a result set into equally sized groups[ntile value]
-- calculation= no of rows / value of NTILE
-- ex: 10/4 = 2.5  ---->{partition by 2.5(2 to 3 rows)}

CREATE TABLE EmployeeSales (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    SalesAmount DECIMAL(10, 2)
);


INSERT INTO EmployeeSales (EmployeeID, EmployeeName, SalesAmount) VALUES
(1, 'Alice', 10000),
(2, 'Bob', 8500),
(3, 'Charlie', 7500),
(4, 'David', 6000),
(5, 'Eva', 11000),
(6, 'Frank', 4500),
(7, 'Grace', 3000),
(8, 'Hank', 4000),
(9, 'Ivy', 8000),
(10, 'Jack', 9500);

# Here, the records are equally divided/grouped into 4 different groups using ntile()
create view top_perform as
select *, 
ntile(4) over(order by salesamount desc) as sales_rank
from EmployeeSales;


select *, 
case
	when sales_rank =1 then 'Promotion' 
	when sales_rank =2 then 'Increment'
	when sales_rank =3 then 'Wait' 
	when sales_rank =4 then 'Try Hard' 
end as status_message
from top_perform;


-- =======================================================
-- window fun with VALUE()

drop table if exists EmployeeSalaries;
CREATE TABLE EmployeeSalaries (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    Salary DECIMAL(10, 2),
    Year INT
);

INSERT INTO EmployeeSalaries (EmployeeID, EmployeeName, Salary, Year) VALUES
(1, 'Alice', 5000, 2023),
(1, 'Alice', 5500, 2024),
(2, 'Bob', 4500, 2023),
(2, 'Bob', 4800, 2024),
(3, 'Charlie', 4000, 2023),
(3, 'Charlie', 4200, 2024),
(4, 'David', 4600, 2023),
(4, 'David', 4700, 2024),
(5, 'Eva', 5200, 2023),
(5, 'Eva', 5400, 2024);

-- LAG -> Gives the previous row's record/value
# usecase: to know the employees previous year salaries
select *,
lag(salary) over(partition by employeeid order by year) as prev_year_salary 
from EmployeeSalaries;

select *,lag(salary) over(partition by employeeid order by year) as prev_year_salary,
salary-lag(salary) over(partition by employeeid order by year) as diff_salary 
from EmployeeSalaries;


-- LEAD -> Gives the value of next row's data

CREATE TABLE SalesData (
    SaleID INT,
    EmployeeName VARCHAR(100),
    SaleAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO SalesData (SaleID, EmployeeName, SaleAmount, SaleDate) VALUES
(1, 'Alice', 5000, '2025-01-01'),
(2, 'Bob', 3000, '2025-01-02'),
(3, 'Charlie', 4000, '2025-01-03'),
(4, 'David', 4500, '2025-01-04'),
(5, 'Eva', 5500, '2025-01-05');

select *,
lead(saleamount) over(order by saledate) next_sales,
lead(saleamount) over(order by saledate)-saleamount as diff_amount
from SalesData;


-- first_value & last_value:

-- FIRST_VALUE -> gives the first value of each row based on patition
-- LAST_VALUE -> gives the last value of each row based on patition

drop table if exists EmployeeSalaries;
CREATE TABLE EmployeeSalaries (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    Salary DECIMAL(10, 2),
    Year INT
);

INSERT INTO EmployeeSalaries (EmployeeID, EmployeeName, Salary, Year) VALUES
(1, 'Alice', 5000, 2021),
(1, 'Alice', 5500, 2022),
(1, 'Alice', 6000, 2023),
(1, 'Alice', 6500, 2024),
(1, 'Alice', 7000, 2025),
(2, 'Bob', 4500, 2023),
(2, 'Bob', 4800, 2024),
(3, 'Charlie', 4000, 2023),
(3, 'Charlie', 4200, 2024),
(4, 'David', 4600, 2023),
(4, 'David', 4700, 2024),
(5, 'Eva', 5200, 2023),
(5, 'Eva', 5400, 2024);

-- first_value
select *,
first_value(salary) over (partition by employeeid order by year) as First_salary
from EmployeeSalaries;

-- last_value
-- ['ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING'] (copy & paste for last value, to display the values for current windows))

-- Explanation: 'ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING'
-- 	CURRENT ROW = Start the window at the current row
-- 	UNBOUNDED FOLLOWING = End the window at the last row of the partition
-- 	So it ensures you're truly looking at the last value in the ordered window

select *,
last_value(salary) over (partition by employeeid order by year ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as Last_salary
from EmployeeSalaries;

-- last_value - current value
select *,
last_value(salary) over (partition by employeeid order by year ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as last_salary,
last_value(salary) over (partition by employeeid order by year ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) - salary as Sal_diff
from EmployeeSalaries;


-- Nth_value -> gives the nth(1,2,3...) largest values
-- 'ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING' (copy & paste for Nth value, to display the values for current windows)
select *,
nth_value(salary,2) over (partition by employeeid order by year desc ROWS BETWEEN UNBOUNDED preceding AND UNBOUNDED FOLLOWING ) as second_highest_salary
from EmployeeSalaries;