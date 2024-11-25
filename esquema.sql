CREATE TABLE EMPLEADOS(
    EMPLEADOID int NOT NULL,
    NOMBRE char(30) NULL,
    APELLIDO char(30) NULL,
    FECHA_NAC date NULL,
    REPORTA_A int NULL,
    EXTENSION int NULL,
    CONSTRAINT PK_EMPLEADOS PRIMARY KEY (EMPLEADOID),
    CONSTRAINT FK_EMPLEADO_REPORTA FOREIGN KEY (REPORTA_A) REFERENCES EMPLEADOS(EMPLEADOID)
);


CREATE TABLE PROVEEDORES(
    PROVEEDORID int NOT NULL,
    NOMBREPROV char(50) NOT NULL,
    CONTACTO char(50) NOT NULL,
    CELUPROV char(12) NULL,
    FIJOPROV char(12) NULL,
    CONSTRAINT PK_PROVEEDORES PRIMARY KEY (PROVEEDORID )
 );
 
 CREATE TABLE CATEGORIAS(
    CATEGORIAID int NOT NULL,
    NOMBRECAT char(50) NOT NULL,
    CONSTRAINT PK_CATEGORIAS PRIMARY KEY (CATEGORIAID)
);

CREATE TABLE CLIENTES(
    CLIENTEID int NOT NULL,
    CEDULA_RUC char(10) NOT NULL,
    NOMBRECIA char(30) NOT NULL,
    NOMBRECONTACTO char(50) NOT NULL,
    DIRECCIONCLI char(50) NOT NULL,
    FAX char(12) NULL,
    EMAIL char(50) NULL,
    CELULAR char(12) NULL,
    FIJO char(12) NULL,
    CONSTRAINT PK_CLIENTES PRIMARY KEY(CLIENTEID)
);


CREATE TABLE ORDENES(
    ORDENID int NOT NULL,
    EMPLEADOID int NOT NULL,
    CLIENTEID int NOT NULL,
    FECHAORDEN date NOT NULL,
    DESCUENTO int NULL,
    CONSTRAINT PK_ORDENES PRIMARY KEY(ORDENID),
    CONSTRAINT FK_ORDENES_CLIEN_ORD_CLIENTES FOREIGN KEY (CLIENTEID) REFERENCES CLIENTES(CLIENTEID),
    CONSTRAINT FK_ORDENES_EMPLE_ORD_EMPLEADO FOREIGN KEY (EMPLEADOID) REFERENCES EMPLEADOS(EMPLEADOID)
);

CREATE TABLE PRODUCTOS(
    PRODUCTOID int NOT NULL,
    PROVEEDORID int NOT NULL,
    CATEGORIAID int NOT NULL,
    DESCRIPCION char(50) NULL,
    PRECIOUNIT number NOT NULL,
    EXISTENCIA int NOT NULL,
    CONSTRAINT PK_PRODUCTOS PRIMARY KEY(PRODUCTOID),
    CONSTRAINT FK_PRODUCTO_CATE_PROD_CATEGORI FOREIGN KEY (CATEGORIAID) REFERENCES CATEGORIAS(CATEGORIAID),
    CONSTRAINT FK_PRODUCTO_PROV_PROD_PROVEEDO FOREIGN KEY (PROVEEDORID) REFERENCES PROVEEDORES(PROVEEDORID)
);

CREATE TABLE DETALLE_ORDENES(
    ORDENID int NOT NULL,
    DETALLEID int NOT NULL,
    PRODUCTOID int NOT NULL,
    CANTIDAD int NOT NULL,
    CONSTRAINT PK_DETALLE_ORDENES PRIMARY KEY (ORDENID,DETALLEID ),
    CONSTRAINT FK_DETALLE__ORDEN_DET_ORDENES FOREIGN KEY (ORDENID) REFERENCES ORDENES(ORDENID),
    CONSTRAINT FK_DETALLE__PROD_DETA_PRODUCTO FOREIGN KEY (PRODUCTOID) REFERENCES PRODUCTOS(PRODUCTOID)
 );


------* Tablas extras añadidas ------
create table provincias (
    provinciaid int not null,
    nombreprovincia varchar2(50) not null,
    regionid int not null,
    paisid int not null,
    constraint PK_PROVINCIAS primary key (provinciaid),
    constraint FK_PROVINCIAS_REGIONES foreign key (regionid) references regiones (regionid),
    constraint FK_PROVINCIAS_PAISES foreign key (paisid) references paises (paisid)
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

----!
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
----!

-----------------------------------------------------------
---- Alterar tablas --------------
alter table clientes 
add
provinciaid int ;   

alter table clientes
add 
constraint FK_PROVINCIAS_CLIENTES foreign key (provinciaid) references provincias (provinciaid);

set SERVEROUTPUT on;