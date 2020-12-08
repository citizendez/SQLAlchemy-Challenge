/*FOREIGN KEYS
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
		
