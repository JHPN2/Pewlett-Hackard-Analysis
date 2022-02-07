-- Retrieve data (Part 1)
SELECT employees.emp_no,
		employees.first_name,
		employees.last_name,	
		titles.title,
		titles.from_date,
		titles.to_date
INTO retirement_titles
FROM employees LEFT JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows (Part 2)
SELECT DISTINCT ON (retirement_titles.emp_no) 
	retirement_titles.emp_no,
	retirement_titles.first_name,
	retirement_titles.last_name,
	retirement_titles.title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC;

-- Employees by most recent job title (Part 3)
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

-- #################################################################

SELECT DISTINCT ON (emp_no)
		employees.emp_no,
		employees.first_name,
		employees.last_name,	
		employees.birth_date,
		dept_emp.from_date,
		dept_emp.to_date,		
		titles.title
INTO mentor_table
FROM employees 
LEFT JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
LEFT JOIN titles ON (employees.emp_no = titles.emp_no)
WHERE (dept_emp.to_date = '9999-01-01')
AND (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY employees.emp_no, dept_emp.to_date DESC;
