# Grant & Revoke
-- Purpose: Control access to data & database objects

-- GRANT: to give user access privileges
-- REVOKE: to take away the privileges

-- =====================================================================

# NOTE: The entire GRANT & REVOKE are performed in 'CMD' (Command Prompt)

mysql> CREATE USER 'jane'@'localhost' IDENTIFIED BY 'Strong';  -- 'Strong' is the Password

mysql> Grant select, insert on de_projects.* to 'jane'@'localhost'; -- Granting the privieges like select & insert on 'de_projects' schema to the user

mysql> flush privileges; -- gives the access to the privileges

mysql> select user, host from mysql.user;

mysql> use de_projects;

mysql> show tables;

mysql> DROP USER 'jane_doe'@'host';  -- can able drop the user

# Open new CMD tab

-- move to the sql directory
PS C:\program files\mysql\mysql server 8.0\bin> .\mysql.exe -u root -p  -- -u: User [Give the user-name] , -p: Password
Enter password: *****  -- give the root password not the user('Strong' password)

mysql> exit  -- exists from root

-- *****************************************

# 'Jane' is the user now
PS C:\program files\mysql\mysql server 8.0\bin> .\mysql.exe -u jane -p
Enter password: ******	-- give the user password('Strong' password)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| de_projects        |
| information_schema |
| performance_schema |
+--------------------+

mysql> use performance_schema;  -- only gave access for 'de_projects' schema
ERROR 1044 (42000): Access denied for user 'jane'@'localhost' to database 'performance_schema'

mysql> use de_projects;
Database changed

mysql> show tables;
+-----------------------+
| Tables_in_de_projects |
+-----------------------+
| accounts              |
| cust_transactions     |
| custdata              |
| custdata2             |
| customer              |
| customerdata          |
| customers             |
| demo_data             |
| drivers               |
| emp                   |
| emp1                  |
| emp2                  |
| employees             |
| employeesalaries      |
| employeesales         |
| high_earners          |
| high_paid_emp         |
| manager               |
| order_detail          |
| order_index           |
| order_rest            |
| orders                |
| orders2               |
| performance           |
| productsales          |
| regex_test            |
| rest_aurant           |
| restaurant_loc        |
| restaurants           |
| ride                  |
| ride_details          |
| rides                 |
| sales                 |
| salesdata             |
| sensor_data           |
| students              |
| sub_order             |
| test                  |
| test_time             |
| top_perform           |
| users                 |
+-----------------------+

mysql> select * from emp order by emp_id;
+--------+------------+-----------+-------------+
| emp_id | first_name | last_name | department  |
+--------+------------+-----------+-------------+
|      1 | Alice      | Smith     | Sales       |
|      2 | Bob        | Johnson   | HR          |
|      3 | Charlie    | Lee       | Engineering |
|      4 | Diana      | Lopez     | DevOps      |
|      5 | Eve        | Turner    | Marketing   |
+--------+------------+-----------+-------------+

mysql> update emp set first_name='Leo' where emp_id=1;  -- only granted the privileges for select & insert
ERROR 1142 (42000): UPDATE command denied to user 'jane'@'localhost' for table 'emp'

mysql> exit  -- exit from user 'jane'

-- *****************************************

# entered in root user
PS C:\program files\mysql\mysql server 8.0\bin> .\mysql.exe -u root -p
Enter password: *****

-- revoking the privileges
mysql> revoke select, insert on de_projects.* from 'jane'@'localhost';
Query OK, 0 rows affected (0.01 sec)

mysql> flush privileges;
Query OK, 0 rows affected (0.01 sec)

mysql> exit  -- exit from user 'root'

-- *****************************************

# Enter into user 'jane'
PS C:\program files\mysql\mysql server 8.0\bin> .\mysql.exe -u jane -p
Enter password: ******
Welcome to the MySQL monitor. 

mysql> use de_projects;  -- revoked all the privileges on this schema
ERROR 1044 (42000): Access denied for user 'jane'@'localhost' to database 'de_projects'


-- *****************************************