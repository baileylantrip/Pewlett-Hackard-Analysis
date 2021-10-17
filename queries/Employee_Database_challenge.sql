--Deliverable 1
-- Create Retirement Titles
SELECT e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no ASC, to_date DESC;

-- Create Retiring Titles
SELECT COUNT(ut.emp_no),ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Create Mentorship ELigibility 
SELECT DISTINCT ON (e.emp_no)e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees as e 
INNER JOIN dept_emp as de
ON (e.emp_no=de.emp_no)
INNER JOIN titles as t 
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

-- Additioal Analysis 
SELECT DISTINCT ON(emp_no)emp_no, dept_no, to_date
INTO dept_filter 
FROM dept_emp
ORDER BY emp_no ASC, to_date DESC; 

SELECT un.emp_no, un.title, de.dept_no, de.to_date, du.dept_name
INTO dept_unique
FROM unique_titles as un
LEFT JOIN dept_filter as de 
ON (un.emp_no = de.emp_no)
LEFT JOIN departments as du
ON (de.dept_no = du.dept_no);

SELECT COUNT(emp_no) AS emp_count, dept_name
FROM dept_unique
GROUP BY dept_name 
ORDER BY emp_count DESC;


SELECT COUNT (title), title 
FROM mentorship_eligibility 
-- INTO mentorship_titles 
GROUP BY title 
ORDER BY count DESC;
