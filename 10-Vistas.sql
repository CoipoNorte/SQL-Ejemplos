select * from deps

select * from emps

-- VISTAS
create or replace view emps60 as
   select *
   from emps
   where department_id = 60
   
select * from emps60

select * from emps60
where salary > 5000

create or replace view emps60ann as
   select first_name, last_name, salary, salary*12 ann_sal
   from emps
   where department_id = 60

select * from emps60ann

select * from emps60ann
where ann_sal > 10000

create or replace view emps60deps as
   select e.employee_id, e.first_name, e.last_name, e.salary, d.department_id, d.department_name
   from emps e join deps d 
   on (e.department_id = d.department_id and e.department_id = 60)


select * from emps60deps

select * from emps60deps
where last_name like 'P%'

create or replace view empstot as
   select d.department_name, count(1) tot
   from emps e join deps d on (e.department_id = d.department_id)
   group by d.department_id, d.department_name
  
select * from empstot

select * from empstot
where tot > 4

-- VISTAS ACTUALIZABLES (dml sobre tablas base a través de vistas)

-- admisible
insert into emps60 values (10,'Diego','Maradona',10000,60)

select * from emps60

select * from emps

-- admisible
update emps60ann set salary = 10001 where last_name = 'Maradona'

select * from emps60ann

-- no admisible (error con columna virtual)
update emps60ann set salann = 12 where last_name = 'Maradona'

-- admisible
update emps60deps set last_name = 'Valdez' where last_name = 'Maradona'

select * from emps60deps

-- no admisible (lado repetible del join)
update emps60deps set department_name = 'ITX' where last_name = 'Maradona'

-- no admisible (vista definida con un group by)
update empstot set tot = 5 where department_id = 90


-- VIOLACIÓN DE LA DEFINICIÓN DE UNA VISTA
-- with check option

select * from emps60
select * from emps

insert into emps60 values (10,'Diego','Maradona',10000,90)

select * from emps60
select * from emps
rollback

create or replace view emps60 as
   select *
   from emps
   where department_id = 60
with check option constraint emps60_ck

-- error de check
insert into emps60 values (10,'Diego','Maradona',10000,90)

insert into emps60 values (10,'Diego','Maradona',10000,60)
rollback

create or replace view emps60 as
   select *
   from emps
   where department_id = 60
with read only

-- error vista de solo lectura
insert into emps60 values (10,'Diego','Maradona',10000,60)