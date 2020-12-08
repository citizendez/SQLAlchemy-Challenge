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