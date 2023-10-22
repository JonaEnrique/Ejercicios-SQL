--BASE DE DATOS

create database ejercicio1

--TABLAS

create table Almacen(Nro int primary key, Responsable varchar(50))
create table Articulo(CodArt int primary key, Descripcion varchar(50), Precio decimal(12, 3))
create table Material(CodMat int primary key, Descripcion varchar(50))
create table Proveedor(CodProv int primary key, Nombre varchar(50), Domicilio varchar(50), Ciudad varchar(50))
create table Tiene(Nro int, CodArt int, constraint pktiene primary key(Nro, CodArt),
										constraint fktiealmacen foreign key(Nro) references Almacen(Nro),
										constraint fktiearticulo foreign key(CodArt) references Articulo(CodArt))
create table Compuesto_Por(CodArt int, CodMat int)
create table Provisto_Por(CodMat int, CodProv int)

--DATOS

insert into Almacen values
(1, 'Juan Perez'),
(2, 'Jose Basualdo'),
(3, 'Rogelio Rodriguez')
insert into Articulo values
(1, 'Sandwich JyQ', 5),
(2, 'Pancho', 6),
(3, 'Hamburguesa', 10),
(4, 'Hamburguesa completa', 15)
insert into Material values
(1, 'Pan'),
(2, 'Jamon'),
(3, 'Queso'),
(4, 'Salchicha'),
(5, 'Pan Pancho'),
(6, 'Paty'),
(7, 'Lechuga'),
(8, 'Tomate')
insert into Proveedor values
(1, 'Panadería Carlitos', 'Carlos Calvo 1212', 'CABA'),
(2, 'Fiambres Perez', 'San Martin 121', 'Pergamino'),
(3, 'Almacen San Pedrito', 'San Pedrito 1244', 'CABA'),
(4, 'Carnicería Boedo', 'Av. Boedo 3232', 'CABA'),
(5, 'Verdulería Platense', '5 3232', 'La Plata')
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
(4, 1), (4, 6), (4, 7), (4, 8)
insert into Provisto_Por values
--Pan
(1, 1), (1, 3),
--Jamon
(2, 2), (2, 3), (2, 4),
--Queso
(3, 2), (3, 3),
--Salchicha
(4, 3), (4, 4),
--Pan Pancho
(5, 1), (5, 3),
--Paty
(6, 3), (6, 4),
--Lechuga
(7, 3), (7, 5),
--Tomate
(8, 3), (8, 5)

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

select CodArt, Descripcion, Precio
from Articulo

select CodMat, Descripcion
from Material

select CodArt, CodMat
from Compuesto_Por

select M.Descripcion
from Material M inner join Compuesto_por C on M.CodMat=C.CodMat
where C.CodArt=2

select Descripcion
from Material
where CodMat in(select CodMat
				from Compuesto_Por
				where CodArt=2)

select Descripcion
from Material
where CodMat in(select CodMat
				from Compuesto_Por
				where CodArt=2)

--prueba