# SCD( Slowly Changing Dimension )  is a method used in databases to track and preserve historical changes in data over time.


# Why SCD?
-- Track Historical Data: We want to retain older versions of our data for accurate historical analysis and trend reporting (e.g., how many sales happened when the customer had a different address).
-- Data Accuracy: Ensures that updates to dimension data (like a last name change) won’t override previous valid data in a way that confuses analysis.
-- Simplify Reporting and Analytics: Makes it easier for analysts to query the data, knowing they can trust the historical records.

# In real life, values like customer address or job title change slowly. If you overwrite the old data, you lose history.
# SCD helps you choose how to handle those changes.


# Main Types of SCD
-- Type 1: Overwrite
-- Type 2: Keeps history by adding a new record by adding flag column (like Y/N)
-- Type 3: Keeps history by adding a new attribute(column)


-- ***************************************************

# Type 1 --> It overwrites the old record
CREATE TABLE type1 (
    product_id INT PRIMARY KEY,         
    product_title VARCHAR(255),
    category VARCHAR(100),
    brand VARCHAR(100)
);

INSERT INTO type1 (product_id, product_title, category, brand)
VALUES (101, 'Amazon Echo Dot 3rd Gen', 'Smart Speakers', 'Amazon');

select * from type1;

UPDATE type1
SET product_title = 'Amazon Echo Dot (3rd Gen)'
WHERE product_id = 101;

select * from type1;

-- ***************************************************

# Type 2 --> Adds new record & still holds the historical(old) record by updating the value in flag column
drop table if exists type2;
CREATE TABLE type2 (
    seller_key INT PRIMARY KEY,        
    seller_id INT,                     
    seller_name VARCHAR(255),
    store_location VARCHAR(255),
    effective_date DATE,               
    end_date DATE,                     
    is_current BOOLEAN                
);

# NOTE: Here 'is_current' is flag data to know the current status of seller, if the same 'seller' has different updation of values bcz, it also stores the old records

INSERT INTO type2 VALUES 
(1, 501, 'Best Sellers Inc.', 'Seattle, WA', '2022-01-01', NULL, TRUE);

select * from type2;

# Scenario: Now, the seller changed their address to other location. 
#		  Then 'end_date' & 'is_current' column need to be updated before inserting new values

UPDATE type2
SET end_date = '2023-01-15',
    is_current = FALSE
WHERE seller_id = 501 AND is_current = TRUE;

select * from type2;

-- new values ie [seller_key, location, end_date, is_current] are added for the same seller
INSERT INTO type2 VALUES 
(2, 501, 'Best Sellers Inc.', 'Los Angeles, CA', '2023-01-15', NULL, TRUE);

select * from type2 where seller_id = 501;

-- ***************************************************

# Type 3: Adding new attribute with updated values(column) with old column ie holding historical data 
CREATE TABLE type3 (
    product_id INT PRIMARY KEY,         
    product_title VARCHAR(255),
    current_category VARCHAR(100),
    previous_category VARCHAR(100)       
);

INSERT INTO type3 (product_id, product_title, current_category, previous_category)
VALUES (201, 'Amazon Fire TV Stick', 'Streaming Devices', NULL);

select * from type3;

# Scenario: The 'current_category' has changed value to new one & 'previous_category' need to be updated with old value
UPDATE type3
SET previous_category = current_category,
    current_category = 'Media Players'
WHERE product_id = 201;

select * from type3;
