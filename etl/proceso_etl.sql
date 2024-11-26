---- DIM tiempo
declare
    cursor fechas_cur is 
            select distinct(fechaorden) from ordenes;
    
    pointer int := 1;
    f_value date;
    
begin
    open fechas_cur;
    
    loop
        fetch fechas_cur into f_value;
        exit when fechas_cur%NOTFOUND;
--        DBMS_OUTPUT.PUT_LINE('index: ' || pointer || ' fecha: ' || f_value);
        insert into DIM_temporal values (pointer, f_value);
        pointer := pointer + 1;
    end loop;
    close fechas_cur;
end;
COMMIT;

---- DIM_proveedores
declare 
    cursor prov_cur is
        select proveedorid, nombreprov from proveedores;
    
    p_id int;
    n_prov varchar2(50);

begin
    open prov_cur;
    
    loop
        fetch prov_cur into  p_id, n_prov;
        exit when prov_cur%NOTFOUND;
--        DBMS_OUTPUT.PUT_LINE('index: ' || p_id || ' nombre: ' || n_prov);
        insert into dim_proveedores values (p_id, n_prov);
    end loop;
    close prov_cur;
end;
COMMIT;

---- DIM_clientes
declare 
    cursor cli_cur is
        select clienteid, nombrecontacto from clientes;
    
    cli_id int;
    cli_n varchar2(50);
begin
    open cli_cur;
    loop
        fetch cli_cur into cli_id, cli_n;
        exit when cli_cur%NOTFOUND;
        insert into dim_clientes values (cli_id, cli_n);
    end loop;
    close cli_cur;
end;
COMMIT;

---- DIM_ubicaciones
declare 
    cursor r_cur is 
        select regionid, nombreregion from regiones;
    
    cursor p_cur is
        select paisid, nombrepais from paises;
        
    cursor prov_cur is
        select * from provincias;
    
    r_id int;
    r_nom varchar(50);
    p_id int;
    p_nom varchar(50);
    prov_id int;
    prov_nom varchar(50);
begin
    open r_cur;
    loop
        fetch r_cur into  r_id, r_nom;
        exit when r_cur%NOTFOUND;
        insert into sdim_regiones values (r_id, r_nom);
    end loop;
    close r_cur;
    
    open p_cur;
    loop
        fetch p_cur into  p_id, p_nom;
        exit when p_cur%NOTFOUND;
        insert into sdim_paises values (p_id, p_nom);
    end loop;
    close p_cur;
    
    open prov_cur;
    loop
        fetch prov_cur into prov_id, prov_nom, r_id, p_id;
        exit when prov_cur%NOTFOUND;
        insert into dim_ubicaciones values (prov_id, prov_nom, p_id, r_id);
    end loop;
    close prov_cur;
end;
COMMIT;

---- th_productos
declare 
    cursor ids_cur is
        (select o.clienteid, o.fechaorden, do.productoid, do.cantidad
            from detalle_ordenes do, ordenes o
            where o.ordenid = do.ordenid);      
    cursor det_prod_cur (pid int) is 
        (select proveedorid, descripcion 
            from productos
            where productoid = pid); 
    cursor fechas_cur (fecha date) is
            (select fechaid
                from dim_temporal
                where fechaorden = fecha); 
    cursor prov_cur(c_id int) is 
        (select provinciaid
            from clientes
            where clienteid = c_id);        
    c_id int;
    fo date;
    p_id int;
    can int;
    prov_id int;
    des varchar2(50);
    fo_id int;
    pro_id int;

begin
    open ids_cur;
    loop
        fetch ids_cur into c_id, fo, p_id, can;
        open det_prod_cur(p_id);
        open fechas_cur(fo);
        open prov_cur(c_id);
        fetch det_prod_cur into prov_id, des;
        fetch fechas_cur into fo_id;
        fetch prov_cur into pro_id;
        exit when ids_cur%NOTFOUND;
        insert into th_productos values (p_id, des, fo_id, prov_id, c_id, pro_id, can);
        close det_prod_cur;
        close fechas_cur;
        close prov_cur;
    end loop;
    close ids_cur;
end;
commit;

--Comprobacion
SELECT clienteid, NOMBRECIA, total_productos
FROM (
    SELECT o.clienteid, c.NOMBRECIA, SUM(do.cantidad) AS total_productos
    FROM detalle_ordenes do, ordenes o, CLIENTES c
    WHERE o.ordenid = do.ordenid AND c.CLIENTEID = o.clienteid
    GROUP BY o.clienteid, c.NOMBRECIA
    ORDER BY total_productos DESC
) 
WHERE ROWNUM = 1;


SELECT proveedorid, nombreprov, total_productos
FROM (
    SELECT p.proveedorid, pr.nombreprov, SUM(do.cantidad) AS total_productos
    FROM detalle_ordenes do
    JOIN productos p ON do.productoid = p.productoid
    JOIN proveedores pr ON p.proveedorid = pr.proveedorid
    GROUP BY p.proveedorid, pr.nombreprov
    ORDER BY total_productos DESC
) 
WHERE ROWNUM = 1;
