/*
Write a query that calculates the difference between the highest salaries found in the
 marketing and engineering departments. Output just the absolute difference in salaries.
table1 - db_employee
id:int
first_name:varchar
last_name:varchar
salary:int
department_id:int

table2 - db_dept
id:int
department:varchar

*/

with m_salary as(
select max(salary) as x from db_employee where department_id = 4),
e_salary as (
select max(salary) as y from db_employee where department_id = 1)
select (x-y) as 
salary_difference from m_salary as m cross join e_salary as e;