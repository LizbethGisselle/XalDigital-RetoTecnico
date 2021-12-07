create database vuelos; /*crear base de datos*/

use vuelos;/*usar base de datos*/

/*creación de tablas */

create table AEROLINEAS(id_aerolinea int not null,nombre_aerolinea varchar(30),primary key (id_aerolinea));
create table AEROPUERTOS(id_aeropuerto int not null, nombre_aeropuerto varchar(35),primary key(id_aeropuerto));
create table MOVIMIENTOS(id_movimiento int not null, descripcion varchar (30),primary key (id_movimiento));
create table VUELOS (id_aerolinea int not null,id_aeropuerto int not null,id_movimiento int not null,dia date);

/* añadir campos foraneos*/
alter table VUELOS add foreign key (id_aerolinea) references AEROLINEAS(id_aerolinea);
alter table VUELOS add foreign key (id_aeropuerto) references AEROPUERTOS(id_aeropuerto);
alter table VUELOS add foreign key (id_movimiento) references MOVIMIENTOS(id_movimiento);

/* insertar en tabla aerolineas */
insert into AEROLINEAS values(1,'Volaris');
insert into AEROLINEAS values(2,'Aeromar');
insert into AEROLINEAS values(3,'Interjet');
insert into AEROLINEAS values(4,'Aeromexico');

/* insertar en tabla aeropuertos */
insert into AEROPUERTOS values(1,'Benito Juarez');
insert into AEROPUERTOS values(2,'Guanajuato');
insert into AEROPUERTOS values(3,'La paz');
insert into AEROPUERTOS values(4,'Oaxaca');

/* insertar en tabla movimientos */
insert into MOVIMIENTOS values(1,'Salida');
insert into MOVIMIENTOS values(2,'Llegada');

/* insertar en tabla vuelos */
insert into VUELOS values(1,1,1,'2021-05-02');
insert into VUELOS values(2,1,1,'2021-05-02');
insert into VUELOS values(3,2,2,'2021-05-02');
insert into VUELOS values(4,3,2,'2021-05-02');
insert into VUELOS values(1,3,2,'2021-05-02');
insert into VUELOS values(2,1,1,'2021-05-02');
insert into VUELOS values(2,3,1,'2021-05-04');
insert into VUELOS values(3,4,1,'2021-05-04');
insert into VUELOS values(3,4,1,'2021-05-04');

/* Respuesta a las preguntas del reto con consultas ! */

/*1. ¿Cuál es el nombre aeropuerto que ha tenido mayor movimiento durante el año? */

select nombre_aeropuerto 
from (select nombre_aeropuerto, count(id_aeropuerto)  contador
	 from vuelos natural join aeropuertos 
	 group by id_aeropuerto) AS T1
where contador in (select max(contador)
		from (select id_aeropuerto,count(id_aeropuerto) contador 			
        from vuelos natural join aeropuertos
			group by id_aeropuerto) AS T2);

/*2. ¿Cuál es el nombre aerolínea que ha realizado mayor número de vuelos durante el año?*/

select nombre_aerolinea 
from (select nombre_aerolinea, count(id_aerolinea) contador
	 from vuelos natural join aerolineas 
	 group by id_aerolinea) AS T1
where contador in (select max(contador)
		from (select id_aerolinea,count(id_aerolinea) contador 			
        from vuelos natural join aerolineas
			group by id_aerolinea) AS T2);
            
/*3. ¿En qué día se han tenido mayor número de vuelos?*/

select dia from (select dia,count(dia) contador
from vuelos group by dia) AS T1
 where contador in (select max(contador) from 
(select dia, count(dia) contador from vuelos group by dia) AS T2);

/*4. ¿Cuáles son las aerolíneas que tienen mas de 2 vuelos por día? */

Select nombre_aerolinea From vuelos natural join aerolineas Group By nombre_aerolinea, dia 
Having count(*) > 2;

/*NOTA:La consulta nùmero 4 no arroja ningun resultado dado que por los datos proporcionados por el reto,no existe ningun aerolinea que realice más de dos vuelos por día por tanto la consulta arroja cero resultados*/


