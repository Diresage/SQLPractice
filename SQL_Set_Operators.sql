--ALL set operators must have matching column number and matching data type

-- UNION operator combines the output of two or more SELECT into a single set of rows and removes duplicates
SELECT column_name1, column_name2
FROM table_name1
UNION
SELECT column_name1, column_name2
FROM table_name2;

-- UNION ALL will not remove duplicates
SELECT column_name1, column_name2, column_name3
FROM table_name1
UNION ALL
SELECT column_name1, column_name2, "addcolumn" AS column_name3
FROM table_name2;

-- INTERSECT will find rows that have common sets, matching NULL will evaluate to true
SELECT column_name1, column_name2, column_name3
FROM table_name1
INTERSECT
SELECT column_name1, column_name2, column_name3
FROM table_name2;

-- EXCEPT will find rows that have no common sets in first SELECTED table
SELECT column_name1, column_name2, column_name3
FROM table_name1
EXCEPT
SELECT column_name1, column_name2, column_name3
FROM table_name2;

--Set operator precedence () is evaluated first
1. INTERSECT
2. UNION
3. UNION ALL
4. EXCEPT