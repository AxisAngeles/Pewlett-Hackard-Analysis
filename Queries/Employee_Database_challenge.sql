/* DELIVERABLE 1 */

-- 1) Retrieve the emp_no, first_name, and last_name columns from the Employees table.
-- 2) Retrieve the title, from_date, and to_date columns from the Titles table.
-- 3) Create a new table using the INTO clause.
-- 4) Join both tables on the primary key.
-- 5) Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. 
	-- Then, order by the employee number.
SELECT e.emp_no, first_name, last_name, title, from_date, to_date
	INTO retirement_titles
FROM employees e
LEFT JOIN titles t ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no ASC, t.to_date ASC;

-- 6) Export the Retirement Titles table.
SELECT * FROM retirement_titles LIMIT(100);

-- 10) Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
emp_no,first_name,last_name,title
	INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- 13) Export the Unique Titles table as unique_titles.csv.
SELECT * FROM unique_titles LIMIT(100);

-- 16) Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(title) AS Count, title as Title
	INTO retiring_titles
FROM unique_titles
GROUP BY 2
ORDER BY 1 DESC;

-- 19) Export the Retiring Titles table as retiring_titles.csv
SELECT * FROM retiring_titles;


/* DELIVERABLE 2 */
-- 1) Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
SELECT emp_no, first_name, last_name, birth_date FROM employees LIMIT(100)
-- 2) Retrieve the from_date and to_date columns from the Department Employee table.
SELECT from_date, to_date FROM dept_emp LIMIT(100)
-- 3) Retrieve the title column from the Titles table.
SELECT title FROM titles LIMIT(100)
-- 4) Use a DISTINCT ON statement to retrieve the first occurrence of the employee number 
	-- for each set of rows defined by the ON () clause.
	-- 5) Create a new table using the INTO clause.
SELECT DISTINCT ON (emp_no) 
emp_no,title
	INTO unique_titles_dev2
FROM titles
ORDER BY emp_no, to_date DESC;

-- 6 - 9) Join the Employees, the Department Employee and the Titles tables on the primary key.
	-- Filter the data 
	-- Order the table by the employee number
SELECT e.emp_no, e.first_name, e.last_name, e.birth_date,
	d.from_date, d.to_date,
	ut.title
INTO mentorship_eligibilty
FROM employees e 
	LEFT JOIN dept_emp d ON e.emp_no = d.emp_no
	LEFT JOIN unique_titles_dev2 ut ON e.emp_no = ut.emp_no
WHERE d.to_date = '9999-01-01' 
	AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

-- DROP TABLE mentorship_eligibilty CASCADE;


-- 10) Export the Mentorship Eligibility 
SELECT * FROM mentorship_eligibilty LIMIT(100);
