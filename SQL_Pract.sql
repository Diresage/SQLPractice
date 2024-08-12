USE SAMPLEDB
GO

-- SELECT
SELECT first_name, last_name
FROM hcm.employees;

SELECT 
    last_name AS customer_last_name,
    city
FROM oes.customers;

SELECT * FROM oes.order_items;

-- SELECT DISTINCT
SELECT
    DISTINCT locality
FROM bird.antarctic_populations

SELECT DISTINCT
    locality,
    species_id
FROM bird.antarctic_populations

-- SELECT TOP
SELECT TOP (2) employee_id, first_name, last_name
FROM hcm.employees;

SELECT TOP (2) employee_id, first_name, hire_date
FROM hcm.employees
ORDER BY hire_date DESC;

-- SELECT TOP WITH TIES
SELECT TOP (2) WITH TIES employee_id, first_name, hire_date
FROM hcm.employees
ORDER BY hire_date DESC;

-- TOP with deterministic properties
SELECT TOP (2) employee_id, first_name, hire_date
FROM hcm.employees
ORDER BY hire_date DESC, employee_id DESC;

-- ORDER BY
SELECT employee_id, first_name
FROM hcm.employees
ORDER BY first_name;

-- ORDER BY DESC
SELECT employee_id, first_name
FROM hcm.employees
ORDER BY first_name DESC;

-- ORDER BY column number (ASC is default)
SELECT employee_id, first_name
FROM hcm.employees
ORDER BY 2;

-- ORDER BY DATA (Later are greater)
SELECT employee_id, first_name, hire_date
FROM hcm.employees
ORDER BY hire_date;

-- ORDER BY THEN BY
SELECT employee_id, first_name, hire_date
FROM hcm.employees
ORDER BY hire_date, first_name;

-- ORDER BY Hybrid
SELECT employee_id, first_name, hire_date
FROM hcm.employees
ORDER BY hire_date DESC, employee_id ASC;

-- WHERE 
SELECT *
FROM hcm.locations
WHERE city = 'Toronto';

SELECT *
FROM hcm.locations
WHERE city <> 'Toronto'
OR state_province IS NULL;

-- ISNULL function
-- only allows 1 expression or column
-- return value matches first expression (ex: varchar(3) expression and alternative varchar(30) will take varchar(3))
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    5000 AS bonus,
    salary + ISNULL(5000, 0) AS total_ammount
FROM hcm.employees;

-- COALESCE function
-- WILL continuously run through columns to find a non-null value or use the alternative
-- return value matches largest expression (ex: varchar(3) expression and alternative varchar(30) will take varchar(30))
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    5000 AS bonus,
    salary + COALESCE(5000, 0) AS total_ammount
FROM hcm.employees;

-- operators
-- = equal
-- <> not equal
-- != not equal
-- < less than
-- <= lte
-- > greater than
-- >= gte
-- BETWEEN (non-including)
-- NOT BETWEEN
-- IN
-- NOT IN
-- LIKE
-- NOT LIKE
-- ALL
-- ANY
-- AND
-- OR
-- XOR
-- EXISTS
-- SOME

-- Meta data
SELECT
    table_schema,
    table_name,
    column_name,
    data_type,
    collation_name
FROM INFORMATION_SCHEMA.COLUMNS

-- pattern recognition
--CS case sensitive
--CI case insensitive
--AS accent sensitive
--AI accent insensitive
SELECT
    product_id,
    PRODUCT_NAME
FROM products
WHERE product_name = 'USB hub'
COLLATE Latin1_General_CS_AS;

-- LIKE wildcard
SELECT
    product_id,
    product_name
FROM products
WHERE product_name LIKE '%tablet%';

-- LIKE with single letter wildcard
SELECT
    product_id,
    product_name
FROM products
WHERE product_name LIKE '_X%';

-- LIKE with escape keyword
SELECT
    product_id,
    product_name
FROM products
WHERE product_name LIKE 'used!_tablet%'
ESCAPE '!';