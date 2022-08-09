-- DDL
drop table emps

create table emps as -- ddl
select employee_id, first_name, last_name, salary, department_id from employees
where salary > 10000

select * from emps

-- DML
-- insert values
insert into emps values(10, 'Diego','Maradona', 10000, 10)

insert into emps(employee_id,last_name,first_name) values(10, 'Maradona', 'Diego')

rollback

insert into emps values (10, 'Diego', 'Maradona', (select salary from employees where employee_id = 100), 10)

commit

-- insert select
insert into emps
select employee_id, first_name, last_name, salary, department_id from employees
where salary < 2500

commit

-- update
update emps
set salary = 10
where employee_id = 10

update emps
set salary = null
where employee_id = 10

update emps
set salary = (select salary from emps where employee_id = 100)
where employee_id = 10

commit

-- correlated update
alter table emps add (depts varchar2(14)) -- DDL

update emps e
set depts = (select department_name from departments d where d.department_id = e.department_id) 

-- delete
delete from emps

rollback

delete from emps
where employee_id = 10

rollback

delete from emps
where salary = (select salary from emps where employee_id = 100)

commit

-- DDL 
-- drop table
drop table depts
drop table emps

-- create table con primary key
create table depts(
   dept_id integer primary key,
   dept_name varchar2(30),
   city varchar2(30)
)

select * from user_tables

insert into depts
select d.department_id, d.department_name, l.city
from departments d join locations l on (d.location_id = l.location_id and d.department_id in (90,60))

commit

select * from depts

insert into depts values (90,'Ejecutivos','Arica') -- error de pk

drop table depts

-- create table con constraint primary key
create table depts(
   dept_id integer constraint depts_pk primary key,
   dept_name varchar2(30),
   city varchar2(30)
)

insert into depts
select d.department_id, d.department_name, l.city
from departments d join locations l on (d.location_id = l.location_id and d.department_id in (90,60))

commit

select * from depts

insert into depts values (90,'Ejecutivos','Arica') -- error de pk