/*
We have a table with employees and their salaries, however, 
some of the records are old and contain outdated salary information. 
Find the current salary of each employee assuming that salaries increase each year. 
Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.

table - ms_employee_salary
id:int
first_name:varchar
last_name:varchar
salary:int
department_id:int

*/

select first_name,max(salary),department_id,last_name,id 
from ms_employee_salary 
group by first_name,last_name,department_id,id order by id ;