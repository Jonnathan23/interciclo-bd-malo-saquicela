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


insert into paises values (1, 'Ecuador');

insert into regiones values (1, 'R_Costa');
insert into regiones values (2, 'R_Sierra');
insert into regiones values (3, 'R_Oriente');

INSERT INTO provincias VALUES (1,'Esmeraldas', 1, 1);
INSERT INTO provincias VALUES (2, 'Manab�', 1, 1);
INSERT INTO provincias VALUES (3, 'Los R�os', 1, 1);
INSERT INTO provincias VALUES (4, 'Santa Elena', 1, 1);
INSERT INTO provincias VALUES (5, 'Guayas', 1, 1);
INSERT INTO provincias VALUES (6, 'El Oro', 1, 1);
INSERT INTO provincias VALUES (7, 'Carchi', 2, 1);
INSERT INTO provincias VALUES (8, 'Imbabura', 2, 1);
INSERT INTO provincias VALUES (9, 'Pichincha', 2, 1);
INSERT INTO provincias VALUES (10, 'Cotopaxi', 2, 1);
INSERT INTO provincias VALUES (11, 'Tungurahua', 2, 1);
INSERT INTO provincias VALUES (12, 'Bol�var', 2, 1);
INSERT INTO provincias VALUES (13, 'Chimborazo', 2, 1);
INSERT INTO provincias VALUES (14, 'Ca�ar', 2, 1);
INSERT INTO provincias VALUES (15, 'Azuay', 2, 1);
INSERT INTO provincias VALUES (16, 'Loja', 2, 1);
INSERT INTO provincias VALUES (17, 'Sucumb�os', 3, 1);
INSERT INTO provincias VALUES (18, 'Napo', 3, 1);
INSERT INTO provincias VALUES (19, 'Orellana', 3, 1);
INSERT INTO provincias VALUES (20, 'Pastaza', 3, 1);
INSERT INTO provincias VALUES (21, 'Morona Santiago', 3, 1);
INSERT INTO provincias VALUES (22, 'Zamora Chinchipe', 3, 1);

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
