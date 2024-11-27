---- Creación de la dimensión temporal (DIM tiempo)
-- Este bloque llena la tabla DIM_temporal con identificadores únicos asociados a cada fecha de las órdenes.
commit;
declare
    cursor fechas_cur is 
        -- Cursor que selecciona fechas únicas de la tabla 'ordenes'
        select distinct(fechaorden) from ordenes;
    
    pointer int := 1; -- Contador para asignar IDs únicos
    f_value date; -- Variable para almacenar la fecha extraída del cursor
    
begin
    open fechas_cur; -- Abrir el cursor
    loop
        fetch fechas_cur into f_value; -- Obtener la siguiente fecha
        exit when fechas_cur%NOTFOUND; -- Salir del loop si no hay más filas
        insert into DIM_temporal values (pointer, f_value); -- Insertar en la tabla de dimensión
        pointer := pointer + 1; -- Incrementar el contador
    end loop;
    close fechas_cur; -- Cerrar el cursor
end;
COMMIT;

---- Creación de la dimensión de proveedores (DIM_proveedores)
-- Llena la tabla DIM_proveedores con IDs de proveedores y sus nombres.
declare 
    cursor prov_cur is
        -- Cursor que selecciona los proveedores desde la tabla 'proveedores'
        select proveedorid, nombreprov from proveedores;
    
    p_id int; -- Variable para almacenar el ID del proveedor
    n_prov varchar2(50); -- Variable para almacenar el nombre del proveedor

begin
    open prov_cur; -- Abrir el cursor
    loop
        fetch prov_cur into p_id, n_prov; -- Obtener el siguiente proveedor
        exit when prov_cur%NOTFOUND; -- Salir del loop si no hay más filas
        insert into dim_proveedores values (p_id, n_prov); -- Insertar en la tabla de dimensión
    end loop;
    close prov_cur; -- Cerrar el cursor
end;
COMMIT;

---- Creación de la dimensión de clientes (DIM_clientes)
-- Llena la tabla DIM_clientes con IDs de clientes y sus nombres de contacto.
declare 
    cursor cli_cur is
        -- Cursor que selecciona clientes desde la tabla 'clientes'
        select clienteid, nombrecontacto from clientes;
    
    cli_id int; -- Variable para almacenar el ID del cliente
    cli_n varchar2(50); -- Variable para almacenar el nombre del contacto
begin
    open cli_cur; -- Abrir el cursor
    loop
        fetch cli_cur into cli_id, cli_n; -- Obtener el siguiente cliente
        exit when cli_cur%NOTFOUND; -- Salir del loop si no hay más filas
        insert into dim_clientes values (cli_id, cli_n); -- Insertar en la tabla de dimensión
    end loop;
    close cli_cur; -- Cerrar el cursor
end;
COMMIT;

---- Creación de la dimensión de ubicaciones (DIM_ubicaciones)
-- Llena tablas de dimensiones relacionadas con ubicaciones: regiones, países y provincias.
declare 
    cursor r_cur is 
        -- Cursor que selecciona regiones desde la tabla 'regiones'
        select regionid, nombreregion from regiones;
    
    cursor p_cur is
        -- Cursor que selecciona países desde la tabla 'paises'
        select paisid, nombrepais from paises;
        
    cursor prov_cur is
        -- Cursor que selecciona provincias desde la tabla 'provincias'
        select * from provincias;
    
    r_id int; -- Variable para almacenar el ID de la región
    r_nom varchar(50); -- Variable para almacenar el nombre de la región
    p_id int; -- Variable para almacenar el ID del país
    p_nom varchar(50); -- Variable para almacenar el nombre del país
    prov_id int; -- Variable para almacenar el ID de la provincia
    prov_nom varchar(50); -- Variable para almacenar el nombre de la provincia
begin
    -- Procesar las regiones
    open r_cur;
    loop
        fetch r_cur into r_id, r_nom;
        exit when r_cur%NOTFOUND;
        insert into sdim_regiones values (r_id, r_nom);
    end loop;
    close r_cur;
    
    -- Procesar los países
    open p_cur;
    loop
        fetch p_cur into p_id, p_nom;
        exit when p_cur%NOTFOUND;
        insert into sdim_paises values (p_id, p_nom);
    end loop;
    close p_cur;
    
    -- Procesar las provincias
    open prov_cur;
    loop
        fetch prov_cur into prov_id, prov_nom, r_id, p_id;
        exit when prov_cur%NOTFOUND;
        insert into dim_ubicaciones values (prov_id, prov_nom, p_id, r_id);
    end loop;
    close prov_cur;
end;
COMMIT;

---- Creación de la tabla histórica de productos (th_productos)
-- Llena la tabla histórica con información de productos y datos relacionados.
declare 
    cursor ids_cur is
        -- Cursor principal que selecciona los IDs y cantidades de productos en las órdenes
        (select o.clienteid, o.fechaorden, do.productoid, do.cantidad
         from detalle_ordenes do, ordenes o
         where o.ordenid = do.ordenid);      
    cursor det_prod_cur (pid int) is 
        -- Cursor que obtiene detalles del producto según su ID
        (select proveedorid, descripcion 
         from productos
         where productoid = pid); 
    cursor fechas_cur (fecha date) is
        -- Cursor que obtiene el ID temporal según la fecha
        (select fechaid
         from dim_temporal
         where fechaorden = fecha); 
    cursor prov_cur(c_id int) is 
        -- Cursor que obtiene la provincia de un cliente según su ID
        (select provinciaid
         from clientes
         where clienteid = c_id);        
    c_id int; -- ID del cliente
    fo date; -- Fecha de la orden
    p_id int; -- ID del producto
    can int; -- Cantidad del producto
    prov_id int; -- ID del proveedor
    des varchar2(50); -- Descripción del producto
    fo_id int; -- ID de la fecha en DIM_temporal
    pro_id int; -- ID de la provincia del cliente

begin
    open ids_cur; -- Abrir el cursor principal
    loop
        fetch ids_cur into c_id, fo, p_id, can;
        open det_prod_cur(p_id);
        open fechas_cur(fo);
        open prov_cur(c_id);
        fetch det_prod_cur into prov_id, des;
        fetch fechas_cur into fo_id;
        fetch prov_cur into pro_id;
        exit when ids_cur%NOTFOUND;
        -- Insertar en la tabla histórica
        insert into th_productos values (p_id, des, fo_id, prov_id, c_id, pro_id, can);
        close det_prod_cur;
        close fechas_cur;
        close prov_cur;
    end loop;
    close ids_cur;
end;
commit;

-- Comprobación de datos
-- Obtener el cliente con más productos comprados
SELECT clienteid, NOMBRECIA, total_productos
FROM (
    SELECT o.clienteid, c.NOMBRECIA, SUM(do.cantidad) AS total_productos
    FROM detalle_ordenes do, ordenes o, CLIENTES c
    WHERE o.ordenid = do.ordenid AND c.CLIENTEID = o.clienteid
    GROUP BY o.clienteid, c.NOMBRECIA
    ORDER BY total_productos DESC
) 
WHERE ROWNUM = 1;

-- Obtener el proveedor con más productos vendidos
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
