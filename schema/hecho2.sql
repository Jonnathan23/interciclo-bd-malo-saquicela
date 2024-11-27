drop table HECHO_PROVEEDOR;

CREATE TABLE HECHO_PROVEEDOR (
    proveedorid INT NOT NULL,
    producto_id INT NOT NULL,
    fechaid INT NOT NULL,
    provinciaid INT NOT NULL,
    total_ventas NUMBER(10, 2) NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    constraint FK_HP_DIM_PROV foreign key (proveedorid) references DIM_proveedores (proveedorid),
    constraint FK_HP_DIM_TEMP foreign key (fechaid) references DIM_temporal (fechaid),
    constraint FK_HP_DIM_UBI foreign key (provinciaid) references DIM_ubicaciones (provinciaid)
);


COMMIT;

DECLARE
    CURSOR fact_prov_cursor IS
        SELECT p.proveedorid, 
               do.productoid, 
               o.fechaorden, 
               c.provinciaid, 
               SUM(do.cantidad) AS total_cantidad, 
               SUM(do.cantidad * p.preciounit) AS total_ventas
        FROM detalle_ordenes do
        JOIN productos p ON do.productoid = p.productoid
        JOIN ordenes o ON do.ordenid = o.ordenid
        JOIN clientes c ON o.clienteid = c.clienteid
        GROUP BY p.proveedorid, do.productoid, o.fechaorden, c.provinciaid;

    prov_id INT;
    prod_id INT;
    fecha DATE;
    prov_loc INT;
    total_v NUMBER(10, 2);
    cantidad NUMERIC(10);

BEGIN
    OPEN fact_prov_cursor;

    LOOP
        FETCH fact_prov_cursor INTO prov_id, prod_id, fecha, prov_loc, cantidad, total_v;
        EXIT WHEN fact_prov_cursor%NOTFOUND;

        INSERT INTO HECHO_PROVEEDOR (proveedorid, producto_id, fechaid, provinciaid, cantidad, total_ventas)
        VALUES (
            prov_id, 
            prod_id, 
            (SELECT fechaid FROM DIM_temporal WHERE fechaorden = fecha), 
            prov_loc, 
            cantidad, 
            total_v
        );
    END LOOP;

    CLOSE fact_prov_cursor;
END;

SELECT COUNT(*) AS total_registros FROM HECHO_PROVEEDOR;
SELECT * FROM HECHO_PROVEEDOR FETCH FIRST 10 ROWS ONLY;

SELECT * FROM DIM_temporal WHERE fechaid IN (SELECT DISTINCT fechaid FROM HECHO_PROVEEDOR);

SELECT proveedorid, 
       SUM(total_ventas) AS Total_Pagado
FROM HECHO_PROVEEDOR
GROUP BY proveedorid
ORDER BY Total_Pagado DESC;


SELECT * 
FROM HECHO_PROVEEDOR
ORDER BY total_ventas DESC
FETCH FIRST 10 ROWS ONLY;

SELECT 
    dp.nombreprov AS Proveedor,
    p.descripcion AS Producto,
    dt.fechaorden AS Fecha,
    du.nombreprovincia AS Provincia,
    hp.cantidad AS Cantidad,
    hp.total_ventas AS Total_Ventas
FROM HECHO_PROVEEDOR hp
JOIN DIM_proveedores dp ON hp.proveedorid = dp.proveedorid
JOIN productos p ON hp.producto_id = p.productoid
JOIN DIM_temporal dt ON hp.fechaid = dt.fechaid
JOIN DIM_ubicaciones du ON hp.provinciaid = du.provinciaid
ORDER BY hp.total_ventas DESC
FETCH FIRST 10 ROWS ONLY;

select * from PROVEEDORes where PROVEEDORID = 3001;

select * from PROVEEDORes where PROVEEDORID = 3002;

COMMIT;

select * from PROVINCIAS;

Select * from clientes where CLIENTEID =3021;