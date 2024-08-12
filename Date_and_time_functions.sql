-- Date and Time Functions
USE SAMPLEDB
GO

-- t-SQL only
SELECT GETDATE() AS get_date_value;

-- CURRENT_TIMESTAMP is SQL standard
SELECT GETDATE() AS get_date_value, CURRENT_TIMESTAMP AS current_timestamp_value;

-- More precise
SELECT SYSDATETIME() AS sysdatetime_value;

-- Cast to date only
SELECT CAST(SYSDATETIME() AS DATE) AS sysdatetime_value;

-- CAST function syntax: CAST( expression AS data_type)
SELECT CAST(SYSDATETIME() AS TIME) AS sysdatetime_value;

--UTC date and time functions:
SELECT GETUTCDATE() AS getutcdate_value, SYSUTCDATETIME() AS sysutcdatetime_value;

--selecting some columns from the hcm.employees table:
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date
FROM hcm.employees;

--The DATEPART function returns an integer 
--representing the specified datepart of the specified date:
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEPART(year, hire_date) AS hire_year
FROM hcm.employees;

SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEPART(year, hire_date) AS hire_year,
	DATEPART(month, hire_date) AS hire_month,
	DATEPART(day, hire_date) AS hire_day
FROM hcm.employees;

--DATENAME returns full name
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATENAME(year, hire_date) AS hire_year,
	DATENAME(month, hire_date) AS hire_month,
	DATENAME(day, hire_date) AS hire_day
FROM hcm.employees;

-- Count of employees hired in each year:
SELECT 
	DATEPART(year, hire_date) as hire_year,
	COUNT(*) AS hire_count
FROM hcm.employees
GROUP BY DATEPART(year, hire_date);

-- Count of employees hired in each year:
SELECT 
	YEAR(hire_date) as hire_year,
	COUNT(*) AS hire_count
FROM hcm.employees
GROUP BY YEAR(hire_date);
 
--selecting some columns from the hcm.employees table:
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date
FROM hcm.employees;

-- DATEADD function syntax: DATEADD( interval, number, date_expression )
-- Use DATEADD to add 5 years to the hire_date to know when each employees 5 year anniversary is:
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEADD(year, 5, hire_date) AS five_years_date
FROM hcm.employees;

-- Use the DATEDIFF function to calculate how many days each employee has worked at the company as of today.
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEDIFF(day, hire_date, CURRENT_TIMESTAMP) AS days_employed
FROM hcm.employees;

/*
Some possible time intervals we can use in the first argument of the DATEADD and DATEDIFF functions:
year
month
dayofyear
day
week
weekday
hour
minute
second
millisecond
*/