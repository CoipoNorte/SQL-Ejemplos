-- creacion de las tablas equipo y estudiante

create table Equipo (
codp int constraint equipo_pk primary key,
nombre varchar(20),
ranking number(3)
);

create table Estudiante (
codp int constraint estudiante_pk primary key,
nombre varchar(20),
apellido varchar(20),
edad number(2),
ranking number(3),
codeq int constraint estudiante_fk_forma references Equipo(codp)
);

-- poblamiento de las tablas equipo y estudiante

insert into estudiante
select codp, nombre, apellido, edad, ranking_ind, null
from peanuts;

insert into equipo
select rownum+100, equipo, ranking_eq
from
    (select distinct equipo, ranking_eq from peanuts);

create view peanuts_new as
select p.codp codes, p.nombre nombre_ind, p.apellido apellido_ind , p.edad edad_ind, p.ranking_ind ranking_ind,
       e.codp codeq, e.nombre nombre_eq, e.ranking ranking_eq 
from equipo e join peanuts p on (p.equipo = e.nombre)

update estudiante e
set codeq = (select codeq from peanuts_new pn where e.codp = pn.codes)

commit;

-- vista de tabla anica paticipante

create or replace view Participante (codp,nombre,apellido,edad,ranking,codeq,tipo) as
select codp, nombre, apellido, edad, ranking, codeq, 'estudiante'
from estudiante
union
select codp, nombre, null, null, ranking, null, 'equipo'
from equipo;

-- creacion de la nueva tabla forma

create table Forma (
codes int,
codeq int,
secuencia int,
evento varchar(10) check (evento in ('ingreso','retiro')),
fecha date,
constraint forma_pk primary key(codes,codeq,secuencia),
constraint forma_fk_es foreign key(codes) references Estudiante(codp),
constraint forma_fk_eq foreign key(codeq) references Equipo(codp)
);