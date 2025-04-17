-- Where Clause

CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    driver_id INT,
    rider_id INT,
    pickup_location VARCHAR(100),
    dropoff_location VARCHAR(100),
    ride_date DATETIME,
    fare DECIMAL(10, 2)
);

INSERT INTO rides (ride_id, driver_id, rider_id, pickup_location, dropoff_location, ride_date, fare) VALUES
	(1, 101, 201, 'Chennai', 'Coimbatore', '2024-12-29 08:00:00', 500.00),
	(2, 102, 202, 'Bangalore', 'Hyderabad', '2024-12-29 10:00:00', 800.00),
	(3, 103, 203, 'Chennai', 'Madurai', '2024-12-29 12:00:00', 400.00),
	(4, 104, 204, 'Coimbatore', 'Chennai', '2024-12-29 14:00:00', 600.00),
	(5, 101, 205, 'Bangalore', 'Coimbatore', '2024-12-29 16:00:00', 700.00);

desc rides;

select * from rides
where fare>400;

select * from rides
where fare>400 and dropoff_location='Coimbatore'
order by fare;