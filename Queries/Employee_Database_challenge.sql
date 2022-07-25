--Deliverable 1
--Retreive the emp_no, first_name, and last name columns from employees table
SELECT emp_no, first_name, last_name
FROM employees;

--Retreive the title, from_date and to_date columns form titles table 

SELECT emp_no, title, form_date,to_date FROM titles;
SELECT COUNT (*) FROM titles;

SELECT e.emp_no, e.first_name, e.last_name,
       t.title, t.form_date, t.to_date
INTO retirement_titles	   
FROM employees e 
INNER JOIN titles t ON (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

--Confirm that the new table looks like the one in challenge documentation
SELECT * FROM retirement_titles
SELECT COUNT (*) FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
--Create a unique_titles table
--Sort the unique titles table by ascending emp_no order and descending order by last date
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles

--Write a query in the employee_database_challenge.sql file to retrieve the number of employees by their most recent job title
SELECT COUNT(*) AS count ,title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(*) DESC;

SELECT * FROM retiring_titles

--Write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate
SELECT e.emp_no, e.first_name, e.last_name, e.birth_date 
FROM employees as e;

SELECT de.from_date, de.to_date
FROM dept_emp as de;

SELECT t.title
FROM titles as t;

--Use a distinct on to retrieve the first occurance of the employee # for each set of rows defined by the ON() clause
SELECT DISTINCT ON (t.emp_no) t.emp_no, e.first_name, e.last_name, e.birth_date,
	   de.from_date, de.to_date, t.title
INTO mentorship_eligibilty
FROM employees e 
	INNER JOIN dept_emp de ON (e.emp_no = de.emp_no)
	INNER JOIN titles t ON (e.emp_no = t.emp_no)
WHERE de.to_date='9999-01-01' 
AND t.to_date='9999-01-01' 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY t.emp_no;

SELECT * FROM mentorship_eligibilty

--Analysis

select count(distinct e.emp_no)
from employees e 
inner join dept_emp t on (e.emp_no=t.emp_no)
--300024 employees

select count(distinct e.emp_no)
from employees e 
inner join dept_emp t on (e.emp_no=t.emp_no)
and t.to_date='9999-01-01'
--240124 current employees

select * 
into all_year_titles 
from 
(select distinct extract(YEAR from birth_date) birth_year 
from employees) e
cross join
(select distinct title 
from titles) t;

select t.title,extract(YEAR from e.birth_date) birth_year,count(*) tot_cnt
into emp_year_titles 
from 
(SELECT DISTINCT ON (emp_no) emp_no, title
FROM titles
WHERE to_date='9999-01-01'
ORDER BY emp_no, to_date DESC) t
inner join employees e on (e.emp_no=t.emp_no)
group by t.title,extract(YEAR from e.birth_date)
order by t.title,extract(YEAR from e.birth_date)
;

SELECT COUNT (*) From mentorship_eligibilty
--1549 employees eligible for mentorship

SELECT * FROM retirement_titles

--Additional Queries

