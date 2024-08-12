-- Concatenation using + or CONCAT function
SELECT
    customer_id,
    first_name,
    middle_name,
    last_name,
    first_name + ISNULL(' ' + middle_name '') + ' ' + last_name AS full_name
FROM customers;

SELECT
    customer_id,
    first_name,
    middle_name,
    last_name,
    CONCAT(first_name, ' ' + middle_name, ' ', last_name) AS full_name
FROM customers;

-- String manipulation functions
-- LEN will ignore padded spaces at end of string
SELECT
    customer_id,
    customer_name,
    LEFT(customer_name, CHARINDEX(' ', customer_name) - 1) AS first_name
FROM customers;

SELECT
    customer_id,
    customer_name,
    SUBSTRING(customer_name, CHARINDEX(' ', customer_name) + 1, LEN(customer_name)) AS last_name
FROM customers;

-- CASE expression has functionality of if-then-else statements
SELECT
    customer_id,
    first_name,
    countrym
    club_member,
    CASE 
        WHEN country = 'USA' AND club_member = 'Yes' 
            THEN 'Domestic member'
        WHEN country = 'USA' AND club_member = 'No' 
            THEN 'Domestic non-member'
        WHEN country <> 'USA' AND club_member = 'Yes' 
            THEN 'Foreign member'
        WHEN country <> 'USA' AND club_member = 'No' 
            THEN 'Foreign non-member'
        ELSE 'unknown'
    END AS customer_status
FROM customers;

SELECT
    customer_id,
    first_name,
    country,
    club_member
    CASE country
        WHEN 'USA' THEN 'Domestic'
        ELSE 'Foreign'
    END AS customer_category
FROM customers;