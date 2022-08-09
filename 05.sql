-- funciones de agrupamiento
select sum(salary) sum_sal, avg(salary) prom_sal,
       max(salary) max_sal, min(salary) min_sal
from employees

-- max y min sobre otros tipos de datos
select max(last_name), min(last_name), max(hire_date), min(hire_date)
from employees

-- count()
select count(employee_id), count(department_id), 
       count(commission_pct), count(distinct department_id)
from employees

-- valores nulos
select avg(commission_pct)
from employees

select avg(nvl(commission_pct,0)) 
from employees

-- group by
select sum(salary) from employees

select department_id, sum(salary) 
from employees
group by department_id
order by department_id

select department_id, job_id, sum(salary) 
from employees
group by department_id, job_id
order by department_id, job_id

-- having
select department_id, sum(salary) sals
from employees
group by department_id
having sum(salary) > 10000
order by sals

select department_id, sum(salary) sals
from employees
where job_id <> 'IT_PROG'
group by department_id
having sum(salary) > 10000
order by sals

-- con joins
select e.department_id, d.department_name, e.job_id, sum(salary) sum_sal
from employees e, departments d
where job_id <> 'IT_PROG'
and   e.department_id = d.department_id
group by e.department_id, d.department_name, e.job_id
having sum(salary) > 10000
order by department_id, job_id

-- anidacion de funciones de agrupamiento
select max(sum(salary)) from employees group by department_id

-- subconsultas
select salary from employees where last_name = 'Abel'

-- single row subquery =, >, <, >=, <=, <>
select salary from employees where last_name = 'Abel'

-- en la condicion de where
select last_name from employees
where salary > (select salary*1.1 from employees where last_name = 'Abel')

select first_name, last_name from employees
where salary = (select min(salary) from employees)

-- en la condicion de having
select department_id, min(salary)
from employees
group by department_id 
having min(salary) > (select min(salary) from employees where department_id = 100)