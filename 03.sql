select * from employees -- 107 empleados
select * from departments -- 27 departamentos

-- cross join, producto cruz, sin sentido informativo
select *
from employees, departments -- 107 x 27 = 2889 filas

-- inner join (equi join) ¿en que departamento trabajan los empleados?
select e.department_id, e.employee_id, e.first_name, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id -- FK(dept) en employees = PK de departaments
order by e.department_id 

-- inner join (equi join) ¿cual es el jefe de cada departamento?
select e.department_id, e.employee_id, e.first_name, e.last_name, d.department_name
from employees e, departments d
where d.manager_id = e.employee_id -- FK(emp) en departments = PK de employees

-- self join ¿cual es el jefe de cada empleado?
-- OMNIDB TIENE PROBLEMAS CON LOS SELF JOINS "MUCHO CUIDADO"
-- EL TRUCO PARA RESOLVERLO ES FORZAR LOS ALIAS EN LOS ATRIBUTOS
select sub.first_name noms, sub.last_name aps, jefe.first_name nomj, jefe.last_name apj
from employees sub, employees jefe
where sub.manager_id = jefe.employee_id -- FK(emp) en sub = PK de jefe

-- restricciones adicionales al join, ¿que empleados trabajan en los departamentos 80 o 90?
select e.department_id, e.employee_id, e.first_name, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.department_id in (80,90)
order by e.department_id

-- restricciones adicionales al join, ¿de que departamento es jefe King?
select e.department_id, e.employee_id, e.first_name, e.last_name, d.department_name
from employees e, departments d
where d.manager_id = e.employee_id
and   lower(last_name) = 'king'

-- restricciones adicionales al join, ¿que empleados tienen como jefe a King?
select sub.first_name noms, sub.last_name aps, jefe.first_name nomj, jefe.last_name apj
from employees sub, employees jefe
where sub.manager_id = jefe.employee_id 
and jefe.last_name like '_ing'

-- joins con mas de dos tablas, N tablas requieren N-1 joins
select l.city, d.department_name, e.last_name
from locations l, departments d, employees e
where l.location_id = d.location_id
and   d.department_id = e.department_id
and l.city = 'Oxford'