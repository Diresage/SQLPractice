-- Functional Dependecies
-- A column is functionally determines another coumn when one column of unique values correlates to the same or unique values for another column

-- Candidate Keys is eather a single column with unique values or multiple columns that produce a unique combination of values and the Candidate key is irreductible
-- Super Keys are combinations of keys that create a unique set for each row but are not necessarily irreductible

-- First Normal Form 1NF
-- Each column has atomic values that are of the same type and there are no duplicate rows

-- Second Normal Form 2NF
-- All non-key attributes are functionally dependent on the whole of every Candidate key

-- Third Normal Form 3NF
-- No non-key attributes depend on an attribute(s) that is not a super key

-- Boyce-Codd Normal Form BCNF
-- Any non-trivial functional dependency A -> B then A is a super key