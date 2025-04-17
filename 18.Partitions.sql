-- PARTITION : Improved Query Performance, Faster Data Loading and Deletion
-- types:- 1.RANGE()  2.LIST()   3.HASH()

-- NOTE: partition col should be primary key

-- Range(): *Divides data by ranges of values
-- 		  *Good for date/time-based data

drop table if exists order_detail;

create table order_detail(
	order_id int auto_increment,
     order_date date,
     customer_name varchar(50),
     amount decimal(10,2),
     primary key(order_id,order_date)
     )
     
     partition by range(year(order_date))
     ( 	partition p_bfr_2020 values less than(2021),
		partition p_2021 values less than(2022),
          partition p_2022 values less than(2023),
          partition p_2023 values less than(2024),
          partition p_future values less than maxvalue
     );

# To add Partition
# Condition: There should be only one partition with 'maxvalue', make sure that should not be created while table creation
#		   Otherwise cannot add parition further( refer partition with index section below line.157)

alter table order_detail
add partition( partition p_2024 values less than(2025), partition p_future values less than maxvalue);
     
       
insert into order_detail(order_date,customer_name,amount) values
('2019-05-10', 'Alice', 100.00),
('2020-01-15', 'Bob', 200.50),
('2020-12-01', 'Charlie', 300.00),
('2021-07-20', 'Diana', 150.75),
('2022-03-02', 'Edward', 500.00),
('2025-06-18', 'FutureMan', 9999.99);

select * from order_detail where order_date='2020-12-01';

explain format='json' select * from order_detail where order_date='2020-12-01';


-- 👇to know how partition is done & structure/details of table
-- 1st way
show create table order_detail;

-- 2nd way
select
partition_name, 
partition_method,
partition_expression,
subpartition_method,
subpartition_expression
from information_schema.PARTITIONS
where table_schema='de_projects' and table_name='order_detail';

# Explaination
* partition_name:- name of the given partition
* partition_method:- which type of partition performed
* partition_expression:- on which column partition performed
* subpartition_method,subpartition_expression:- 	similar to the above one
* information_schema.PARTITIONS:- stores the meta-data of all the partitions in " MySQL's " table
* table_schema:- name of the database
;

-- ===========================================================
-- LIST():	* Divides data by specific values (categories)
-- 			* Good for grouping like departments, regions, etc.

drop table if exists emp;
create table emp(
   emp_id int auto_increment,
   first_name varchar(50),
   last_name varchar(50),
   department varchar(50),
   primary key(emp_id,department)
   )
   
   -- list partiton usually takes the value as INT, so we need to convert into string with keyword 'columns' after 'list'
   
   partition by list columns(department)
   (partition p_hr values in ('HR'),
    partition p_sale values in ('Sales'),
    partition p_engineering values in ('Engineering','DevOps'),
    partition p_other values in ('Finance','Marketing','Operations')
   );

INSERT INTO emp (first_name, last_name, department) VALUES
('Alice', 'Smith', 'Sales'),
('Bob', 'Johnson', 'HR'),
('Charlie', 'Lee', 'Engineering'),
('Diana', 'Lopez', 'DevOps'),
('Eve', 'Turner', 'Marketing');

select * from emp where department='Devops'; 

select * from emp where department in ('Devops','Marketing') ;

explain select * from emp where department in ('HR','Sales');


-- ===========================================================
-- HASH : to perform partition with unique col(id, ph_no, email, account_no....)
-- 		* Distributes data using a hashing algorithm
-- 		* Good for evenly spreading data when there’s no natural grouping

create table sensor_data(
	sensor_id int primary key,
     reading_time datetime,
     reading_value decimal(10,2)
    )
    
    partition by hash(sensor_id)
    partitions 2 ;  -- divides into 2(no. of partitions) partitions by performing mod(%) operation & separates into odd & even
				-- scans only 50% of the table which gives better performance, it won't scan full table

insert into sensor_data values
(101, '2025-01-01 10:00:00', 23.50),
(102, '2025-01-01 10:05:00', 24.10),
(103, '2025-01-01 10:10:00', 22.75),
(104, '2025-01-01 10:15:00', 25.00),
(105, '2025-01-01 10:20:00', 20.00),
(106, '2025-01-01 10:25:00', 21.60);

select * from sensor_data where sensor_id='104';

explain select * from sensor_data where sensor_id='101';  -- partition value = p1, bcz (101 % 2 = 1) --> odd values
explain select * from sensor_data where sensor_id='102';  -- partition value = p0, bcz (102 % 2 = 0) --> even values

-- NOTE: it scans the entire table of one partiton(p0 or p1) rather than scaning whole table


-- ===========================================================

# Partition with Index
drop table if exists order_index;
create table order_index(
	order_id int auto_increment,
     order_date date,
     cust_name varchar(50),
     amount decimal(10,2),
     primary key(order_id,order_date)
     )
     
     partition by range(year(order_date))
     ( 	partition p_bfr_2020 values less than(2021),
		partition p_2021 values less than(2022),
          partition p_2022 values less than(2023),
          partition p_2023 values less than(2024)
     );

alter table order_index
add partition(partition p_2024 values less than(2025),
			partition p_future values less than maxvalue);
    
create index index_date on order_index(order_date);

insert into order_index(order_date,cust_name,amount) values
('2019-05-10', 'Alice', 100.00),
('2020-01-15', 'Bob', 200.50),
('2020-12-01', 'Charlie', 300.00),
('2021-07-20', 'Diana', 150.75),
('2022-03-02', 'Edward', 500.00),
('2025-06-18', 'FutureMan', 9999.99),
('2020-07-20', 'Tom', 190.75),
('2026-03-02', 'Leo', 550.00),
('2027-06-18', 'Jerry', 999.00);

# time consumed without index👇
-- -> Filter: (order_index.order_date = DATE'2026-03-02')  (cost=0.55 rows=1) (actual time=0.0892..0.0969 rows=1 loops=1)
-- -> Table scan on order_index  (cost=0.55 rows=3) (actual time=0.0828..0.0919 rows=3 loops=1)
explain analyze select * from order_index
where order_date='2026-03-02';


# time consumed with index👇
-- -> Index lookup on order_index using index_date (order_date=DATE'2026-03-02')  (cost=0.35 rows=1) (actual time=0.0484..0.051 rows=1 loops=1)
explain analyze select * from order_index
where order_date='2026-03-02';


-- ===========================================================
# Sub Partition
drop table if exists sub_order;
create table sub_order(
	order_id int auto_increment,
     order_date date,
     cust_name varchar(20),
     amount decimal(10,2),
     primary key(order_id,order_date)
)
partition by range(year(order_date))
subpartition by hash(month(order_date))
(	partition p_bfr_2021 values less than(2022),
	partition p_2022 values less than(2023),
     partition p_2023 values less than(2024),
     partition p_2024 values less than(2025),
     partition p_future values less than maxvalue
);

create index ind_sub_orders on sub_order(order_date);

INSERT INTO sub_order(order_date, cust_name, amount)
VALUES
('2019-05-10', 'Alice', 100.00),
('2024-01-15', 'Bob', 200.50),
('2023-12-01', 'Charlie', 300.00),
('2021-07-20', 'Diana', 150.75),
('2022-03-02', 'Edward', 500.00),
('2025-06-18', 'FutureMan', 9999.99);


# without index👇
-- ->o/p: Filter: (sub_order.order_date > DATE'2022-03-02')  (cost=1.4 rows=1.33) (actual time=0.0535..0.067 rows=3 loops=1)
-- -> 	Table scan on sub_order  (cost=1.4 rows=4) (actual time=0.0393..0.0633 rows=4 loops=1)
explain analyze select * 
from sub_order where order_date>'2022-03-02';  


# with index👇
-- ->o/p: Index range scan on sub_order using ind_sub_orders over ('2022-03-02' < order_date), with index condition: (sub_order.order_date > DATE'2022-03-02')  (cost=1.61 rows=3) (actual time=0.037..0.0493 rows=3 loops=1)
explain analyze select * 
from sub_order where order_date>'2022-03-02';



