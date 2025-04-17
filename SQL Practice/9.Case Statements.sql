# CASE STATEMENTS

CREATE TABLE CustomerData (
    id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(200),
    amount DECIMAL(10, 2)
);

INSERT INTO CustomerData VALUES
(1, 'Ravi', 'ravi@example.com', '98765', 'Chennai', 5000.00),
(2, 'Priya', NULL, '98765', 'Bangalore', NULL),
(3, 'Arjun', 'arjun@example.com', NULL, 'Hyderabad', 1500.00),
(4, 'Meena', NULL, NULL, 'Mumbai', 2500.00),
(5, 'Karthik', 'karthik@example.com', '98765', NULL, 3000.00);

SELECT CUSTOMER_NAME, AMOUNT,
CASE
	WHEN AMOUNT>4000 THEN 'HIGH SPENDERS'
     WHEN AMOUNT BETWEEN 2000 AND 4000 THEN 'MEDIUM SPENDERS'
     WHEN AMOUNT<2000 THEN 'LOW SPENDERS'
     ELSE 'NO DATA'
END AS SPENDINGS
FROM CUSTOMERDATA
ORDER BY 2 DESC;

# Condition: Return CUSTOMER_NAME, CONTACT_DETAILS ie phone_no, if phone_no is null but email is present then replace it with email
# 		   else initialize phone_no with dummy-values

SELECT CUSTOMER_NAME,
CASE
	WHEN PHONE_NUMBER IS NULL AND EMAIL IS NULL THEN 12345
	WHEN PHONE_NUMBER IS NULL THEN EMAIL
     ELSE PHONE_NUMBER
END AS CONTACT
FROM CUSTOMERDATA;