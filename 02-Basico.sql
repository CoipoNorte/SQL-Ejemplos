ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN' NLS_TERRITORY= 'AMERICA' NLS_CURRENCY= '$' NLS_ISO_CURRENCY= 'AMERICA' NLS_NUMERIC_CHARACTERS= '.,' NLS_CALENDAR= 'GREGORIAN' NLS_DATE_FORMAT= 'DD-MON-RR' NLS_DATE_LANGUAGE= 'AMERICAN' NLS_SORT= 'BINARY'

-- proyecciones
select employee_id id , first_name nombre, last_name apellido, salary sueldo
from employees

-- descartar duplicados con DISTINCT
select distinct job_id
from employees

-- operadores relacionales: > < >= <= = <> !=
select employee_id id, first_name nombre, last_name apellido, job_id trabajo, salary sueldo
from employees
where salary < 5000

-- condiciones logicas: AND OR NOT
select employee_id id, first_name nombre, last_name apellido, job_id trabajo, salary sueldo
from employees
where job_id = 'ST_CLERK' 
and salary >= 3000

select employee_id id, first_name nombre, last_name apellido, job_id trabajo, salary sueldo
from employees
where salary >= 5000 and salary <= 10000

-- between
select employee_id id, first_name nombre, last_name apellido, job_id trabajo, salary sueldo
from employees
where salary between 5000 and 10000

-- disticion entre sentencia SQL, esquema y dato
SELECT employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from EMPLOYEES
where lower(job_id) like 'sa_rep'

-- comparacion con strings: like con comodines % (0 o mas), _ (exactamente 1)
SELECT employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from EMPLOYEES
where job_id like 'SA%'

SELECT employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from EMPLOYEES
where job_id like 'SA_RE_'

-- escape fuerza a que que el comodin sea tratado como caracter (antecedido por @)
SELECT employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from EMPLOYEES
where job_id like 'SA@_RE_' escape '@'

-- precedencia de operadores
select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from employees
where job_id = 'SA_REP' 
or    job_id = 'AD_PRES' 
and salary > 15000

select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from employees
where (job_id = 'SA_REP' 
or    job_id = 'AD_PRES')
and salary > 15000

-- in y not in
select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from employees
where job_id in ('SA_REP', 'AD_PRES', 'IT_PROG')

select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from employees
where job_id = 'SA_REP'
or    job_id = 'AD_PRES'
or    job_id = 'IT_PROG'

select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from employees
where job_id not in ('SA_REP', 'AD_PRES', 'IT_PROG')

select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, salary sueldo
from employees
where job_id <> 'SA_REP'
and   job_id <> 'AD_PRES'
an    job_id <> 'IT_PROG'

-- valores nulos requieren el operador IS o IS NOT
select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, commission_pct comision, salary sueldo
from employees
where commission_pct is NULL

select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, commission_pct comision, salary sueldo
from employees
where commission_pct is not NULL

-- order by
select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, commission_pct comision, salary sueldo
from employees
where commission_pct is not NULL
order by commission_pct desc, salary asc 

-- orden lexicografico en strings
select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, commission_pct comision, salary sueldo
from employees
order by job_id

-- cambiar la posicion de los valores nulos
select employee_id id, first_name nombre, lower(last_name) apellido, job_id trabajo, commission_pct comision, salary sueldo
from employees
order by commission_pct desc nulls last