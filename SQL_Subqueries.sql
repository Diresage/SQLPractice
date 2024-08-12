-- Subqueries allow queries to be called within queries to save on process steps
SELECT
    PRODUCT_ID,
    CATEGORY,
    PRICE
FROM
    PRODUCTS
WHERE
    PRICE = (
        SELECT
            MAX(PRICE)
        FROM
            PRODUCTS
    );

SELECT
    PRODUCT_ID,
    CATEGORY,
    PRICE
FROM
    PRODUCTS
WHERE
    PRODUCT_ID IN (
        SELECT
            PRODUCT_ID
        FROM
            ORDER_DETAILS
    );

-- Correlated Subqueries is a query that references the outer called query and thus can't be run independently
SELECT
    product_id,
    category,
    price
FROM products p1
WHERE 
    price = (
        SELECT MAX(price)
        FROM products p2
        WHERE p2.category = p1.category
    );

SELECT p1.product_id, p1.category, p1.price
FROM products p1
INNER JOIN (SELECT category, MAX(price) as max_cat_price
            FROM products
            GROUP BY category) p2
ON p1.category = p2.category
AND p1.price = p2.max_cat_price;

-- EXISTS operator
SELECT p.product_id, p.category, p.price
FROM products p
WHERE EXISTS
    (
        SELECT *
        FROM order_details o
        WHERE o.product_id = p.product_id
    );

-- Window Functions operate on multiple rows at a time but returns one output per row
SELECT
    product_id,
    category,
    price,
    RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rnk
FROM products

SELECT s.*
FROM (
    SELECT
    product_id,
    category,
    price,
    RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rnk
    FROM products
    ) s
WHERE s.rnk = 1;

-- CTE Common Table Expressions simplify Subqueries into a form that performs the same tasks
WITH <CTE_Name>
AS
(
    <inner_query>
)
<outer_query>;

--Derived:
SELECT s.product_id, s.category, s.price
FROM
    (
        SELECT product_id, category, price,
        RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rnk
        FROM products
    ) s
WHERE s.rnk = 1;

--CTE:
WITH s
AS
(
    SELECT
        product_id, category, price,
        RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rnk
    FROM products
)
SELECT s.product_id, s.category, s.price
FROM s
WHERE s.rnk = 1;

--Mutliple CTE:
WITH not_recently_contacted AS
(
    SELECT
        contact_name,
        last_contacted,
        account_id
    FROM dbo.account_contacts
    WHERE last_contacted < '20200101'
),
old_orders AS
(
    SELECT
        order_id,
        account_id,
        order_date
    FROM dbo.orders
    WHERE order_date < '20200101'
)
SELECT
    nrc.contact_name,
    nrc.last_contacted,
    nrc.account_id
FROM not_recently_contacted nrc
WHERE EXISTS
    (
        SELECT *
        FROM old_orders oo
        WHERE nrc.account_id = oo.account_id
    );

-- NOT IN Trap Null results will ruin NOT IN operations
-- This will not have intended results
SELECT *
FROM departments
WHERE department_id NOT IN
    (
        SELECT department_id
        FROM employees
    );

--Instead use this
SELECT *
FROM departments
WHERE department_id NOT IN
    (
        SELECT department_id
        FROM employees
        WHERE department_id IS NOT NULL
    );

SELECT *
FROM departments d
WHERE NOT EXISTS
    (
        SELECT *
        FROM employees e
        WHERE e.department_id = d.department_id
    );

SELECT d.*
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.department_id IS NULL;

--CHALLENGES
USE SAMPLEDB
GO

SELECT product_id, product_name, list_price, category_id
FROM oes.products
WHERE list_price = (
    SELECT MIN(list_price)
    FROM oes.products
);

SELECT product_id, product_name, list_price, category_id
FROM oes.products p
WHERE list_price = (
    SELECT MIN(list_price)
    FROM oes.products p2
    WHERE p2.category_id = p.category_id
)

SELECT p1.product_id, p1.product_name, p1.list_price, p1.category_id
FROM oes.products p1
INNER JOIN (
    SELECT category_id, MIN(list_price) AS min_list_price
    FROM oes.products
    GROUP BY category_id) p2
ON p1.category_id = p2.category_id
AND p1.list_price = p2.min_list_price;

WITH min_list_price_table
AS
(
    SELECT category_id, MIN(list_price) AS min_price
    FROM oes.products
    GROUP BY category_id
)
SELECT min_list_price_table.category_id, min_list_price_table.min_price
FROM min_list_price_table;

WITH min_list_price_table AS
(
    SELECT category_id, MIN(list_price) AS min_price
    FROM oes.products
    GROUP BY category_id
)
SELECT c.category_name, min_list_price_table.category_id, min_list_price_table.min_price 
FROM min_list_price_table LEFT JOIN oes.product_categories c
ON c.category_id = min_list_price_table.category_id;

SELECT employee_id, first_name, last_name
FROM hcm.employees
WHERE employee_id NOT IN
    (
        SELECT employee_id
        FROM oes.orders
        WHERE employee_id IS NOT NULL
    );

SELECT employee_id, first_name, last_name
FROM hcm.employees e
WHERE NOT EXISTS
    (
        SELECT *
        FROM oes.orders o
        WHERE e.employee_id = o.employee_id
    );

SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM oes.customers c
WHERE customer_id IN
(
    SELECT customer_id
    FROM oes.orders o JOIN oes.order_items oi
    ON o.order_id = oi.order_id
    JOIN oes.products p
    ON oi.product_id = p.product_id
    WHERE p.product_name = 'PBX Smart Watch 4'
)