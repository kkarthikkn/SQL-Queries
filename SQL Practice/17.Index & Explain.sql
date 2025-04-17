# Indexing: It's a data structure that improves the speed of data retrieval from a table at the cost of slightly slower writes (INSERT/UPDATE/DELETE) and some extra storage.

drop table if exists customers;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    email       VARCHAR(100) NOT NULL,
    city        VARCHAR(100) NOT NULL
);

-- create index before inserting values
-- have knowledge on which column index should perform(unique values i.e id,email...)
-- create index based on the column_name which are repeatedly used in queries

create index idnx_email on customers(email);

INSERT INTO customers (first_name, last_name, email, city)
VALUES
('John', 'Doe', 'john@example.com', 'New York'),
('Jane', 'Smith', 'jane.smith@example.com', 'Los Angeles'),
('Michael', 'Brown', 'michael.brown@example.com', 'Chicago'),
('Emily', 'Johnson', 'emily.johnson@example.com', 'Houston'),
('Robert', 'Green', 'robert.green@example.com', 'Phoenix');

select * from customers where email='emily.johnson@example.com';


-- ================================================================


-- Explain -> gives the explaination for index creation
explain select * from customers where email='emily.johnson@example.com';

-- Explain Analyze -> gives the details regarding the time for execution
explain analyze select * from customers where email='emily.johnson@example.com';

explain format='json' select * from customers where email='emily.johnson@example.com';
