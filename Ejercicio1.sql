--BASE DE DATOS

create database ejercicio1
drop database ejercicio1

--TABLAS

create table Almacen(Nro int primary key, Responsable varchar(50))
create table Articulo(CodArt int primary key, Descripcion varchar(50), Precio decimal(12, 3))
create table Material(CodMat int primary key, Descripcion varchar(50))
create table Proveedor(CodProv int primary key, Nombre varchar(50), Domicilio varchar(50), Ciudad varchar(50))
create table Tiene(Nro int, CodArt int, constraint pktiene primary key(Nro, CodArt),
										constraint fktiealmacen foreign key(Nro) references Almacen(Nro),
										constraint fktiearticulo foreign key(CodArt) references Articulo(CodArt))
create table Compuesto_Por(CodArt int, CodMat int,
							constraint pkcompuesto primary key(CodArt, CodMat),
							constraint fkcomart foreign key(CodArt) references Articulo(CodArt),
							constraint fkcommat foreign key(CodMat) references Material(CodMat))
create table Provisto_Por(CodMat int, CodProv int,
							constraint pkprovisto primary key(CodMat, CodProv),
							constraint fkpromat foreign key(CodMat) references Material(CodMat),
							constraint fkproprov foreign key(CodProv) references Proveedor(CodProv))

--DATOS

insert into Almacen values
(1, 'Juan Perez'),
(2, 'Jose Basualdo'),
(3, 'Rogelio Rodriguez')
insert into Articulo values
(1, 'Sandwich JyQ', 5),
(2, 'Pancho', 6),
(3, 'Hamburguesa', 10),
(4, 'Hamburguesa completa', 15),
(5, 'Hamburguesa REcompleta', 15)
insert into Material values
(1, 'Pan'),
(2, 'Jamon'),
(3, 'Queso'),
(4, 'Salchicha'),
(5, 'Pan Pancho'),
(6, 'Paty'),
(7, 'Lechuga'),
(8, 'Tomate'),
(9, 'Papa'),
(10, 'Pepino')

insert into Proveedor values
(1, 'Panadería Carlitos', 'Carlos Calvo 1212', 'CABA'),
(2, 'Fiambres Perez', 'San Martin 121', 'Pergamino'),
(3, 'Almacen San Pedrito', 'San Pedrito 1244', 'CABA'),
(4, 'Carnicería Boedo', 'Av. Boedo 3232', 'CABA'),
(5, 'Verdulería Platense', '5 3232', 'La Plata'),
(6, 'Pizzeria Caro', 'Florencio Varela 123', 'La Matanza')
insert into Tiene values
--Juan Perez
(1, 1),
--Jose Basualdo
(2, 1),
(2, 2),
(2, 3),
(2, 4),
--Rogelio Rodriguez
(3, 3),
(3, 4)
insert into Compuesto_Por values
--Sandwich JyQ
(1, 1), (1, 2), (1, 3),
--Pancho
(2, 4), (2, 5),
--Hamburguesa
(3, 1), (3, 6),
--Hamburguesa completa
(4, 1), (4, 6), (4, 7), (4, 8),
--Hamburguesa REcompleta
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9) ,(5, 10)


insert into Provisto_Por values
--Pan
(1, 1), (1, 3),(1, 6),
--Jamon
(2, 2), (2, 3), (2, 4),(2, 6),
--Queso
(3, 2), (3, 3),(3, 6),
--Salchicha
(4, 3), (4, 4),(4, 6),
--Pan Pancho
(5, 1), (5, 3),(5, 6),
--Paty
(6, 3), (6, 4),(6, 6),
--Lechuga
(7, 3), (7, 5),(7, 6),
--Tomate
(8, 3), (8, 5),(8, 6),
--Papa
(9, 1),(9, 6),
--Pepino
(10, 5),(10, 6)

--EJERCICIOS

--1
select Nombre
from Proveedor
where Ciudad='La Plata' 

--2
select CodArt
from Articulo
where Precio<10

--3
select Responsable
from Almacen

--4
select CodMat
from Provisto_Por
where CodProv=3 and CodMat not in (select CodMat
								   from Provisto_Por
								   where CodProv=5)

--5
select Nro
from Tiene
where CodArt=1

--6
select CodProv
from Proveedor
where Ciudad='Pergamino' and Nombre like '% Perez'

--7
select Nro
from Almacen
where Nro in(select Nro
			 from Tiene
			 where CodArt=1) and Nro in(select Nro
										from Tiene
										where CodArt=2)

select Nro
from Tiene
where CodArt=1 and Nro in(select Nro
						  from Tiene
						  where CodArt=2)

--8
select CodArt
from Articulo
where Precio>100 or CodArt in(select CodArt
							  from Compuesto_Por
							  where CodMat=1)

select distinct A.CodArt /* distinct para que no devuelva repetidos porque devuelve lo filtrado de la tabla compuestos que tiene duplicados*/
from Articulo A join Compuesto_Por C on A.CodArt=C.CodArt /* Filtra por articulos en la tabla Compuesto_por */
where A.Precio>100 or C.CodMat=1 /* Pregunta en la tabla ya hecha por el joein */

--- ya de la nueva guia ---

--9


select distinct M.CodMat, Descripcion
from Material M join Provisto_Por P on M.CodMat=P.CodMat
where P.CodProv in (select CodProv
					from Proveedor
					where Ciudad='Pergamino')

--10

select Ar.CodArt, Ar.Descripcion, Ar.Precio
from Articulo Ar join Tiene T on Ar.CodArt=T.CodArt
where T.Nro=1

--11

select M.Descripcion
from Material M inner join Compuesto_por C on M.CodMat=C.CodMat
where C.CodArt=2

select Descripcion
from Material
where CodMat in(select CodMat
				from Compuesto_Por
				where CodArt=2)

--12

select distinct PP.Nombre
from Compuesto_Por C inner join Provisto_Por P on C.CodMat=P.CodMat
	 inner join Tiene T on T.CodArt=C.CodArt
	 inner join Proveedor PP on P.CodProv=PP.CodProv
where T.Nro=(select Nro
			 from Almacen
			 where Responsable='Rogelio Rodriguez')

select distinct P.Nombre
from Compuesto_Por C inner join Provisto_Por PP on C.CodMat=PP.CodMat
	 inner join Tiene T on T.CodArt=C.CodArt
	 inner join Proveedor P on PP.CodProv=P.CodProv
	 inner join Almacen A on A.Nro=T.Nro
where A.Responsable = 'Rogelio Rodriguez'

--13

select distinct A.CodArt, A.Descripcion --A.CodMat, A.Descripcion
from Compuesto_Por CP inner join Provisto_Por PP on CP.CodMat=PP.CodMat
	 inner join Proveedor P on P.CodProv=PP.CodProv
	 inner join Articulo A on A.CodArt=CP.CodArt
where P.Nombre like 'Fiambres Perez'

--14

select distinct PP.CodProv, P.Nombre
from Provisto_Por PP inner join Compuesto_Por CP on PP.CodMat=CP.CodMat
	 inner join Articulo A on A.CodArt=CP.CodArt
	 inner join Proveedor P on P.CodProv=PP.CodProv
where A.Precio<9

--15

select distinct T.Nro
from Tiene T inner join Compuesto_Por CP on T.CodArt=CP.CodArt
where CP.CodMat=1

--16

select P.Nombre
from Provisto_Por PP inner join (select PP.CodMat
					from Provisto_Por PP
					group by PP.CodMat
					having COUNT(PP.CodProv)=1) PPF on PP.CodMat=PPF.CodMat
					inner join Proveedor P on P.CodProv=PP.CodProv
where P.Ciudad='CABA'

--Correccion
SELECT P.Nombre
FROM Proveedor P
WHERE P.Ciudad = 'CABA' AND P.CodProv IN (SELECT PP.CodProv
										FROM Provisto_Por PP
										GROUP BY PP.CodProv
										HAVING COUNT(PP.CodMat) = 1)

--17
select A.Descripcion, A.Precio
from Articulo A
where A.Precio=(select MAX(A.Precio)
		from Articulo A)

--18
select A.Descripcion, A.Precio
from Articulo A
where A.Precio=(select MIN(A.Precio)
		from Articulo A)

--19
select T.Nro, Al.responsable, AVG(Ar.Precio)
from Tiene T inner join Articulo Ar on T.CodArt=Ar.CodArt
			 inner join Almacen Al on Al.Nro=T.Nro
group by T.Nro, Al.responsable

--Correccion
SELECT AVG(ART.Precio) as PromedioAlmacen, T.NroAlm AS NroAlmacen
FROM Articulo ART JOIN Tiene T ON T.CodArt= ART.CodArt
GROUP BY T.NroAlm

--20
select T.Nro NroAlmacen, COUNT(T.CodArt) CantidadArticulos
from Tiene T
group by T.Nro
having COUNT(T.CodArt)= (select MAX(CantArt.CantidadArticulos)
						 from (select T.Nro, COUNT(T.CodArt) CantidadArticulos
							   from Tiene T
		                       group by T.Nro) CantArt)

--21
select CP.CodArt, COUNT(CP.CodMat) CantidadDeMaterial
from Compuesto_Por CP
group by CP.CodArt
having COUNT(CP.CodMat) >= 2

--22
select CP.CodArt, COUNT(CP.CodMat) CantidadDeMaterial
from Compuesto_Por CP
group by CP.CodArt
having COUNT(CP.CodMat) = 2

--23
select CP.CodArt, COUNT(CP.CodMat) CantidadDeMaterial
from Compuesto_Por CP
group by CP.CodArt
having COUNT(CP.CodMat) <= 2

--24
select CP.CodArt, COUNT(CP.CodMat) CantidadDeMaterial
from Compuesto_Por CP
group by CP.CodArt
having COUNT(CP.CodMat) = (select COUNT(CodMat)
						   from Material)

--25

select P.Ciudad
from (select PP.CodProv, COUNT(PP.CodMat) CantidadDeMaterial
		from Provisto_Por PP
		group by PP.CodProv
		having COUNT(PP.CodMat) = (select COUNT(CodMat)
								   from Material)) PP
	inner join Proveedor P on PP.CodProv=P.CodProv
