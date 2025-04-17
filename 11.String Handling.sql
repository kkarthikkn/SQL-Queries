# String Handling

drop table if exists custdata2;
CREATE TABLE CustData2 (
    id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(200),
    amount DECIMAL(10, 2)
);

INSERT INTO CustData2 VALUES
(1, 'Ravi Kumar', 'ravi@example.com', '98765', 'Chennai', 5000.00),
(2, 'Priya Shree', 'priya@gmail.com', '98765', 'Bangalore', 450.00),
(3, 'Arjun Singh', 'arjun@example.com', '123456', 'Hyderabad', 1500.00),
(4, 'Meena ', 'meena@gmail.com', '789436', 'Mumbai', 2500.00),
(5, 'Arun Raj', 'arun@example.com', '98765', 'Banglore', 3000.00);


select
length(customer_name) as Length,
lower(address) as lower,
upper(email) as upper,

# trims blank spaces
trim(customer_name) as trimmed, 
  
# trims left & right blank spaces
ltrim(customer_name) as l_trimmed,  
rtrim(customer_name) as r_trimmed,  

# for slicing up strings
substr(customer_name,1,5) as sub_str, 

 # It splits a string based on a delimiter( @, -, ., etc.), and returns part of it. syntax: SUBSTRING_INDEX(string, delimiter, count) 
substring_index(email, '@', -1) AS str_index, 

#concat
concat(customer_name,' - ', address,' - IND') as concat,
concat(substr(customer_name,1,5),' - ', address,' - IND') as concat2,  # added subsrt()

# pads a str on the left/right with a certain character until it reaches a specified length
lpad(customer_name,15,'*') as lpadded, 
rpad(customer_name,15,'*') as rpadded,  

# replaces the character with new given characters
replace(customer_name,' ','_') as replaced,  

# returns the no. of characters from the left/right side of the value
left(address,3) as left_char,   
right(address,5) as reft_char,  

# returns the position of given character
instr(customer_name,'a') as instr_pos,  

#reverse
reverse(address) as reversed,

 # formats the numeric value with the no. of decimal values eith commas
format(987654321,3) as formatted
 
from custdata2;
