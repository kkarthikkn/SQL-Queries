# Sub Queries

drop table if exists customer;
create table customer(
	cust_id int primary key,
     cust_name varchar(20),
     city varchar(20)
);

insert into customer values
(1,'Ravi', 'Chennai'),
(2,'Priya', 'Banglore'),
(3,'Arjun', 'Hyderbad'),
(4,'Meena', 'Mumbai'),
(5,'Raj', 'Chennai');

-- =======================
drop table if exists orders;
create table orders(
	order_id int primary key,
     cust_id int,
     order_amount decimal(10,2),
     order_date Date, 
     foreign key (cust_id) REFERENCES customer(cust_id)
);

insert into orders values
(101,1,5000,'2025-01-01'),  # date format: 'YYYY-MM-DD'
(102,2,10000,'2025-01-02'),
(103,3,3000,'2025-01-03'),
(104,4,1500,'2025-01-04'),
(105,1,7000,'2025-01-05'),
(106,5,8000,'2025-01-06');
     

select * from customer;
select * from ORDERS;


#1.
select cust_name,
(select max(order_amount) from orders) as amount
from customer;

#2. Subquery in 'Where' clause
select cust_name
from customer
where cust_id in
( select distinct cust_id 
  from orders
  where order_amount>=5000);


#3. Exists: returns TRUE if a subquery returns at least one row — otherwise, it returns FALSE.
select cust_name, city
from customer
where exists(
	select * from orders where order_id=102
);  -- returns whole table, bcz of TRUE

select cust_name, city
from customer
where exists(
	select * from orders where order_id=109
);  -- no records will be returned, bcz of FALSE

#4. instead of joins
select cust_name, city,
(select sum(order_amount)
 from orders o
 where o.cust_id=c.cust_id) as Total_orders
 from customer c;
 
-- using actual joins (similar to 4th section)
select c.cust_name,c.city,sum(order_amount) as total
from customer c
join orders o
on c.cust_id=o.cust_id
group by c.cust_id;  # groupping by cust_id, bcz it uniquely identifies each customer
 
#4.  Subquery in the FROM Clause

# Exp: The subquery (inside the parentheses) acts like a temporary table or derived table.
#	  The outer query is selecting from this temporary result set.

select length,lower from(
	select
	length(customer_name) as Length,
	lower(address) as lower,
	upper(email) as upper,
	trim(customer_name) as trimmed, 
	ltrim(customer_name) as l_trimmed,  
	rtrim(customer_name) as r_trimmed,  
	substr(customer_name,1,5) as sub_str, 
	substring_index(email, '@', -1) AS str_index, 
	concat(customer_name,' - ', address,' - IND') as concat,
	concat(substr(customer_name,1,5),' - ', address,' - IND') as concat2,  # added subsrt()
	lpad(customer_name,15,'*') as lpadded, 
	rpad(customer_name,15,'*') as rpadded,  
	replace(customer_name,' ','_') as replaced,  
	left(address,3) as left_char,   
	right(address,5) as reft_char,  
	instr(customer_name,'a') as instr_pos,  
	#reverse
	reverse(address) as reversed,
	format(987654321,3) as formatted
	from custdata2
) as subquery;

#5. Subquery in case statements

select cust_name,
case
	when (select sum(order_amount)from orders where orders.cust_id=customer.cust_id ) > (select avg(order_amount) from orders) then 'Above Average'
	else 'Below Average'
end as order_category
from customer;
