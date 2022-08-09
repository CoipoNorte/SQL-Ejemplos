-- multiple row subqueries

-- error !!!
select employee_id, last_name, job_id, salary
from   employees
where  salary =
                (select distinct salary    --multiples valores: 9000, 6000, 4800, 4200 
                from   employees
                where  job_id = 'IT_PROG')

-- any
select employee_id, last_name, job_id, salary
from   employees
where  salary < any
                (select distinct salary
                from   employees
                where  job_id = 'IT_PROG')

-- < any equivale a ...
select employee_id, last_name, job_id, salary
from   employees
where  salary <
                (select max(salary)
                from   employees
                where  job_id = 'IT_PROG')

-- all               
select employee_id, last_name, job_id, salary
from   employees
where  salary < all
                (select distinct salary
                from   employees
                where  job_id = 'IT_PROG')

-- > all equivale a ...
select employee_id, last_name, job_id, salary
from   employees
where  salary <
                (select min(salary)
                from   employees
                where  job_id = 'IT_PROG')

-- empleados sin departamentos
select last_name from employees where department_id is null

-- departamentos con empleados usando in
select department_name 
from departments
where department_id in (select distinct department_id
                        from employees)

-- departamentos sin empleados usando not in (cuidado con los valores nulos!!!)
select department_name 
from departments
where department_id not in (select distinct department_id
                            from employees
                            where department_id is not null)

-- correlated subqueries

-- empleados que ganan mas que el promedio de sus departamentos
select e.first_name, e.last_name, e.salary
from employees e
where e.salary > (select avg(salary) from employees where department_id =e.department_id)

-- empleados que han cambiado de trabajo dos o más veces
select e.first_name, e.last_name
from employees e
where (select count(*) from job_history where employee_id = e.employee_id) > 1

-- departamentos con empleados usando exists
select department_name
from departments d
where exists (select 1 from employees where department_id = d.department_id)

-- departamentos sin empleados usando not exists
select department_name
from departments d
where not exists (select 1 from employees where department_id = d.department_id)