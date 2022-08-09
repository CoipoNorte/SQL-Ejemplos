ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN' NLS_TERRITORY= 'AMERICA' NLS_CURRENCY= '$' NLS_ISO_CURRENCY= 'AMERICA' NLS_NUMERIC_CHARACTERS= '.,' NLS_CALENDAR= 'GREGORIAN' NLS_DATE_FORMAT= 'DD-MON-RR' NLS_DATE_LANGUAGE= 'AMERICAN' NLS_SORT= 'BINARY'

-- pregunta 1
select titulo, texto
from poema
where lower(texto) like '%amor%amor%amor%'

-- pregunta 2
select e.nombre, e.apellido, p.titulo
from escritor e join poema p on (e.poema_id = p.poema_id) 
where nombre = 'Antonio' and apellido = 'Machado'

select e.nombre, e.apellido, p.titulo
from escritor e, poema p
where e.poema_id = p.poema_id and nombre = 'Antonio' and apellido = 'Machado'

select titulo from poema
where poema_id = 
   (select poema_id
    from escritor
    where nombre = 'Antonio' and apellido = 'Machado')
    
-- pregunta 3
select e.nombre, e.apellido
from escritor e join poema p on (e.escritor_id = p.escritor_id)
where p.titulo like 'Eleg_a' or p.titulo = 'Sonatina'

select e.nombre, e.apellido
from escritor e, poema p
where e.escritor_id = p.escritor_id and (p.titulo like 'Eleg_a' or p.titulo = 'Sonatina')

-- pregunta 4
select titulo from poema
where escritor_id =
      (select escritor_id from poema 
       where titulo = 'Walking Around')

select p.titulo
from poema wa, poema p
where wa.titulo = 'Walking Around'
and wa.escritor_id = p.escritor_id

-- pregunta 5
select titulo
from obra
where agno between
      (select agno-10 from obra where titulo = 'Romancero Gitano')
      and
      (select agno+10 from obra where titulo = 'Romancero Gitano')
      
select o.titulo 
from obra rg, obra o
where rg.titulo = 'Romancero Gitano'
and   o.agno between rg.agno-10 and rg.agno+10

-- pregunta 6
select o.titulo
from escritor e, poema p, obra o
where e.poema_id = p.poema_id and p.obra_id  = o.obra_id
and e.nombre = 'Pablo' and e.apellido = 'Neruda'

-- pregunta 7
select o.obra_id, o.titulo, count(*) cant
from poema p join obra o on (p.obra_id = o.obra_id)
group by o.obra_id, o.titulo
having count(*) > 1

-- pregunta 7 ++
select max(count(*)) cant
from poema p join obra o on (p.obra_id = o.obra_id)
group by o.obra_id, o.titulo
having count(*) > 1

-- tarea: ¿cual es la obra con mas poemas?

-- pregunta 8
select e.escritor_id, e.nombre, e.apellido, count(*) cant
from poema p join escritor e on (p.escritor_id = e.escritor_id)
group by e.escritor_id, e.nombre, e.apellido
order by cant asc