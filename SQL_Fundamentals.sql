USE SAMPLEDB
GO

-- SELECT
SELECT
    FIRST_NAME,
    LAST_NAME
FROM
    HCM.EMPLOYEES;

SELECT
    LAST_NAME AS CUSTOMER_LAST_NAME,
    CITY
FROM
    OES.CUSTOMERS;

SELECT
    *
FROM
    OES.ORDER_ITEMS;

-- SELECT DISTINCT
SELECT
    DISTINCT LOCALITY
FROM
    BIRD.ANTARCTIC_POPULATIONS;

SELECT
    DISTINCT LOCALITY,
    SPECIES_ID
FROM
    BIRD.ANTARCTIC_POPULATIONS;

-- SELECT TOP
SELECT
    TOP (2)    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME
FROM
    HCM.EMPLOYEES;

SELECT
    TOP (2)    EMPLOYEE_ID,
    FIRST_NAME,
    HIRE_DATE
FROM
    HCM.EMPLOYEES
ORDER BY
    HIRE_DATE DESC;

-- SELECT TOP WITH TIES
SELECT
    TOP (2) WITH TIES EMPLOYEE_ID, FIRST_NAME,
    HIRE_DATE
FROM
    HCM.EMPLOYEES
ORDER BY
    HIRE_DATE DESC;

-- TOP with deterministic properties
SELECT
    TOP (2)    EMPLOYEE_ID,
    FIRST_NAME,
    HIRE_DATE
FROM
    HCM.EMPLOYEES
ORDER BY
    HIRE_DATE DESC,
    EMPLOYEE_ID DESC;

-- ORDER BY
SELECT
    EMPLOYEE_ID,
    FIRST_NAME
FROM
    HCM.EMPLOYEES
ORDER BY
    FIRST_NAME;

-- ORDER BY DESC
SELECT
    EMPLOYEE_ID,
    FIRST_NAME
FROM
    HCM.EMPLOYEES
ORDER BY
    FIRST_NAME DESC;

-- ORDER BY column number (ASC is default)
SELECT
    EMPLOYEE_ID,
    FIRST_NAME
FROM
    HCM.EMPLOYEES
ORDER BY
    2;

-- ORDER BY DATA (Later are greater)
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    HIRE_DATE
FROM
    HCM.EMPLOYEES
ORDER BY
    HIRE_DATE;

-- ORDER BY THEN BY
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    HIRE_DATE
FROM
    HCM.EMPLOYEES
ORDER BY
    HIRE_DATE,
    FIRST_NAME;

-- ORDER BY Hybrid
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    HIRE_DATE
FROM
    HCM.EMPLOYEES
ORDER BY
    HIRE_DATE DESC,
    EMPLOYEE_ID ASC;

-- WHERE
SELECT
    *
FROM
    HCM.LOCATIONS
WHERE
    CITY = 'Toronto';

SELECT
    *
FROM
    HCM.LOCATIONS
WHERE
    CITY <> 'Toronto'
    OR STATE_PROVINCE IS NULL;

-- ISNULL function
-- only allows 1 expression or column
-- return value matches first expression (ex: varchar(3) expression and alternative varchar(30) will take varchar(3))
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    5000 AS BONUS,
    SALARY + ISNULL(5000, 0) AS TOTAL_AMMOUNT
FROM
    HCM.EMPLOYEES;

-- COALESCE function
-- WILL continuously run through columns to find a non-null value or use the alternative
-- return value matches largest expression (ex: varchar(3) expression and alternative varchar(30) will take varchar(30))
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    5000 AS BONUS,
    SALARY + COALESCE(5000, 0) AS TOTAL_AMMOUNT
FROM
    HCM.EMPLOYEES;

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
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    COLLATION_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
 -- pattern recognition
 --CS case sensitive
 --CI case insensitive
 --AS accent sensitive
 --AI accent insensitive
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME
    FROM
        PRODUCTS
    WHERE
        PRODUCT_NAME = 'USB hub' COLLATE LATIN1_GENERAL_CS_AS;

-- LIKE wildcard
SELECT
    PRODUCT_ID,
    PRODUCT_NAME
FROM
    PRODUCTS
WHERE
    PRODUCT_NAME LIKE '%tablet%';

-- LIKE with single character wildcard
SELECT
    PRODUCT_ID,
    PRODUCT_NAME
FROM
    PRODUCTS
WHERE
    PRODUCT_NAME LIKE '_X%';

-- LIKE with escaped characters
SELECT
    PRODUCT_ID,
    PRODUCT_NAME
FROM
    PRODUCTS
WHERE
    PRODUCT_NAME LIKE 'usb!_tablet%' ESCAPE '!';

-- LIKE with range of digits
SELECT
    PRODUCT_ID,
    PRODUCT_NAME
FROM
    PRODUCTS
WHERE
    PRODUCT_NAME LIKE '[0-9]%';

-- LIKE with range of letters
SELECT
    PRODUCT_ID,
    PRODUCT_NAME
FROM
    PRODUCTS
WHERE
    PRODUCT_NAME LIKE '[A-Z]%';

-- Data types
-- Look at INFORMATION_SCHEMA.COLUMNS to see data types
VARCHAR(N) --variable-size string data
NVARCHAR(N) --variable-size string. Unicode
CHAR(N) --fixed-size string data
NCHAR(N) --fixed-size string data. Unicode

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH AS CHAR_MAX_LENGTH,
    CHARACTER_OCTET_LENGTH   AS CHARACTER_OCTET_LENGTH
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'hcm'
    AND TABLE_NAME = 'employees';

-- In comparisons, it's best practice to use non-conversion comparisons
SELECT
    CUSTOMER_ID,
    FIRST_NAME
FROM
    CUSTOMERS
WHERE
    FIRST_NAME = N'Joanna';

-- Aggregate Functions return a single value from an aggregate of values
SELECT
    MIN(PROP_VALUE)            AS MINIMUM_PROP_VALUE,
    SUM(PROP_VALUE)            AS TOTAL_PROP_VALUE,
    AVG(PROP_VALUE)            AS MEAN_PROP_VALUE,
    COUNT(*)                   AS TOTAL_PROPS,
    COUNT(DISTINCT STREET_NUM) AS UNIQUE_STREET_NUM_CNT
FROM
    PROPERTIES;

SELECT
    prop_zone,
    occupied
    SUM(area_sqm) AS total_area_sqm
FROM properties
GROUP BY
    prop_zone,
    occupied;

-- HAVING is used to filter groups 
-- aggregate functions are allowed in HAVING clauses
SELECT
    column1,
    AGG_FUNC(column2)
FROM table_name
[WHERE conditions]
GROUP BY column1
HAVING condition

SELECT
    property_id,
    COUNT(*) AS owner_count
FROM property_owners
GROUP BY property_id
HAVING COUNT(*) > 1;

-- Logical Query Process Order
--Keyed Order
1. SELECT
2. FROM
3. WHERE
4. GROUP BY
5. HAVING
6. ORDER BY
-- LQPO
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY

-- Operator precedence
1. ()
2. */
3. +-
4. NOT
5. AND
6. OR

-- IN Operator
SELECT *
FROM table1
WHERE column1 IN (value1, value2,...);

SELECT
    supplier_id,
    part_name,
    quantity
FROM shipments
WHERE supplier_id IN (101, 102, 104);