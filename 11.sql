ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN' NLS_TERRITORY= 'AMERICA' NLS_CURRENCY= '$' NLS_ISO_CURRENCY= 'AMERICA' NLS_NUMERIC_CHARACTERS= '.,' NLS_CALENDAR= 'GREGORIAN' NLS_DATE_FORMAT= 'DD-MON-RR' NLS_DATE_LANGUAGE= 'AMERICAN' NLS_SORT= 'BINARY'

select * from emps

-- grant
-- select, insert, update(), delete, alter, references
grant select on emps to informatica
grant update(salary) on emps to informatica

-- con grant option
grant select on emps to informatica with grant option

-- public
grant select on emps to public

-- revoke
revoke select on emps from public
revoke select on emps from informatica

-- roles
create role c##usr

grant select, insert, update, delete on emps to c##usr

grant c##usr to informatica

-- usuario informatica debe cambiarse al rol para asumir estos privilegios
select * from session_roles

set role c##usr
set role all

-- consultas de privilegios
select * from user_sys_privs

select * from role_sys_privs

select * from role_tab_privs

select * from user_role_privs

select * from user_tab_privs

select * from user_roles

-- transacciones
select sysdate from dual

-- User1 (rvaldivia)
create table usuario (nombre varchar2(20))
grant select on usuario to informatica

-- User1 (rvaldivia)				User2 (informatica)
						select * from rvaldivia.saludos
insert into saludos values (7,'arrivederci',sysdate)
select * from saludos
						select * from rvaldivia.saludos -- que ve aquí (1)
commit
						select * from rvaldivia.saludos -- que ve aquí (2)
						
                                                commit
						SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
insert into saludos values (8,'buona sera',sysdate)
select * from saludos
commit
						select * from rvaldivia.saludos -- que ve aquí (3)
						commit

						select * from rvaldivia.saludos -- que ve aqui (4)