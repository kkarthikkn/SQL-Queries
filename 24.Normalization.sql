# Normalization

# Normalization is a database design technique used to organize data efficiently. It reduces data repetition and ensures consistency.
-- Normalization in SQL is a systematic process of organizing the columns (attributes) and tables (relations) of a relational database to minimize data redundancy 
-- and improve data integrity. In simpler terms, normalization helps ensure that each piece of data is stored in the best possible place, 
-- reducing duplication and making it easier to maintain and update the database.


-- Why Normalize?
-- Reduce Data Redundancy: Storing the same data multiple times can waste space and cause inconsistencies if that data needs to change.
-- Improve Data Integrity(Accuracy): Ensures that your data follows certain rules, preventing errors.
-- Make Maintenance Easier: Updates, deletions, and insertions become simpler and more efficient when data is well-organized.

#Common Normal Forms:
-- * First Normal Form (1NF)
-- * Second Normal Form (2NF)
-- * Third Normal Form (3NF)

-- ====================================================

#1. First Normal Form (1NF): A single cell cannot hold multiple records
-- 1NF requires that every column holds only atomic (indivisible) values and that there are no repeating groups.
-- Purpose: To ensure each field contains a single piece of data.
-- ex: columns like phone_no having 2 different number in one row separated by comma(,)

# Table before performing 1NF:
-- Non-1NF Table: contains multi-valued phone_numbers in a single column

drop table if exists Non1NF;
CREATE TABLE Non1NF (
    student_id   INT,
    student_name VARCHAR(100),
    phone_numbers VARCHAR(100)  -- e.g., '123-4567,987-6543'
);

INSERT INTO Non1NF (student_id, student_name, phone_numbers)
VALUES (1, 'Alice', '123-4567,987-6543'),
       (2, 'Bob', '555-1212');

select * from Non1NF;


# Table after performing 1NF
-- To obtain 1NF, the  table need to be split

drop table if exists students;
-- 1
CREATE TABLE Students (
    student_id   INT PRIMARY KEY,
    student_name VARCHAR(100)
);

INSERT INTO Students (student_id, student_name)
VALUES (1, 'Alice'),
       (2, 'Bob');
       
       
-- 2
CREATE TABLE StudentPhones (
    student_id INT,
    phone VARCHAR(20),
    PRIMARY KEY (student_id, phone),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO StudentPhones (student_id, phone)
VALUES (1, '123-4567'),
       (1, '987-6543'),
       (2, '555-1212');
       

# the 'phone' column with 2 different numbers are separated according to the student_id
# So,it's in 1NF
select s.student_id,
	  s.student_name,
       p.phone 
from students s 
join studentphones p 
on s.student_id=p.student_id;

-- ====================================================

#2. Second Normal Form (2NF):
-- 2NF requires the table to be in 1NF and that all non-key columns(which are not primary key) are fully functionally dependent on the entire primary key.
-- Purpose: To remove partial dependencies (where a column depends on only part of a composite key).

# Before performing 2NF
-- This table is in 1NF but not in 2NF because course details depend only on course_id.
CREATE TABLE Non2NF (
    student_id  INT,
    course_id   INT,
    course_name VARCHAR(100),
    instructor  VARCHAR(100),
    PRIMARY KEY (student_id, course_id)
);


INSERT INTO Non2NF (student_id, course_id, course_name, instructor)
VALUES (1, 101, 'Intro to SQL', 'Dr. Smith'),
       (2, 101, 'Intro to SQL', 'Dr. Smith'),
       (1, 102, 'Database Design', 'Dr. Jones');

# Partial Dependency: course_name is only dependent on course_id not on student_id
select * from Non2NF;

# After splitting the table to obtain 2NF
#1
CREATE TABLE Courses (
    course_id   INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor  VARCHAR(100)
);

INSERT INTO Courses (course_id, course_name, instructor)
VALUES (101, 'Intro to SQL', 'Dr. Smith'),
       (102, 'Database Design', 'Dr. Jones');

#2
CREATE TABLE Enrollment (
    student_id INT,
    course_id  INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Enrollment (student_id, course_id)
VALUES (1, 101),
       (2, 101),
       (1, 102);

select * from courses;
select * from Enrollment;


# Now, all the non-key columns are fully dependent on primary key
select c.course_id,
	  c.course_name,
       c.instructor,
       e.student_id
from courses c
join enrollment e 
on c.course_id=e.course_id;

-- ====================================================

#3. Third Normal Form (3NF):
-- 3NF requires that the table is in 2NF and that all the columns are directly dependent on the primary key (i.e., no transitive dependencies).
-- Purpose: To remove transitive dependencies where a non-key column depends on another non-key column.


# Before 3NF

-- This table is in 2NF but has a transitive dependency:
CREATE TABLE Non3NF (
    course_id        INT PRIMARY KEY,
    course_name      VARCHAR(100),
    instructor       VARCHAR(100),
    instructor_office VARCHAR(100)
);

INSERT INTO Non3NF (course_id, course_name, instructor, instructor_office)
VALUES (101, 'Intro to SQL', 'Dr. Smith', 'Room 101'),
       (102, 'Database Design', 'Dr. Jones', 'Room 102');

select * from Non3NF;

# Here, 'instructor_office' is dependent on 'instructor' which is non-key column


# After performing 3NF
CREATE TABLE Instructors (
    instructor       VARCHAR(100) PRIMARY KEY,
    instructor_office VARCHAR(100)
);

INSERT INTO Instructors (instructor, instructor_office)
VALUES ('Dr. Smith', 'Room 101'),
       ('Dr. Jones', 'Room 102');

drop table if exists courses;
CREATE TABLE Courses1 (
    course_id   INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor  VARCHAR(100),
    FOREIGN KEY (instructor) REFERENCES Instructors(instructor)
);

INSERT INTO Courses1 (course_id, course_name, instructor)
VALUES (101, 'Intro to SQL', 'Dr. Smith'),
       (102, 'Database Design', 'Dr. Jones');

select * from courses1;
select * from instructors;


select c.course_id,
	  c.course_name,
       c.instructor,
       i.instructor_office
from courses1 c
join instructors i
on c.instructor=i.instructor;










































