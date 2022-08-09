-- restricciones de integridad definidas a nivel de atributo
create table emps (
   employee_id integer constraint emps_pk primary key,
   first_name varchar2(20), 
   last_name varchar2(25), 
   salary integer constraint emps_nn_salary not null constraint emps_ck_salary check(salary > 0),
   department_id integer constraint emps_fk_works references deps(department_id)
                         constraint emps_nn_department_id not null
)

insert into emps
select employee_id, first_name, last_name, salary, department_id
from employees
where department_id in (90,60)

commit

select * from emps

insert into emps
values (10, 'Diego', 'Maradona', null, 90) -- error de not null

insert into emps
values (10, 'Diego', 'Maradona', 1000, null) -- error de not null en fk

insert into emps
values (10, 'Diego', 'Maradona', -1000, 90) -- error de check


-- restricciones de integridad definidas a nivel de tabla
drop table emps

create table emps (
   employee_id integer,
   first_name varchar2(20), 
   last_name varchar2(25), 
   salary integer default 1000,
   department_id integer constraint emps_nn_department_id not null,
   
   constraint emps_pk primary key(employee_id),
   constraint emps_uk_noms unique(first_name, last_name),
   constraint emps_ck_salary check(salary > 0),
   constraint emps_fk_works foreign key(department_id) references deps(department_id)
)

insert into emps
select employee_id, first_name, last_name, salary, department_id
from employees
where department_id in (90,60)

select * from emps

insert into emps(employee_id, first_name, last_name, department_id) 
values (10, 'Diego', 'Maradona', 90)

insert into emps(employee_id, first_name, last_name, department_id) 
values (11, 'Diego', 'Maradona', 90) --- error uk

drop table emps

-- restricciones de integridad agregadas con posterioridad
create table emps as
select employee_id, first_name, last_name, salary, department_id
from employees
where salary > 10000

select * from emps

alter table emps add constraint emps_pk primary key(employee_id)
alter table emps add constraint emps_uk_noms unique(first_name, last_name)
alter table emps add constraint emps_ck_salary check(salary > 0)
-- error, la bd esta inconsistente
alter table emps add constraint emps_fk_works foreign key(department_id) references deps(department_id)

-- VALIDATE, NOVALIDATE - ENABLE, DISABLE
alter table emps add constraint emps_fk_works foreign key(department_id) references deps(department_id) novalidate

alter table emps modify salary default 1000
alter table emps modify department_id constraint emps_nn_department_id not null

insert into emps
values (10,'Diego','Maradona',default,5)

alter table emps disable constraint emps_fk_works

insert into emps
values (10,'Diego','Maradona',default,5)

alter table emps enable novalidate constraint emps_fk_works 

-- CUIDADO CON "alter table emps enable novalidate constraint emps_pk"
-- ORACLE NO TOMA EN CUENTA UN enable novalidate de una clave primaria, ya que crea un indice único por clave primaria
-- POR LO QUE SIEMPRE VALIDA LA UNICIDAD

-- consulta al diccionario de datos
select * from user_constraints

select * from emps

-- INITIALLY DEFERRED,IMMEDIATE DEFERRABLE (consistencia)
drop table emps

create table emps (
   employee_id integer,
   first_name varchar2(20), 
   last_name varchar2(25), 
   salary integer default 1000,
   department_id integer constraint emps_nn_department_id not null,
   
   constraint emps_pk primary key(employee_id),
   constraint emps_uk_noms unique(first_name, last_name),
   constraint emps_ck_salary check(salary > 0),
   constraint emps_fk_works foreign key(department_id) references deps(department_id)
              initially immediate deferrable
)

insert into emps
select employee_id, first_name, last_name, salary, department_id
from employees
where department_id in (90,60)

commit

select * from emps

insert into emps
values (10,'Diego','Maradona',1000,15)

set constraint emps_fk_works deferred

insert into emps
values (10,'Diego','Maradona',1000,15)

-- la bd esta inconsistente
select * from emps

-- se produce un rollback del sabd, por violacion de la restricción de integridad postergada (deferred)
commit

set constraint emps_fk_works deferred

insert into emps
values (10,'Diego','Maradona',1000,15)

-- la bd esta inconsistente
select * from emps

-- se repara la inconsistencia
update emps set department_id = 90 where employee_id = 10

commit

select * from emps

-- ON DELETE CASCADE, ON DELETE SET NULL (reparación) 
-- ON UPDATE CASCADE, ON UPDATE SET NULL (no admisibles en Oracle)

drop table emps

create table emps (
   employee_id integer,
   first_name varchar2(20), 
   last_name varchar2(25), 
   salary integer default 1000,
   department_id integer constraint emps_nn_department_id not null,
   
   constraint emps_pk primary key(employee_id),
   constraint emps_uk_noms unique(first_name, last_name),
   constraint emps_ck_salary check(salary > 0),
   constraint emps_fk_works foreign key(department_id) references deps(department_id) 
              on delete set null
)

insert into emps
select employee_id, first_name, last_name, salary, department_id
from employees
where department_id in (90,60)

commit

select * from emps
select * from deps

delete from deps where department_id = 90

-- los empleados del departamento 90 han cambiado su department_id a null
select * from deps
select * from emps

rollback