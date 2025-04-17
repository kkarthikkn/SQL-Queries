#Null Handling

drop table if exists custdata;
CREATE TABLE CustData (
    id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(200),
    amount DECIMAL(10, 2)
);

INSERT INTO CustData VALUES
(1, 'Ravi', 'ravi@example.com', '98765', 'Chennai', 5000.00),
(2, 'Priya', NULL, '98765', 'Bangalore', NULL),
(3, 'Arjun', 'arjun@example.com', NULL, 'Hyderabad', 1500.00),
(4, 'Meena', NULL, NULL, 'Mumbai', 2500.00),
(5, 'Karthik', 'karthik@example.com', '98765', NULL, 3000.00);

select count(*) as null_values
from custdata
where phone_number is null;

select * from custdata
where phone_number is Null and email is null;

# if the value is 'null' in string format
INSERT INTO CustData VALUES
(6, 'Bob', 'null', '98765', 'Chennai', 5000.00);  #here 'null' is str

# update if values are in the string datatype to NULL format
update custdata
set email = null
where lower(email)='null';

# COALESCE: returns the first non-NULL value from the list of expressions.It’s a great way to handle NULLs in queries.
#           It accepts 'n' number of parameters(No Limit)

# ex: 1.COALESCE(phone_no, 'No contact') --> replace null values in phone_no column with 'no contact'
#	 2.COALESCE(phone_no, email, 'No contact', social_media,'NO ID')  -->unless 'No contact' is NULL, it won't reach further

select *, coalesce(amount,0.00) as updated_amt
from custdata;

# IFNULL: it performs similar to coalesce, but it only accepts 2 parameters
select *, ifnull(amount,0.00) as updated_amt
from custdata;

# updating null values with dummy-values
update custdata
set amount=0.00
where amount is null;

update custdata
set phone_number=159753
where phone_number is null;

update custdata
set email='abc@gmail.com'
where email is null;

select * from custdata;

