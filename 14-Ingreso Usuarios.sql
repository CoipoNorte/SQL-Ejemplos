-- ingreso de los estudiantes a los equipos

insert into Forma
select codp, codeq, 1, 'ingreso', to_date('01/01/2015','DD/MM/YYYY')
from Estudiante;

commit;

-- eliminacion de la antigua columna que representaba la relacion Forma como clave foranea en estudiante.

alter table estudiante drop column codeq;

-- ingreso de la historia de los estudiantes con respecto a los equipos a partir de los datos almacenados en la tabla Cambios.

insert into forma
select es.codp codes, eq.codp codeq, c.secuencia, c.evento, c.fecha
from estudiante es join cambios c on (es.nombre = c.nombre 
and (es.apellido = c.apellido or es.apellido is null)) -- cuidado con los apellidos nulos
join equipo eq on (eq.nombre = c.equipo);

commit;

-- vista EstudiantesHistoria, que muestra los estudiantes (nombre y apellido) y los equipos (nombre) ha los que han pertenecido.

create view EstudiantesHistoria as
select distinct es.nombre, es.apellido, eq.nombre nombre_equipo
from estudiante es, equipo eq, forma f
where es.codp = f.codes
and eq.codp = f.codeq
and f.evento = 'ingreso';

-- vista EstudiantesRetirados que muestra los estudiantes (nombre y apellido) que pertenecieron a un equipo (nombre), pero que ya no lo hacen mas.

create view EstudiantesRetirados as
select es.nombre, es.apellido, eq.nombre nombre_equipo
from estudiante es, equipo eq, forma f
where es.codp = f.codes
and eq.codp = f.codeq
and f.evento = 'retiro'
and not exists (select 1
                from forma
                where fecha > f.fecha -- puede usarse tambion seq
                and codes = es.codp
                and codeq = eq.codp
                and evento = 'ingreso');