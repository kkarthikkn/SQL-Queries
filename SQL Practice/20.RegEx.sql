# RegEx [Regular Expression]

CREATE TABLE regex_test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(20)
);

INSERT INTO regex_test (text) VALUES
('Hello'),
('12345'),
('abc123'),
('A1B2C3'),
('email@test.com'),
('test_email'),
('UPPERCASE'),
('lowercase'),
('With Space'),
('With-Dash'),
('With_Underscore'),
('!@#$%^'),
('mixedCASE123'),
('NoNumbers'),
('42OnlyNum'),
('2025-04-14'),
('14/04/2025'),
('true'),
('false'),
('blank');

select * from regex_test;

# '^' --> Start of string anchor 
select * from regex_test
where text regexp '^a';

# '$' --> End of string anchor
select * from regex_test
where text regexp 'e$';

# it returns the records which starts with numbers
select * from regex_test
where text regexp '^[0-9]';

# it returns the records which ends with particular characters
select * from regex_test
where text regexp '.com$';

# it returns the records in which the characters are consecutively repeated like 'apple - [p] repeated consecutively'
select * from regex_test
where text regexp '(.)\\1';

# returns the records which contains only alphabets either uppercase/lowercase
select * from regex_test
where text regexp '^[A-Za-z]+$'; 	 -- add '+', otherwise it won't incremented to the next alphabet

# returns the characters with the specific length
select * from regex_test
where text regexp '^.{6}$'; 	# length of 6 characters will be returned

# returns only if the given values is present in the table 
select * from regex_test
where text regexp '^(true|false|abc123)$'; -- here, 'true & false' are the values of the table & can add as many values you want by giving |(OR operator)

# returns the value starts with number of 2 characters & continued by alphabets
select * from regex_test
where text regexp '^[0-9]{2}[A-Za-z]+$';


-- ===================================
drop table if exists demo_data;
CREATE TABLE demo_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50),
    phone VARCHAR(25),
    email VARCHAR(100),
    date_col VARCHAR(10),   -- Storing as VARCHAR for the demo
    status VARCHAR(20),
    sku VARCHAR(20),
    username VARCHAR(30),
    notes VARCHAR(100)
);


INSERT INTO demo_data (full_name, phone, email, date_col, status, sku, username, notes) VALUES
('John Smith', '123-456-7890', 'john@example.com', '2025-02-07', 'pending', 'ABCD', 'johnsmith', 'Ships to CA'),
('Alice Johnson', '(987) 654-3210', 'alice@@example.net', '2025-02-07', 'inactive', 'SKU-123', 'alice', 'NY location'),
('Bob Williams', '+1-555-123-4567', 'bob@sample.org', '20250207', 'complete', '1SKU', 'bob123', 'Shipping to CA'),
('Mary 1 White', '(123) 123-4567', 'mary123@example.com', '2025-13-31', 'PENDING', 'abc-999', 'mary_white', 'Something about CA or'),
('Mark-Spencer', '1234567890', 'mark@example.com', '2024-11-02', 'active', 'SKU-9999', 'mark', 'Random note'),
('Jane O''Connor', '987-654-3210', 'jane.o.connor@example.org', '2024-12-31', 'inactive', 'ABCDE', 'janeO', 'Contains CA or NY'),
('Invalid Mail', '000-000-0000', 'invalid@@example..com', '2023-01-15', 'inactive', 'XYZ000', 'invalid', 'Double @ and dots'),
('NoSpacesHere', '+12-345-678-9012', 'nospaces@example.co', '2025-02-07', 'pending', 'SKU999', 'NoSpaces', 'Ends with .co domain');

select * from demo_data;



# usecase-1: To check the date format like [YYYY-MM-DD]
select * from demo_data
where date_col regexp '^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]$';

	# another type
select * from demo_data
where date_col regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';  -- the numbers inside {} are the length of the character ie {4}=2024 , {2}=05, {2}=15 

# NOTE:	 use 'NOT' keyword before 'REGEXP' to get the values which do not satisfies the condition
select * from demo_data
where date_col not regexp '^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]$';


-- ==============================
# usecase-2: To check the name containing only alphabets & spaces
select * from demo_data
where full_name regexp '^[A-Za-z ]+$';  -- added space inside the brackets[ ]

select * from demo_data
where full_name regexp '^[A-Za-z''\\- ]+$';  -- checks for the alphabets, apostrophes(''), hyphens(-)

select * from demo_data
where full_name not regexp '^[A-Za-z ]+$';

-- ==============================
# usecase-3: To check the valid email
select * from demo_data
where email regexp '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$';

-- ==============================
# usecase-4:  Match rows mentioning specific keywords
SELECT * FROM demo_data
WHERE notes REGEXP '\\b(CA|NY|Shipping)\\b';

--     \\. 	 :	Escaped dot . — separates domain from extension (e.g., .com)
-- [a-zA-Z]{2,} :	Top-level domain (like com, org, net — must be 2+ letters)

-- ==============================
# usecase-5:  To find the patterns
SELECT * FROM demo_data
WHERE sku REGEXP '^SKU[-]?[0-9]+$'; -- checks for the record starts with 'SKU' string, [-]? = Optional Hyphen, [0-9]+ = digits at the end

-- ==============================
SELECT * FROM demo_data
WHERE username REGEXP '^[A-Z0-9_]+$';

