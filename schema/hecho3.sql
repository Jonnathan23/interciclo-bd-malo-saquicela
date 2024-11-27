drop table HECHO_CLIENTE;
CREATE TABLE HECHO_CLIENTE (
    clienteid INT NOT NULL,
    producto_id INT NOT NULL,
    fechaid INT NOT NULL,
    provinciaid INT NOT NULL,
    cantidad NUMBER(10) NOT NULL,
    total_compras NUMBER(10, 2) NOT NULL,
    constraint FK_HC_DIM_CLI foreign key (clienteid) references DIM_clientes (clienteid),
    constraint FK_HC_DIM_TEMP foreign key (fechaid) references DIM_temporal (fechaid),
    constraint FK_HC_DIM_UBI foreign key (provinciaid) references DIM_ubicaciones (provinciaid)
);

COMMIT;

DECLARE
    CURSOR fact_cli_cursor IS
        SELECT o.clienteid, 
               do.productoid, 
               o.fechaorden, 
               c.provinciaid, 
               SUM(do.cantidad) AS total_cantidad, 
               SUM(do.cantidad * p.preciounit) AS total_compras
        FROM detalle_ordenes do
        JOIN productos p ON do.productoid = p.productoid
        JOIN ordenes o ON do.ordenid = o.ordenid
        JOIN clientes c ON o.clienteid = c.clienteid
        GROUP BY o.clienteid, do.productoid, o.fechaorden, c.provinciaid;

    cli_id INT;
    prod_id INT;
    fecha DATE;
    prov_loc INT;
    total_v NUMBER(10, 2);
    cantidad NUMERIC(10);

BEGIN
    OPEN fact_cli_cursor;

    LOOP
        FETCH fact_cli_cursor INTO cli_id, prod_id, fecha, prov_loc, cantidad, total_v;
        EXIT WHEN fact_cli_cursor%NOTFOUND;

        INSERT INTO HECHO_CLIENTE (clienteid, producto_id, fechaid, provinciaid, cantidad, total_compras)
        VALUES (
            cli_id, 
            prod_id, 
            (SELECT fechaid FROM DIM_temporal WHERE fechaorden = fecha), 
            prov_loc, 
            cantidad, 
            total_v
        );
    END LOOP;

    CLOSE fact_cli_cursor;
END;
COMMIT;

SELECT COUNT(*) AS total_registros FROM HECHO_CLIENTE;

SELECT * FROM HECHO_CLIENTE FETCH FIRST 10 ROWS ONLY;

SELECT clienteid, 
       SUM(total_compras) AS Total_Pagado
FROM HECHO_CLIENTE
GROUP BY clienteid
ORDER BY Total_Pagado DESC;


SELECT * 
FROM HECHO_CLIENTE
ORDER BY total_compras DESC
OFFSET 1 ROW FETCH NEXT 10 ROWS ONLY;


SELECT 
    c.nombrecontacto AS Cliente,
    p.descripcion AS Producto,
    dt.fechaorden AS Fecha,
    du.nombreprovincia AS Provincia,
    hc.cantidad AS Cantidad,
    hc.total_compras AS Total_Compras
FROM HECHO_CLIENTE hc
JOIN DIM_CLIENTES c ON hc.clienteid = c.clienteid
JOIN productos p ON hc.producto_id = p.productoid
JOIN DIM_temporal dt ON hc.fechaid = dt.fechaid
JOIN DIM_ubicaciones du ON hc.provinciaid = du.provinciaid
ORDER BY hc.total_compras DESC
OFFSET 1 ROW FETCH NEXT 10 ROWS ONLY;
