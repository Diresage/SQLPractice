 -- Main classes of data types

-- Char
VARCHAR(n)
CHAR(n)
NVARCHAR(n)
NCHAR(n)

-- Numeric
INT (see Integer Signed)
DECIMAL(PRECISION,SCALE) --Precision is total number of digits on both sides of decimal scale is number of digits to the right of decimal
FLOAT(n) --n is number of bits that are used to store float. Default is 53

-- DateTime
TIME (100 ns)
DATE (1 day)
SMALLDATETIME (1 minute)
DATETIME (0.00333 seconds)
DATETIME2 (100 ns)
DATETIMEOFFSET (100 ns)

-- Bit
BIT

-- Integer Signed
TINYINT (8-BIT) --not signed
SMALLINT (16-BIT)
INT (32-BIT)
BIGINT (64-BIT)

-- UID/GUID
UNIQUEIDENTIFIER(16-BIT)
NEWID()
NEWSEQUENTIALID()

-- Create Table Statement
CREATE TABLE table_name
(
    Column1 datatype [NOT NULL],
    Column2 datatype,
    CONSTRAINT constraint_name constraint_type (Column1)
);

CREATE TABLE departments
(
    department_id INT IDENTITY(1,1),
    department_name VARCHAR(50) NOT NULL,
    CONTRAINT PK_department_id PRIMARY KEY (department_id)
);

CREATE TABLE employees
(
    employee_id INT,
    first_name  NVARCHAR(100),
    last_name   NVARCHAR(100),
    salaray     DECIMAL(12,2),
    hire_date   DATE
);

CREATE TABLE parks1
(
    park_id INT,
    park_name VARCHAR(50),
    entry_fee DECIMAL(6,2)
);

CREATE TABLE dbo.parks_visits
(
    visit_id INT IDENTITY,
    park_id INT NOT NULL,
    visit_date DATE NOT NULL,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_park_visits_visit_id PRIMARY KEY (visit_id),
    CONSTRAINT FK_park_visits_park_id FOREIGN KEY (park_id) REFERENCES parks2 (park_id)
);

CREATE TABLE
(
    subject_id INT IDENTITY,
    subject_name VARCHAR(20),
    global_id UNIQUEIDENTIFIER DEFAULT NEWID(),
    CONTRAINT PK_subjects_subject_id PRIMARY KEY (subject_id)
);

-- Insert Statements
INSERT INTO table_name (column1, column2, ...)
    VALUES (col1_value, col2_value, ...);

INSERT INTO table_name (column1, column2, ...)
    VALUES  (col1_value, col2_value, ...),
            (col1_value, col2_value, ...),
            (col1_value, col2_value, ...);

INSERT INTO table_name (column1, column2)
SELECT column1, column2
FROM table2_name;

INSERT INTO dbo.parks1 (park_id, park_name, entry_fee)
    VALUES (1, 'Bellmont Park', 5);

INSERT INTO dbo.parks1 (park_id, park_name, entry_fee)
    VALUES (2, 'Redmond Park', 10);

INSERT INTO dbo.parks1 (park_id, park_name, entry_fee)
    VALUES (3, 'Highland Mountains', 6.74);

-- UPDATE Statements
UPDATE table_name
SET column1 = value1/expression,
    column2 = value2/expression,
    ...
[WHERE conditions];

UPDATE products
SET price = price * 1,1,
    category_name = 'Clothing'
WHERE product_name = 'Sports hat';

-- DELETE Statements deletes specified rows from a table (or all rows from a table if not specified, all rows deleted are logged) DOES NOT reset IDENTITY property
-- Can be used if referenced by a foreign key in another table if no related rows are used.
DELETE FROM table_name
[WHERE conditions];

DELETE FROM dbo.products
WHERE product_name = 'Sports hat';

-- TRUNCATE TABLE Statement deletes all rows from a table, uses an optimized logging method that will not log each row deleted. Will reset IDENTITY property back to seed
-- Can not be used if referenced by a foreign key in another table
TRUNCATE TABLE table_name;

-- DROP TABLE used to remove the table from the database
-- Can not be used if referenced by a foreign key in another table
DROP TABLE [IF EXISTS mssql 2016+] <database_name>.<schema_name>.<table_name>;

--Transactions
--Default for SQL Server is to auto-commit statements that do not encounter an error
Atomic      -- All or Nothing
Consistent  -- A committed state should not create instability in the current state
Isolated    -- A transaction should not be impacted by any other transactions without interference 
Durability  -- Changes should persist even in the event of an outage

--Begin a new transaction
BEGIN TRANSACTION

--Declare a new variable called @new_product_id that will hold the new product_id value
DECLARE @new_product_id INT;

-- Insert the new product
INSERT INTO oes.products (product_name, category_id, list_price, discontinued)
    VALUES ('PBX Printer', 7, 45.99, 0);

-- The SCOPE_IDENTITY() function returns the last value inserted into the IDENITY column
SET @new_product_id = SCOPE_IDENTITY();

-- Insert the inventory information for the new product
INSERT INTO oes.inventories (product_id, warehouse_id, quantity_on_hand)
    VALUES  (@new_product_id, 1, 100),
            (@new_product_id, 4, 35);

-- Store Procedures SQL code that is saved and executed from database
CREATE PROCEDURE proc_name
(@parameter1 data_type, @parameter2 data_type)
AS
BEGIN [TRANSACTION;]
sql_statements
[COMMIT TRANSACTION;]
END;

CREATE PROCEDURE proc_name
(
    @parameter1 data_type = default_value,
    @parameter2 data_type = default_value
)
AS
BEGIN [TRANSACTION;]
sql_statements
[COMMIT TRANSACTION;]
END;

CREATE PROCEDURE proc_name
(
    @in_parameter data_type = default_value,
    @out_parameter data_type OUT
)
AS
BEGIN [TRANSACTION;]
sql_statements
[COMMIT TRANSACTION;]
END;

EXECUTE proc_name
    @param1 = param1_value,
    @param2 = param2_value;

EXECUTE proc_name
    @param1 = param1_value,
    @param2 = @param2_reciever OUT

ALTER PROCEDURE proc_name
(@parameter1 data_type, @parameter2 data_type)
AS
BEGIN [TRANSACTION;]
sql_statements
[COMMIT TRANSACTION;]
END;

-- ALTER Statements
ALTER TABLE table_name
ADD column_name1 column1_data_type
    column_name2 column2_data_type;

ALTER TABLE table_name
ALTER COLUMN column_name new_data_type [NOT NULL];

ALTER TABLE table_name
DROP COLUMN column_name;

sp_rename 'schema_name.table_name.old_column_name', 'new_column_name', 'COLUMN';

-- UNIQUE constraint
-- NULL is acceptable
CONSTRAINT constraint_name UNIQUE (column_name);

-- CHECK constraint
-- Checks that all values in a column meets a certain condition
ADD CONSTRAINT constraint_name CHECK (column_name condition)

-- INDEX is a data structure that speeds up search features
-- Heap is a table that does have a cluster index on it
-- Table Scan is where SQL engine reads all the rows and columns
-- Index Scan reads all rows and columns in the index
-- Index Seek pinpoints only the rows that are needed to make the query work
-- Cardinality referes to the number of unique calues in a column
-- Selectivity is a measure of how much an index can help to narrow the search for specific values in a table
    -- Average Selectivity is the cardinality divided by the total number of rows in a table
    -- Selectivity of a specific value is the number of rows for a specified value divided by the total number of rows in a table
-- When average Selectivity is low, it is often best not to index that column

-- Non-clustered index b+ tree index
-- Contains pointers to the location of data
CREATE NONCLUSTERED INDEX index_name
    ON table_name (column1_name, column2_name, ...);

--Clustered Indexes physically sorts the table data according to the index column(s)
CREATE CLUSTERED INDEX index_name
    ON table_name (column1_name, column2_name, ...);

-- Unique Index ensures that a column can only contain unique values
CREATE UNIQUE INDEX index_name
    ON table_name (column1_name, column2_name, ...);

-- Filtered indexes only a portion of rows are indexed which can save space and improve performance
CREATE FILTERED INDEX index_name
    ON table_name (column1_name, column2_name, ...)
    WHERE condition;

-- Indexing guidelines
-- Avoid over-indexing heavily updated tables
-- Keep indexes narrow
-- Indexing on small tables are likely not necessary
-- Consider indexing foreign key columns
-- Consider filtered index to help optimize queries that return a well-defined subset of rows from a large table

-- Clustered indexes are best to put on every table
-- Ideally should be put on columns with unique, non-null and narrow in size that are typically accessed sequentially

-- Composite Index is where multiple columns are specified for the index key
CREATE INDEX index_name
    ON table_name (column1_name, column2_name)
    INCLUDE (city);

-- INCLUDE allows us to include non-key columns in non-clustered index

-- Sargable queries are queries that fully utilize the functions of the index.
-- Applying a function or manipulation will remove this advantage.

-- Views are a virtual table whose data is defined by a query
CREATE VIEW name_of_view AS
SELECT col1, col2, ...
FROM table_name;

-- ORDER BY can not be used in a view unless TOP is specified