USE SAMPLEDB
GO

-- Create dbo.dept parent table:
CREATE TABLE dbo.dept 
(
	dept_id INT IDENTITY(1,1),
	dept_name VARCHAR(50) NOT NULL,
	CONSTRAINT PK_dept_dept_id PRIMARY KEY (dept_id)
);


-- Populate the dbo.dept table with data:
INSERT INTO dbo.dept (dept_name) VALUES ('Business Intelligence');

INSERT INTO dbo.dept (dept_name)
SELECT department_name
FROM hcm.departments;



-- Create dbo.emp child table:
CREATE TABLE dbo.emp 
(
	emp_id INT IDENTITY, 
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	hire_date DATE NOT NULL,
	dept_id INT,
	CONSTRAINT PK_emp_emp_id PRIMARY KEY (emp_id),
	CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dbo.dept (dept_id)
);

-- Populate the dbo.emp table with data:
INSERT INTO dbo.emp (first_name, last_name, hire_date, dept_id)
	VALUES ('Scott', 'Davis', '20201211', 1),
		   ('Miriam', 'Yardley', '20201205', 1);

