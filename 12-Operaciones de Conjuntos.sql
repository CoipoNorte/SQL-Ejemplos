ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN' NLS_TERRITORY= 'AMERICA' NLS_CURRENCY= '$' NLS_ISO_CURRENCY= 'AMERICA' NLS_NUMERIC_CHARACTERS= '.,' NLS_CALENDAR= 'GREGORIAN' NLS_DATE_FORMAT= 'DD-MON-RR' NLS_DATE_LANGUAGE= 'AMERICAN' NLS_SORT= 'BINARY'

-- OPERACIONES DE CONJUNTOS

-- union
select employee_id, job_id from employees
union
select employee_id, job_id from job_history

select employee_id, job_id from employees
union all
select employee_id, job_id from job_history

-- intersect
select employee_id, job_id from employees
intersect
select employee_id, job_id from job_history

-- minus
select employee_id, job_id from employees
minus
select employee_id, job_id from job_history

-- forzando la compatibilidad
select employee_id, job_id, salary, 'actual' estado from employees
union
select employee_id, job_id, null, 'historico' from job_history

-- VISTAS IN LINE

-- notacion clasica
select e.first_name, e.last_name, d.department_name
from employees e, (select department_id, department_name from departments) d
where e.department_id = d.department_id

-- notacion sql99, subquery factoring clause
with d as (select department_id, department_name from departments)
select e.first_name, e.last_name, d.department_name
from employees e, d
where e.department_id = d.department_id

-- analisis top-n con vistas in line
select rownum, first_name, last_name, salary from employees
where rownum <= 10

select rownum, first_name, last_name, salary from employees
where rownum <= 10
order by salary desc

select rownum, e.first_name, e.last_name, e.salary
from (select first_name, last_name, salary from employees
      order by salary desc) e
where rownum <= 10