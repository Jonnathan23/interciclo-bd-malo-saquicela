-- Crear tabla metodo
CREATE TABLE metodo (
    metodoid NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);


create table regiones (
    regionid int not null,
    nombreregion varchar2(50) not null,
    constraint PK_REGIONES primary key (regionid)
);

create table paises (
    paisid int not null,
    nombrepais varchar2(50) not null,
    constraint PK_PAISES primary key (paisid)
);

create table provincias (
    provinciaid int not null,
    nombreprovincia varchar2(50) not null,
    regionid int not null,
    paisid int not null,
    constraint PK_PROVINCIAS primary key (provinciaid),
    constraint FK_PROVINCIAS_REGIONES foreign key (regionid) references regiones (regionid),
    constraint FK_PROVINCIAS_PAISES foreign key (paisid) references paises (paisid)
);

create table DIM_temporal(
    fechaid int,
    fechaorden date,
    constraint PK_DIM_TEMPORAL primary key (fechaid)
);


create table DIM_proveedores (
    proveedorid int,
    nombreprov varchar2(50),
    constraint PK_DIM_PROVEEDORES primary key (proveedorid)
);

create table DIM_clientes (
    clienteid int,
    nombrecontacto varchar2(50),
    constraint PK_DIM_CLIENTES primary key (clienteid)
);

create table SDIM_regiones (
    regionid int,
    nombreregion varchar2(50),
    constraint PK_SDIM_REGIONES primary key (regionid)
);

create table SDIM_paises (
    paisid int,
    nombreregion varchar2(50),
    constraint PK_SDIM_PAISES primary key (paisid)
);

create table DIM_ubicaciones (
    provinciaid int,
    nombreprovincia varchar2(50),
    paisid int,
    regionid int,
    constraint PK_DIM_PROVINCIAS primary key (provinciaid),
    constraint FK_SDIM_REGIONES_UBIC foreign key (regionid) references SDIM_regiones (regionid),
    constraint FK_SDIM_PAISES_UBIC foreign key (paisid) references SDIM_paises (paisid)
);


create table  TH_productos (
    productoid int,
    descripcion varchar2(50),
    fechaid int,
    proveedorid int,
    clienteid int,
    provinciaid int,
    total_ventas number(7,2),
    constraint FK_TH_DIM_TEM foreign key (fechaid) references dim_temporal (fechaid),
    constraint FK_TH_DIM_PROV foreign key (proveedorid) references dim_proveedores (proveedorid),
    constraint FK_TH_DIM_CLI foreign key (clienteid) references dim_clientes (clienteid),
    constraint FK_TH_DIM_UBI foreign key (provinciaid) references dim_ubicaciones (provinciaid)
);

commit;
-----------------------------------------------------------
---- Modificacion de la tabla Clientes --------------
alter table clientes 
add provinciaid int;   

alter table clientes add 
constraint FK_PROVINCIAS_CLIENTES foreign key (provinciaid) references provincias (provinciaid);

ALTER TABLE clientes 
ADD (metodoid NUMBER, meses NUMBER DEFAULT 0);

ALTER TABLE clientes
ADD CONSTRAINT FK_METODO_CLIENTES FOREIGN KEY (metodoid) REFERENCES metodo (metodoid);

-- Modificacion de la tabla proveedores
SELECT * FROM proveedores;

alter table proveedores 
add
provinciaid int ;   

alter table proveedores
add 
constraint FK_PROVINCIAS_PROVEEDORES foreign key (provinciaid) references provincias (provinciaid);

ALTER TABLE proveedores 
ADD (metodoid NUMBER,meses NUMBER DEFAULT 0);

ALTER TABLE proveedores
ADD CONSTRAINT FK_METODO_PROVEEDORES FOREIGN KEY (metodoid) REFERENCES metodo (metodoid);

COMMIT;

DESCRIBE proveedores;


select proveedorid FROM proveedores WHERE NOMBREPROV = 'Abbott, MacGyver and Kemmer';

select NOMBREPROV from PROVEEDORES where proveedorid = 11007;

select * from proveedores where proveedorid = 11007;

UPDATE proveedores
SET provinciaid = 24
WHERE PROVEEDORID = 11007;

commit;

select * from provincias;



-- Tablas DIM dependientes
DROP TABLE TH_productos CASCADE CONSTRAINTS; -- Primero elimina la tabla de hechos ya que depende de DIM

-- Tablas DIM relacionadas
DROP TABLE DIM_ubicaciones CASCADE CONSTRAINTS;
DROP TABLE DIM_proveedores CASCADE CONSTRAINTS;
DROP TABLE DIM_clientes CASCADE CONSTRAINTS;
DROP TABLE DIM_temporal CASCADE CONSTRAINTS;


DROP TABLE SDIM_paises CASCADE CONSTRAINTS;
DROP TABLE SDIM_regiones CASCADE CONSTRAINTS;


COMMIT;

