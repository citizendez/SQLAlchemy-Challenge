/*CARTESIAN JOINS
Part 1
CREATE TABLE first_table(
  PK SERIAL PRIMARY KEY,
  ID INT);
	
INSERT INTO first_table (ID)
VALUES (1);

UPDATE first_table
SET id = pk;


CREATE TABLE second_table(
  PK SERIAL PRIMARY KEY,
  ID INT);
	
INSERT INTO second_table (ID)
VALUES (1);

UPDATE second_table
SET id = pk;

SELECT *
FROM second_table

Part 1


The outputs of following queries are 25 and 10, respectively.*/
SELECT COUNT(*)
FROM first_table;

SELECT COUNT(*)
FROM second_table;

--What will be the number of rows in the output of the following query? 
SELECT *
FROM first_table, second_table;

SELECT COUNT (*)
FROM first_table, second_table;
--Answer is 250

/*PART 2

CREATE TABLE table_one(
  PK SERIAL PRIMARY KEY,
  ID INT);
  
SELECT ID FROM first_table
WHERE ID < 5;

INSERT INTO table_one (ID)
SELECT ID FROM first_table
WHERE ID < 5;

SELECT * FROM table_one;

CREATE TABLE table_two(
  PK SERIAL PRIMARY KEY,
  ID INT);

INSERT INTO table_two (ID)
SELECT ID FROM first_table
WHERE ID > 9 and ID < 13;

SELECT * FROM table_two;

Part 2

The query SELECT * FROM table_one; returns the following:*/
SELECT * FROM table_one;
--And the query SELECT * FROM table_two; returns the following:
SELECT * FROM table_two;
--What will the query SELECT * FROM table_one, table_two; look like?
/*ALTER TABLE table_one 
DROP COLUMN PK;
ALTER TABLE table_two 
DROP COLUMN PK;*/

SELECT * FROM table_one, table_two;
--ANSWER: each row in one table will be joined with each row in another table 
--for every row in that second table

/*
________________________________________________________________________________
FOREIGN KEYS
Based on the above, reconstruct the table schema for employees and departments tables.
ANSWER:*/

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  id INT NOT NULL,
  dept_name VARCHAR(250) NOT NULL,
  CONSTRAINT id_pkey PRIMARY KEY (id));

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  employee_id INT NOT NULL,
  first_name VARCHAR(250) NOT NULL,
  last_name VARCHAR(250) NOT NULL,
  department_id INT NOT NULL,
  CONSTRAINT employee_id_pkey PRIMARY KEY (employee_id),
  CONSTRAINT department_id_fkey FOREIGN KEY (department_id) 
        REFERENCES departments(id));
		

------------------------------------------------------------------------
/*ACID
What are the ACID properties of SQL transactions? If possible, explain each property with an illustration of an example:

Properties of SQL Transactions have the following four standard properties, referred to by the acronym ACID.

	Atomicity − ensures that all operations within the work unit are completed successfully. Otherwise, the transaction is aborted at the point of failure and all the previous operations are rolled back to their former state.
	Consistency − ensures that the database properly changes states upon a successfully committed transaction.
	Isolation − enables transactions to operate independently of and transparent to each other.
	Durability − ensures that the result or effect of a committed transaction persists in case of a system failure.
	
Transaction Controls:
The following commands are used to control transactions.
	COMMIT − to save the changes.
	ROLLBACK − to roll back the changes.
	SAVEPOINT − creates points within the groups of transactions in which to ROLLBACK.
	SET TRANSACTION − Places a name on a transaction.
	
EXAMPLE:*/	
BEGIN; 
	INSERT INTO cats (fk_owner_id, name, breed)
	VALUES (99, 'mr.toes', 'persian');
	--COMMIT;
	ROLLBACK;

END;

SELECT * FROM cats;

/*
------------------------------------------------------------------------
THE THRILL OF THE CASE
build example table:
CREATE TABLE animal(
  ID SERIAL PRIMARY KEY,
  animal_name VARCHAR(50) NOT NULL,
  species VARCHAR(50) NOT NULL);

INSERT INTO animal (animal_name, species)
VALUES ('Mickey Mouse', 'duck'),
  ('Minnie Mouse', 'duck'),
  ('Donald Duck', 'mouse');*/
  
 SELECT *
 FROM animal;
 
SELECT *,
CASE
    WHEN species = 'duck' THEN 'mouse'
    WHEN species = 'mouse' THEN 'duck'
    ELSE species
END AS correct_species
FROM animal;

/*
------------------------------------------------------------------------
Index
Part 1
Explain an index in SQL:
An index is a lookup table associated with a table or a view. It is used by the database to inhance retrieval performance. 

Part 2
What are the different types of index? If possible, explain each type with an illustration:
There are 2 types
	1. Clustered: defines the order, therefore you can only have one per table.  The natural index would be primary key. 
SELECT name, breed
FROM cats
WHERE pk_cat = 6;

	2. Nonclustered: Doesn't sort physical data. A data structure that give instructions on how to locate data. You can have many.
CREATE INDEX myIndex ON
cats (name, breed);