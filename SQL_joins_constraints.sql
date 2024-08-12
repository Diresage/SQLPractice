-- INNER JOIN 
SELECT *
FROM departments INNER JOIN employees
ON departments.dept_id = employees.dept_id;

SELECT d.dept_id, d.dept_name, e.emp_id, e.first_name
FROM departments d INNER JOIN employees e
ON d.dept_id = e.dept_id;

SELECT d.dept_id, d.dept_name, e.emp_id, e.first_name
FROM departments d  JOIN employees e
ON d.dept_id = e.dept_id;

-- OUTER JOIN
SELECT d.dept_id, d.dept_name, e.emp_id, e.first_name
FROM departments d LEFT OUTER JOIN employees e
ON d.dept_id = e.dept_id;

SELECT d.dept_id, d.dept_name, e.emp_id, e.first_name
FROM departments d 
LEFT JOIN employees e
ON d.dept_id = e.dept_id;

SELECT d.dept_id, d.dept_name, e.emp_id, e.first_name
FROM employees e
RIGHT JOIN departments d 
ON d.dept_id = e.dept_id;

-- FULL OUTER JOIN
SELECT d.dept_id, d.dept_name, e.emp_id, e.first_name
FROM departments d FULL OUTER JOIN employees e
ON d.dept_id = e.dept_id;

SELECT d.dept_id, d.dept_name, e.emp_id, e.first_name
FROM departments d 
FULL JOIN employees e
ON d.dept_id = e.dept_id;

-- Data integrity
PRIMARY KEY
FOREIGN KEY
NOT NULL
UNIQUE
CHECK

-- Primary Key must have unique and non-null values
-- Foreign Key ensures that the value inserted also exists and relates in primary key to related table

-- In Many-to-Many relationships it is customary to create compsoite associative tables with a composite primary key
-- Two or more foreign keys together can create unique composite primary keys

-- Composite Joins use more than one column to join tables
SELECT
    c.population,
    c.city,
    c.country,
    s.country AS store_country,
    s.store_id,
    s.area_sqm
FROM cities c INNER JOIN stores s
ON c.city = s.city
    AND c.country = s.country;

-- Multi-join queries
SELECT
    d.doc_id,
    d.doc_last_name,
    p.patient_id,
    p.last_name
FROM
    doctors d
INNER JOIN
    doctor_patients dp
ON
    d.doc_id = dp.doc_id
INNER JOIN 
    patients p
ON 
    dp.patient_id = p.patient_id;

-- Predicate conditions
SELECT s.supplier_name, s.country, s.supplier_id, p.product_id, p.prod_name
FROM suppliers s INNER JOIN products p
ON s.supplier_id = p.supplier_id
WHERE s.country = 'India';

--Self referencing join is when a table can reference a key within itself
SELECT
    e.employee_id,
    e.first_name,
    e.job_title,
    e2.first_name AS manager_name,
    e2.job_title AS manager_title
FROM
    employees e INNER JOIN employees e2
ON 
    e.manager_id = e2.employee_id;

--Cross joins is used when two tables do not have a common key and will create combinations of each row
SELECT
    s.store_id,
    s.store_location,
    p.product_id,
    p.product_name
FROM stores s CROSS JOIN products p;

SELECT
    s.store_id,
    s.store_location,
    p.product_id,
    p.product_name
FROM stores s, products p;