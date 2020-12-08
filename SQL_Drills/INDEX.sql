/*Index
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