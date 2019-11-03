CREATE TABLE depts (
  dept_no VARCHAR PRIMARY KEY,
  dept_name VARCHAR
);
SELECT * FROM depts;
CREATE TABLE emps (
  emp_no INT PRIMARY KEY,
  birth_date DATE,
  first_name VARCHAR,
  last_name VARCHAR,
  gender VARCHAR(1),
  hire_date DATE
);
SELECT * FROM emps;
CREATE TABLE dept_emps (
	emp_id INT,
	dept_id VARCHAR,
	FOREIGN KEY (dept_id) REFERENCES depts(dept_no),	
	FOREIGN KEY (emp_id) REFERENCES emps(emp_no),
	from_date DATE,
	to_date DATE
);
SELECT * FROM dept_emps;
CREATE TABLE salaries (
  emp_id INT,
  FOREIGN KEY (emp_id) REFERENCES emps(emp_no),
  salary INT,
  from_date DATE,
  to_date DATE
);
SELECT * FROM salaries;
CREATE TABLE dept_manager (
  dept_id VARCHAR,
  FOREIGN KEY (dept_id) REFERENCES depts(dept_no),
  emp_no INT,
  from_date DATE,
  to_date DATE
);
SELECT * FROM dept_manager;
CREATE TABLE titles (
  emp_id INT,
  FOREIGN KEY (emp_id) REFERENCES emps(emp_no),
  title VARCHAR,
  from_date DATE,
  to_date DATE
);
SELECT * FROM titles;

____________________________________
--1.) List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM salaries AS s
INNER JOIN emps AS e ON
e.emp_no=s.emp_id;
--End
--2.) List employees who were hired in 1986.
SELECT first_name, last_name, hire_date FROM emps WHERE hire_date BETWEEN 
'1986-01-01' AND '1986-12-31';
--End
--3.)List the manager of each department with the following information: department number, department name,
--the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM depts AS d
INNER JOIN dept_manager AS dm ON
d.dept_no=dm.dept_id
INNER JOIN emps AS e ON
e.emp_no=dm.emp_no;
--End
--4.) List the department of each employee with the following information: employee number, last name, first name, and department name. 
SELECT d.dept_name, e.last_name, e.first_name, e.emp_no
FROM depts AS d
INNER JOIN dept_emps AS de ON
d.dept_no=de.dept_id
INNER JOIN emps AS e ON
e.emp_no=de.emp_id;
--End
--5.) List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM emps WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
--End
--6.)List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.
SELECT d.dept_name, e.last_name, e.first_name, e.emp_no
FROM depts AS d
INNER JOIN dept_emps AS de ON
d.dept_no=de.dept_id
INNER JOIN emps AS e ON
e.emp_no=de.emp_id
WHERE d.dept_name = 'Sales';
--End
--7.)List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
SELECT d.dept_name, e.last_name, e.first_name, e.emp_no
FROM depts AS d
INNER JOIN dept_emps AS de ON
d.dept_no=de.dept_id
INNER JOIN emps AS e ON
e.emp_no=de.emp_id
WHERE d.dept_name in ('Sales', 'Development');

--8.)In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name, COUNT (*) 
FROM emps 
GROUP BY last_name
ORDER BY COUNT DESC;
--END

