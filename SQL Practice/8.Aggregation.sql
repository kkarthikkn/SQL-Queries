# Aggregation

Aggregation means grouping and summarizing data — like getting totals, averages, counts, etc.
It is done using aggregate functions, often with GROUP BY.

Functions: COUNT(),SUM(),AVG(),MAX(),MIN()

# NOTE: WHERE filters before aggregation[it works on raw column, not in AGG() column]
#	   HAVING filters after aggregation[only filter on AGG() columns]
;


CREATE TABLE Cust_Transactions (
    id INT PRIMARY KEY,
    login_device VARCHAR(50),
    customer_name VARCHAR(100),
    ip_address VARCHAR(20),
    product VARCHAR(100),
    amount DECIMAL(10, 2),
    is_placed BOOLEAN,
    is_viewed BOOLEAN,
    transaction_status VARCHAR(20)
);

INSERT INTO Cust_Transactions VALUES
(1, 'Mobile', 'Ravi', '192.168.1.1', 'Laptop', 50000.00, TRUE, FALSE, 'Completed'),
(2, 'Desktop', 'Priya', '192.168.1.2', 'Smartphone', 20000.00, TRUE, TRUE, 'Completed'),
(3, 'Tablet', 'Arjun', '192.168.1.3', 'Headphones', 1500.00, FALSE, TRUE, 'Failed'),
(4, 'Mobile', 'Meena', '192.168.1.4', 'Shoes', 2500.00, TRUE, FALSE, 'Completed'),
(5, 'Desktop', 'Karthik', '192.168.1.5', 'Watch', 5000.00, TRUE, TRUE, 'Completed'),
(6, 'Mobile', 'Sowmya', '192.168.1.6', 'Tablet', 15000.00, TRUE, TRUE, 'Completed'),
(7, 'Tablet', 'Ramesh', '192.168.1.7', 'Smartphone', 25000.00, FALSE, TRUE, 'Failed'),
(8, 'Desktop', 'Divya', '192.168.1.8', 'Laptop', 60000.00, TRUE, FALSE, 'Completed'),
(9, 'Mobile', 'Arun', '192.168.1.9', 'Smartwatch', 12000.00, TRUE, TRUE, 'Completed'),
(10, 'Tablet', 'Deepa', '192.168.1.10', 'Laptop', 55000.00, FALSE, FALSE, 'Pending');


# COUNT():

-- AND
Select count(*)
from Cust_Transactions
where product='laptop' and transaction_status='pending';

-- OR
Select count(*)
from Cust_Transactions
where transaction_status='pending' or transaction_status='failed';

-- IN
Select count(*)
from Cust_Transactions
where product in ('laptop','tablet');

-- NOT IN
Select count(*) count
from Cust_Transactions
where product not in ('laptop','tablet');

# SUM()
Select sum(amount) as Total_transaction
from Cust_Transactions
where transaction_status='completed';

# MIN()
Select min(amount) as Min_transaction
from Cust_Transactions
where transaction_status='completed';

# MAX()
Select max(amount) as Max_transaction
from Cust_Transactions
where transaction_status='completed';

# AVG()
Select round(avg(amount),2) as Avg_transaction
from Cust_Transactions
where transaction_status='completed';

#
select login_device, sum(amount) as Total_amt
from  cust_transactions
where transaction_status='completed'
group by login_device
order by 2 desc;
