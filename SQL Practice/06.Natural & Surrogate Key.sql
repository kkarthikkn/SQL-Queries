# Theory Concepts

1. Natural Key
A natural key is a real-world, meaningful piece of data (or combination of columns) that already uniquely identifies a record.

Examples:

A Social Security Number (SSN) in the U.S. (if each person has a unique SSN).
An email address if each user must have a unique email.
A product serial number that is truly unique for each product.

-- ===============================================

2. Surrogate Key
A surrogate key is a synthetic or artificial key added to a table just to uniquely identify each row. It typically has no meaning in the real world; it’s there only for the database’s sake.

Examples:

An auto-increment integer column like id.
A UUID (a universally unique identifier) column.
Any system-generated unique value.

-- ===============================================

Summary 
Natural Key: Real data with business meaning, used as an identifier.
Surrogate Key: Artificial (often numeric) identifier, stable and system-generated.

Example 

CREATE TABLE dim_customer (
    customer_key INT AUTO_INCREMENT ,         -- Surrogate Key (unique for each version of the customer record)
    aadhar_number INT NOT NULL PRIMARY KEY,   -- Natural Key (unique identifier for the customer)
    customer_name VARCHAR(100),
    city VARCHAR(100),
    effective_date DATE,              -- Date this record version became active
    end_date DATE,                    -- Date this record version ended
    is_current BOOLEAN                -- Flag to indicate the current active record
);
