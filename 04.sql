-- non equi join ¿cual es el grado de mis empleados?
select j.grade, j.lowest_sal, j.highest_sal, e.first_name, e.last_name, e.salary
from job_grades j, employees e
where e.salary between j.lowest_sal and j.highest_sal

-- repaso joins clasicos
select employee_id, last_name, department_name
from employees e, departments d
where e.department_id = d.department_id

select employee_id, last_name
from employees
where department_id is null

-===============================================================
- NOTACIÃ“N SQL3 
-===============================================================

--cross join
select * from employees cross join departments

--natural join
--CUIDADO HACE CALZAR manager_id y department_id
select * from employees natural join departments

select * from locations natural join departments

--equi join (inner join con using)
select employee_id, last_name, department_id, department_name 
from employees inner join departments using (department_id)

--inner join con on
select e.employee_id, e.last_name, d.department_id, d.department_name 
from employees e inner join departments d on (e.department_id = d.department_id)

--left outer join
select e.employee_id, e.last_name, d.department_id, d.department_name 
from employees e left outer join departments d on (e.department_id = d.department_id)

--right outer join
select e.employee_id, e.last_name, d.department_id, d.department_name 
from employees e right outer join departments d on (e.department_id = d.department_id)

--full outer join
select e.employee_id, e.last_name, d.department_id, d.department_name 
from employees e full outer join departments d on (e.department_id = d.department_id)

-- CUIDADO CON LAS RESTRICCIONES ADICIONALES
select e.employee_id, e.last_name, d.department_id, d.department_name 
from employees e right outer join departments d on (e.department_id = d.department_id and d.department_id = 80)

select e.employee_id, e.last_name, d.department_id, d.department_name 
from employees e right outer join departments d on (e.department_id = d.department_id)
where d.department_id = 80