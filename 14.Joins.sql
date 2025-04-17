# Joins

DROP TABLE IF EXISTS Order_rest;
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT  PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

INSERT INTO Restaurants (id, name, location) VALUES
(1, 'ABC Bistro', 'New York'),
(2, 'The Foodie', 'Los Angeles'),
(3, 'Tasty Treat', 'Chicago');

CREATE TABLE Order_rest (
    order_id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO Order_rest (order_id,restaurant_id, order_date) VALUES
(1, 1, '2023-01-01'),
(2, 1, '2023-01-02'),
(3, 2, '2023-01-05'),
(4, 4, '2023-01-07');  

select * from restaurants;
select * from Order_rest;

-- inner join
select r.name,r.location,o.order_date
from restaurants r
join Order_rest o 
on r.id=o.restaurant_id;

-- left join
select r.name,r.location,o.order_date
from restaurants r
left join Order_rest o 
on r.id=o.restaurant_id;


-- right join
select r.name,r.location,o.order_date
from restaurants r
right join Order_rest o 
on r.id=o.restaurant_id;

-- join
select r.name,r.location,o.order_date
from restaurants r
join Order_rest o 
on r.id=o.restaurant_id;

-- full outer join (left join UNION right join) Mysql Does'nt support full join. 
-- So, we need to do union

select *
from restaurants r
left join Order_rest o 
on r.id=o.restaurant_id
UNION
select *
from restaurants r
right join Order_rest o 
on r.id=o.restaurant_id;


-- self join table
create table manager(
	id int,name varchar(20),manager_id int
);

insert into manager values
(1,'Alice',3),
(2,'Bob',3),
(3,'Charlie',null),
(4,'Diana',3);

select * from manager;

#
select m.name, n.name
from manager m
left join manager n 		-- left join/ join used to perform self join
on m.manager_id=n.id;

#
select m.name, n.name
from manager m
join manager n 		
on m.manager_id=n.id;


-- views
create view restaurant_loc as
select location
from restaurants;

select * from restaurant_loc;