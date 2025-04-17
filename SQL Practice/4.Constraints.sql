-- Constraints: rules you define on a table’s columns to limit 
-- 			 the type of data that can be stored

drop table if exists rides;

# Primary key constraint
CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    driver_id INT NOT NULL,
    rider_id INT NOT NULL,
    pickup_location VARCHAR(100) NOT NULL,
    dropoff_location VARCHAR(100) NOT NULL,
    ride_date DATETIME NOT NULL,
    fare DECIMAL(10, 2) NOT NULL
);

# another way for creating more than one primary key
# composite primary key is a p.key made up of two or more columns.
# the combination of primary key should be different
CREATE TABLE rides (
    ride_id INT,
    driver_id INT NOT NULL,
    rider_id INT NOT NULL,
    pickup_location VARCHAR(100) NOT NULL,
    dropoff_location VARCHAR(100) NOT NULL,
    ride_date DATETIME NOT NULL,
    fare DECIMAL(10, 2) NOT NULL,
    primary key(ride_id, driver_id)
);


INSERT INTO rides (ride_id, driver_id, rider_id, pickup_location, dropoff_location, ride_date, fare)
VALUES
(1, 101, 201, 'Chennai', 'Coimbatore', '2024-12-29 08:00:00', 500.00);

select * from rides;
-- ====================================

# Unique constraint
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);

INSERT INTO users (user_id, email)
VALUES (1, 'user1@example.com');

INSERT INTO users (user_id, email)
VALUES (2,null);

INSERT INTO users (user_id, email)
VALUES (2,'abc@gmail.com'); -- raise an error 

select * from users;

# NOTE: Both p.Key & Unique doesn't allow duplicates. The difference b/w p.key & unique is p.key doesn't allow null values, but unique key allows null values

-- ====================================

-- NOT NULL constraint
drop table if exists rides;
CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    driver_id INT NOT NULL,
    rider_id INT NOT NULL,
    pickup_location VARCHAR(100) NOT NULL,
    dropoff_location VARCHAR(100) NOT NULL,
    ride_date DATETIME NOT NULL,
    fare DECIMAL(10, 2) NOT NULL
);

INSERT INTO rides VALUES
(3, 103, 203, 'Coimbatore', 'Chennai', '2024-12-29 14:00:00', 600.00);

# returns error👇, bcz of null value in 'pickup location' column
INSERT INTO rides VALUES
(4, 104, 204, NULL, 'Chennai', '2024-12-29 16:00:00', 700.00);

-- ====================================

-- Check Constraint: it enforces a specific condition on data within a table, ensuring that only values meeting that condition can be inserted or updated, thereby maintaining data integrity and consistency
-- usecases --> columns like 'Fare_amount' must be positive no for each rides, it cannot be 0 or -ve

CREATE TABLE ride_details (
    ride_id INT PRIMARY KEY,
    driver_id INT NOT NULL,
    rider_id INT,
    pickup_location VARCHAR(100) NOT NULL,
    dropoff_location VARCHAR(100) NOT NULL,
    ride_date DATETIME NOT NULL,
    fare DECIMAL(10, 2) CHECK (fare > 0)
);

INSERT INTO ride_details VALUES
(3, 103, 203, 'Coimbatore', 'Chennai', '2024-12-29 14:00:00', -10.00);

-- ====================================

-- Foreign key: helps maintain referential integrity by ensuring that relationships between tables (like `drivers` and `rides`) are valid and consistent.

CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    driver_name VARCHAR(100),
    license_number VARCHAR(50) UNIQUE
);

drop table if exists rides;
CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    driver_id INT,
    pickup_location VARCHAR(100),
    dropoff_location VARCHAR(100),
    ride_date DATETIME,
    fare DECIMAL(10, 2),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

INSERT INTO drivers VALUES 
	(101, 'John Doe', 'XYZ12345'), 
	(102, 'Jane Smith', 'ABC67890');
     
INSERT INTO rides VALUES
(301, 101, 'Chennai', 'Coimbatore', '2024-12-01 08:00:00', 500.00),
(302, 101, 'Chennai', 'Madurai', '2024-12-01 09:30:00', 600.00),
(303, 102, 'Bangalore', 'Hyderabad', '2024-12-02 10:00:00', 700.00);

select * from drivers;
select * from rides;

# can't able to update or delete, bcz 'driver_id' from 'drivers' table is foreign key for 'rides' table, it was mapping in 'riders' table
delete from drivers where driver_id=101;
update drivers set driver_id=103 where driver_id=101;

# we can delete/update in 'rides' table which not f.key & then we can manipulate in 'drivers' table


-- 'ON DELETE CASCADE' CONDITION: it will delete the records which are associated in referenced table.
-- “If a row in the parent table is deleted, then automatically delete all related rows in the child table.” 		

CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    driver_id INT,
    pickup_location VARCHAR(100),
    dropoff_location VARCHAR(100),
    ride_date DATETIME,
    fare DECIMAL(10, 2),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id) ON DELETE CASCADE
);

-- ✅ When to Use 'on cascade'?
-- 1.When child records have no meaning without the parent 
-- 2.To prevent orphan records.
-- 3.To simplify cleanup when deleting parent data.

# Instead of Deleting record, we can perform soft-delete by creating another column(flag) & assigning with the values with boolean dtype, basically like marking it as deleted
drop table if exists ride ;
CREATE TABLE ride (
    ride_id INT PRIMARY KEY,
    driver_id INT,
    pickup_location VARCHAR(100),
    dropoff_location VARCHAR(100),
    ride_date DATETIME,
    fare DECIMAL(10, 2),
    FOREIGN KEY (driver_id) references drivers(driver_id)
);

INSERT INTO ride VALUES
(301, 101, 'Chennai', 'Coimbatore', '2024-12-01 08:00:00', 500.00),
(302, 101, 'Chennai', 'Madurai', '2024-12-01 09:30:00', 600.00),
(303, 102, 'Bangalore', 'Hyderabad', '2024-12-02 10:00:00', 700.00);

-- adding new column for soft-delete technique
Alter table ride 
add column is_delete boolean default False;

Update ride
set is_delete=True where driver_id=102;

Select * from ride;

-- ====================================

# Default Constraint: provides a default value for a column when no value is specified during an INSERT.  
-- can overwrite the default value by providing your own value during an INSERT

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    country VARCHAR(50) DEFAULT 'India'
);

INSERT INTO customers (customer_id, customer_name, country)
VALUES (1, 'John Doe', 'USA');

INSERT INTO customers (customer_id, customer_name)
VALUES (2, 'Jane Smith'),
	  (3, 'Bob');

select * from customers;

-- ====================================

# NOTE:
-- 1.Without `ON DELETE CASCADE`: If a driver is deleted, the deletion will fail if they have associated rides because of the foreign key constraint.
-- 2.With `ON DELETE CASCADE`: If a driver is deleted, all associated rides will be automatically deleted.
-- 3.Data Redundancy: Storing the `ride_id` in the `drivers` table would create data redundancy because each driver can have multiple rides. Instead, we store `driver_id` in the `rides` table to maintain a normalized structure and avoid repeating ride information in the `drivers` table.