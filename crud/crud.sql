------* Inserción de tuplas -------
insert into categorias (categoriaid, nombrecat) values (100, 'CARNICOS');
insert into categorias (categoriaid, nombrecat) values (200, 'LACTEOS');
insert into categorias (categoriaid, nombrecat) values (300, 'LIMPIEZA');
insert into categorias (categoriaid, nombrecat) values (400, 'HIGINE PERSONAL');
insert into categorias (categoriaid, nombrecat) values (500, 'MEDICINAS');
insert into categorias (categoriaid, nombrecat) values (600, 'COSMETICOS');
insert into categorias (categoriaid, nombrecat) values (700, 'REVISTAS');



insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(10, 'DON DIEGO', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(20, 'PRONACA', 'JUAN PEREZ', '0923434467','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(30, 'TONY', 'JORGE BRITO', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(40, 'MIRAFLORES', 'MARIA PAZ', '098124498','2458799');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(50, 'ALMAY', 'PEDRO GONZALEZ', '097654567','2507190');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(60, 'REVLON', 'MONICA SALAS', '099245678','2609876');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(70, 'YANBAL', 'BETY ARIAS', '098124458','2450887');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(120, 'JURIS', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(80, 'CLEANER', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(90, 'BAYER', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(110, 'PALMOLIVE', 'MANUEL ANDRADE', '099234567','2124456');


INSERT INTO PRODUCTOS VALUES (1,10,100,'SALCHICHAS VIENESAS',2.60,200);
INSERT INTO PRODUCTOS VALUES (2,10,100,'SALAMI DE AJO',3.60,300);
INSERT INTO PRODUCTOS VALUES (3,10,100,'BOTON PARA ASADO',4.70,400);
INSERT INTO PRODUCTOS VALUES (4,20,100,'SALCHICHAS DE POLLO',2.90,200);
INSERT INTO PRODUCTOS VALUES (5,20,100,'JAMON DE POLLO',2.80,100);
INSERT INTO PRODUCTOS VALUES (6,30,200,'YOGURT NATURAL',4.30,80);
INSERT INTO PRODUCTOS VALUES (7,30,200,'LECHE CHOCOLATE',1.60,90);
INSERT INTO PRODUCTOS VALUES (8,40,200,'YOGURT DE SABORES',1.60,200);
INSERT INTO PRODUCTOS VALUES (9,40,200,'CREMA DE LECHE',3.60,30);
INSERT INTO PRODUCTOS VALUES (10,50,600,'BASE DE MAQUILLAJE',14.70,40);
INSERT INTO PRODUCTOS VALUES (11,50,600,'RIMMEL',12.90,20);
INSERT INTO PRODUCTOS VALUES (13,60,600,'SOMBRA DE OJOS',9.80,100);

INSERT INTO EMPLEADOS VALUES (1, 'JUAN', 'CRUZ', TO_DATE('18-01-1967', 'DD-MM-YYYY'), NULL, 231);
INSERT INTO EMPLEADOS VALUES (2, 'MARIO', 'SANCHEZ', TO_DATE('01-MAR-1979', 'DD-MON-YYYY'), 1, 144);
INSERT INTO EMPLEADOS VALUES (3, 'VERONICA', 'ARIAS', TO_DATE('23-JUN-1977', 'DD-MON-YYYY'), 1, 234);
INSERT INTO EMPLEADOS VALUES (4, 'PABLO', 'CELY', TO_DATE('28-JAN-1977', 'DD-MON-YYYY'), 2, 567);
INSERT INTO EMPLEADOS VALUES (5, 'DIEGO', 'ANDRADE', TO_DATE('15-MAY-1970', 'DD-MON-YYYY'), 2, 890);
INSERT INTO EMPLEADOS VALUES (6, 'JUAN', 'ANDRADE', TO_DATE('17-NOV-1976', 'DD-MON-YYYY'), 3, 230);
INSERT INTO EMPLEADOS VALUES (7, 'MARIA', 'NOBOA', TO_DATE('21-DEC-1979', 'DD-MON-YYYY'), 3, 261);


insert into paises values (1, 'Ecuador');

insert into regiones values (1, 'R_Costa');
insert into regiones values (2, 'R_Sierra');
insert into regiones values (3, 'R_Oriente');

INSERT INTO provincias VALUES (1, 'Los Rios', 1, 1);
INSERT INTO provincias VALUES (2, 'Manabi', 1, 1);
INSERT INTO provincias VALUES (3, 'Bolivar', 2, 1);
INSERT INTO provincias VALUES (4, 'Santa Elena', 1, 1);
INSERT INTO provincias VALUES (5,'Esmeraldas', 1, 1);
INSERT INTO provincias VALUES (6, 'Guayas', 1, 1);
INSERT INTO provincias VALUES (7, 'Imbabura', 2, 1);
INSERT INTO provincias VALUES (8, 'Pichincha', 2, 1);
INSERT INTO provincias VALUES (9, 'El Oro', 1, 1);
INSERT INTO provincias VALUES (10, 'Cotopaxi', 2, 1);
INSERT INTO provincias VALUES (11, 'Carchi', 2, 1);
INSERT INTO provincias VALUES (12, 'Chimborazo', 2, 1);
INSERT INTO provincias VALUES (13, 'Sucumbios', 3, 1);
INSERT INTO provincias VALUES (14, 'Tungurahua', 2, 1);
INSERT INTO provincias VALUES (15, 'Canar', 2, 1);
INSERT INTO provincias VALUES (16, 'Loja', 2, 1);
INSERT INTO provincias VALUES (17, 'Morona Santiago', 3, 1);
INSERT INTO provincias VALUES (18, 'Pastaza', 3, 1);
INSERT INTO provincias VALUES (19, 'Azuay', 2, 1);
INSERT INTO provincias VALUES (20, 'Orellana', 3, 1);
INSERT INTO provincias VALUES (21, 'Zamora Chinchipe', 3, 1);
INSERT INTO provincias VALUES (22, 'Napo', 3, 1);

INSERT INTO CLIENTES VALUES (1, '1298765477', 'EL ROSADO', 'MARIA CORDERO', 'AV.EL INCA', NULL, NULL, NULL, NULL,1);
INSERT INTO CLIENTES VALUES (2, '1298765477', 'EL ROSADO', 'MARIA CORDERO', 'AV.EL INCA', NULL, NULL, NULL, NULL,12);
INSERT INTO CLIENTES VALUES (3, '1009876567', 'DISTRIBUIDORA PRENSA', 'PEDRO PINTO', 'EL PINAR', NULL, NULL, NULL, NULL,17);
INSERT INTO CLIENTES VALUES (4, '1876090006', 'SU TIENDA', 'PABLO PONCE', 'AV.AMAZONAS', NULL, NULL, NULL, NULL,8);
INSERT INTO CLIENTES VALUES (5, '1893456776', 'SUPERMERCADO DORADO', 'LORENA PAZ', 'AV.6 DICIEMBRE', NULL, NULL, NULL, NULL,3);
INSERT INTO CLIENTES VALUES (6, '1678999891', 'MI COMISARIATO', 'ROSARIO UTRERAS', 'AV.AMAZONAS', NULL, NULL, NULL, NULL,5);
INSERT INTO CLIENTES VALUES (7, '1244567888', 'SUPERMERCADO DESCUENTO', 'LETICIA ORTEGA', 'AV.LA PRENSA', NULL, NULL, NULL, NULL,8);
INSERT INTO CLIENTES VALUES (8, '1456799022', 'EL DESCUENTO', 'JUAN TORRES', 'AV.PATRIA', NULL, NULL, NULL, NULL,3);
INSERT INTO CLIENTES VALUES (9, '1845677777', 'DE LUISE', 'JORGE PARRA', 'AV.AMAZONAS', NULL, NULL, NULL, NULL,15);
INSERT INTO CLIENTES VALUES (10, '183445667', 'YARBANTRELLA', 'PABLO POLIT', 'AV.REPUBLICA', NULL, NULL, NULL, NULL,12);




INSERT INTO ORDENES VALUES(1,3,4,TO_DATE('17-jun-07', 'DD-MON-YYYY'), 5);
INSERT INTO ORDENES VALUES(2,3,4,TO_DATE('02-jun-07', 'DD-MON-YYYY'), 10);
INSERT INTO ORDENES VALUES(3,4,5,TO_DATE('05-jun-07', 'DD-MON-YYYY'), 6);
INSERT INTO ORDENES VALUES(4,2,6,TO_DATE('06-jun-07', 'DD-MON-YYYY'), 2);
INSERT INTO ORDENES VALUES(5,2,7,TO_DATE('09-jun-07', 'DD-MON-YYYY'), NULL);
INSERT INTO ORDENES VALUES(6,4,5,TO_DATE('12-jun-07', 'DD-MON-YYYY'), 10);
INSERT INTO ORDENES VALUES(7,2,5,TO_DATE('14-jun-07', 'DD-MON-YYYY'), 10);
INSERT INTO ORDENES VALUES(8,3,2,TO_DATE('13-jun-07', 'DD-MON-YYYY'), 10);
INSERT INTO ORDENES VALUES(9,3,2,TO_DATE('17-jun-07', 'DD-MON-YYYY'), 3);
INSERT INTO ORDENES VALUES(10,2,2,TO_DATE('18-jun-07', 'DD-MON-YYYY'), 2);

insert into detalle_ordenes values(1,1,1,2);
insert into detalle_ordenes values(1,2,4,1);
insert into detalle_ordenes values(1,3,6,1);
insert into detalle_ordenes values(1,4,9,1);

insert into detalle_ordenes values(2,1,10,10);
insert into detalle_ordenes values(2,2,13,20);
insert into detalle_ordenes values(3,1,3,10);
insert into detalle_ordenes values(4,1,9,12);

insert into detalle_ordenes values(5,1,1,14);
insert into detalle_ordenes values(5,2,4,20);
insert into detalle_ordenes values(6,1,3,12);
insert into detalle_ordenes values(7,1,11,10);

insert into detalle_ordenes values(8,1,2,10);
insert into detalle_ordenes values(8,2,5,14);
insert into detalle_ordenes values(8,3,7,10);
insert into detalle_ordenes values(9,1,11,10);

insert into detalle_ordenes values(10,1,1,5);

COMMIT;

----------------------------------------------------------------------------------------------------
----- Llenado de la tabla clientes con provincias usando cursores

DECLARE
    CURSOR clientes_cur IS
        SELECT clienteid FROM clientes;
    
    c_id clientes.clienteid%TYPE;
    pointer number := 1;
    
BEGIN

    OPEN clientes_cur;
    
    LOOP
        FETCH clientes_cur INTO c_id;
    
        EXIT WHEN clientes_cur%NOTFOUND;
        
        if pointer < 20 then 
            pointer := pointer + 1;
        else
            pointer := 1;
        end if;
        update clientes
        set provinciaid = pointer
        where clienteid = c_id;
        
     END LOOP;
     
     CLOSE clientes_cur;
END;


--- Llenado de la tabla clientes con provincias usando cursores

DECLARE
    CURSOR clientes_cur IS
        SELECT clienteid FROM clientes;
    
    c_id clientes.clienteid%TYPE;
    pointer number := 1;
    
BEGIN

    OPEN clientes_cur;
    
    LOOP
        FETCH clientes_cur INTO c_id;
    
        EXIT WHEN clientes_cur%NOTFOUND;
        
        if pointer < 20 then 
            pointer := pointer + 1;
        else
            pointer := 1;
        end if;
        update clientes
        set provinciaid = pointer
        where clienteid = c_id;
        
     END LOOP;
     
     CLOSE clientes_cur;
END;