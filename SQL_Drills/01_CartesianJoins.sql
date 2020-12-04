/*Joins Are From Descartes, Rows Are From Schemas
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