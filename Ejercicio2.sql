create database ejercicio2
drop database ejercicio2

create table Proveedor(NroProv int primary key, NomProv varchar(50), Categoria int, CiudadProv varchar(50))
create table Articulo(NroArt int primary key, Descripcion varchar(60), CiudadArt varchar(50), Precio float)
create table Cliente(NroCli int primary key, NomCli varchar(50), CiudadCli varchar(50))
create table Pedido(NroPed int, NroArt int, NroCli int,NroProv int, FechaPedido date,
					Cantidad int, PrecioTotal float,
					constraint pkNroPed primary key(NroPed),
					constraint fkNroArtP foreign key(NroArt) references Articulo(NroArt),
					constraint fkNroCli foreign key(NroCli) references Cliente(NroCli),
					constraint fkNroProv foreign key(NroProv) references Proveedor(NroProv),
					)
create table Stock(NroArt int, Fecha date, Cantidad int,
					constraint pkNroArtS primary key(NroArt, Fecha),
					constraint fkNroArt foreign key(NroArt) references Articulo(NroArt))


-- Insert data into Proveedor table
INSERT INTO Proveedor(NroProv, NomProv, Categoria, CiudadProv) VALUES
(1, 'Proveedor A', 4, 'New York'),
(2, 'Proveedor B', 5, 'Los Angeles'),
(3, 'Proveedor C', 1, 'Chicago');

-- Insert data into Articulo table
INSERT INTO Articulo(NroArt, Descripcion, CiudadArt, Precio) VALUES
(101, 'Laptop Model X', 'New York', 800.50),
(102, 'T-Shirt Red', 'Los Angeles', 20.30),
(103, 'Organic Apple Pack', 'Chicago', 5.00);

-- Insert data into Cliente table
INSERT INTO Cliente(NroCli, NomCli, CiudadCli) VALUES
(501, 'Alice', 'Boston'),
(502, 'Bob', 'San Francisco'),
(503, 'Charlie', 'Dallas');

-- Insert data into Pedido table
INSERT INTO Pedido(NroPed, NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal) VALUES
(1001, 101, 501, 1, '2023-10-01', 1, 800.50),
(1002, 102, 502, 2, '2023-10-05', 3, 60.90),  -- 3 T-Shirts at 20.30 each
(1003, 103, 503, 3, '2023-10-10', 10, 50.00), -- 10 apple packs at 5.00 each
(1004, 103, 503, 3, '2023-10-10', 10, 50.00),
(1005, 103, 503, 3, '2023-10-10', 10, 50.00),
(1006, 103, 501, 1, '2023-10-10', 10, 50.00),
(1007, 101, 501, 1, '2023-10-01', 1, 900.50);
-- Insert data into Stock table
INSERT INTO Stock(NroArt, Fecha, Cantidad) VALUES
(101, '2023-09-30', 100),  -- 100 Laptops in stock on September 30
(102, '2023-09-30', 200),  -- 200 T-Shirts in stock on September 30
(103, '2023-09-30', 500);  -- 500 apple packs in stock on September 30


--EJERCICIOS

--1
select NroProv, NroArt
from Pedido
group by NroProv, NroArt
having NroArt=103

--2
select NroCli
from Pedido
group by NroCli, NroProv
having NroProv=1

--3
select Pe.NroCli, C.NomCli
from Pedido Pe inner join Proveedor Pr on Pe.NroProv=Pr.NroProv
			inner join Cliente C on C.NroCli=Pe.NroCli
group by Pe.NroCli, C.NomCli, Pe.NroProv, Pr.Categoria
having Pr.Categoria > 4

select Pe.NroCli, C.NomCli
from Pedido Pe inner join Proveedor Pr on Pe.NroProv=Pr.NroProv and Pr.Categoria > 4
			inner join Cliente C on C.NroCli=Pe.NroCli
group by Pe.NroCli, C.NomCli, Pe.NroProv, Pr.Categoria

--4
select P.NroPed, C.CiudadCli, Pr.CiudadProv
from Pedido P inner join Cliente C on (P.NroCli=C.NroCli)
			  inner join Proveedor Pr on (P.NroProv=Pr.NroProv)
where C.CiudadCli='Dallas' and Pr.CiudadProv='Chicago'

--5
select NroPed
from Pedido
where NroCli=501 and NroArt in(select distinct P.NroArt
							   from Pedido P
							   where P.NroCli=503)


select distinct P.NroPed
from Pedido P inner join (select NroArt, NroCli 
					      from Pedido
						  where NroCli=503) PP on P.NroArt=PP.NroARt AND P.NroCli=501

--6
select P.NroProv
from Pedido P inner join Articulo A on P.NroArt=A.NroArt
where A.Precio > (select AVG(A.Precio)
			      from Articulo A
				  where A.CiudadArt='Los Angeles')

--7

select P.NroProv, COUNT(P.NroArt) CantArtDif, P.CiudadCli
from (select P.NroProv, P.NroArt, C.CiudadCli
	  from Pedido P inner join Cliente C on P.NroCli=C.NroCli
	  group by P.NroProv, P.NroArt, C.CiudadCli) P
where P.CiudadCli='San Francisco'
group by P.NroProv, P.CiudadCli



