insert into paises values (2, 'Palaos');

insert into regiones values (4, 'Pals');

INSERT INTO provincias VALUES (23, 'Koror', 4, 2);
INSERT INTO provincias VALUES (24, 'Melekeok', 4, 2);
INSERT INTO provincias VALUES (25, 'Karar', 4, 2);

COMMIT;
select * from proveedores where PROVEEDORID = 3001;
UPDATE provincias
SET nombreprovincia = 'Koror',
    regionid = 4,
    paisid = 2
WHERE provinciaid = 23;

UPDATE provincias
SET nombreprovincia = 'Melekeok',
    regionid = 4,
    paisid = 2
WHERE provinciaid = 24;

UPDATE provincias
SET nombreprovincia = 'Karar',
    regionid = 4,
    paisid = 2
WHERE provinciaid = 25;

Select * from provincias;

SELECT 
    pa.paisid AS Pais_ID,
    pa.nombrepais AS Pais,
    r.regionid AS Region_ID,
    r.nombreregion AS Region,
    pr.provinciaid AS Provincia_ID,
    pr.nombreprovincia AS Provincia
FROM 
    paises pa
JOIN regiones r ON r.paisid = pa.paisid
JOIN provincias pr ON pr.regionid = r.regionid AND pr.paisid = pa.paisid
ORDER BY pa.paisid, r.regionid, pr.provinciaid;



SELECT 
    tp.descripcion AS Producto,
    dp.nombreprov AS Proveedor,
    dt.fechaorden AS Fecha,
    du.nombreprovincia AS Provincia,
    dc.nombrecontacto AS Cliente,
    tp.total_ventas AS Total_Ventas
FROM TH_PRODUCTOS tp
JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid
JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid
JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid
JOIN DIM_clientes dc ON tp.clienteid = dc.clienteid
ORDER BY tp.total_ventas DESC
FETCH FIRST 10 ROWS ONLY;


Select * from HECHO_CLIENTE;
-- Actualizar PROVINCIAID para "Daniel Collaguazo"
UPDATE HECHO_CLIENTE
SET provinciaid = 23
WHERE clienteid = 3021;
COMMIT;

SELECT * FROM DIM_UBICACIONES;


update CLIENTES
set provinciaid = 23
where clienteid = 3021;

update PROVEEDORES
set provinciaid = 24
where proveedorid = 3001;

update PROVEEDORES
set provinciaid = 25
where proveedorid = 3002;

COMMIT;
SELECT * from PROVEEDORES where PROVEEDORID = 3002;

SELECT clienteid FROM DIM_clientes WHERE clienteid = 3021;
select * from CLIENTES where clienteid = 3021;
-- Actualizar PROVINCIAID para "BEATRIZ ORTIZ"
UPDATE TH_PRODUCTOS
SET provinciaid = 24
WHERE clienteid = (SELECT clienteid FROM DIM_clientes WHERE nombrecontacto = 'BEATRIZ ORTIZ                                     ');

-- Actualizar PROVINCIAID para "CAROLINA LÓPEZ"
UPDATE TH_PRODUCTOS
SET provinciaid = 25
WHERE clienteid = (SELECT clienteid FROM DIM_clientes WHERE nombrecontacto = 'CAROLINA LÓPEZ                                   ');



-- Eliminar la tabla DIM_temporal
DROP TABLE DIM_temporal CASCADE CONSTRAINTS;

-- Eliminar la tabla DIM_proveedores
DROP TABLE DIM_proveedores CASCADE CONSTRAINTS;

-- Eliminar la tabla DIM_clientes
DROP TABLE DIM_clientes CASCADE CONSTRAINTS;

-- Eliminar la tabla SDIM_regiones
DROP TABLE SDIM_regiones CASCADE CONSTRAINTS;

-- Eliminar la tabla SDIM_paises
DROP TABLE SDIM_paises CASCADE CONSTRAINTS;

-- Eliminar la tabla DIM_ubicaciones
DROP TABLE DIM_ubicaciones CASCADE CONSTRAINTS;

-- Eliminar la tabla TH_productos
DROP TABLE TH_productos CASCADE CONSTRAINTS;


SELECT * 
FROM TH_PRODUCTOS

where PROVINCIAID = 23
ORDER BY total_ventas DESC
OFFSET 1 ROW FETCH NEXT 10 ROWS ONLY;


SELECT 
    tp.descripcion AS Producto,
    dp.nombreprov AS Proveedor,
    dt.fechaorden AS Fecha,
    du.nombreprovincia AS Provincia,
    dc.nombrecontacto AS Cliente,
    tp.total_ventas AS Total_Ventas
FROM TH_PRODUCTOS tp
JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid
JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid
JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid
JOIN DIM_clientes dc ON tp.clienteid = dc.clienteid
--WHERE tp.provinciaid IN (23, 24, 25) 
ORDER BY tp.total_ventas DESC;


--prod,prov,anio,semana,prov,totalventas
SELECT 
    tp.descripcion AS Producto,
    dp.nombreprov AS Proveedor,
    TO_CHAR(dt.fechaorden, 'YYYY') AS Año, -- Año
    TO_CHAR(dt.fechaorden, 'IW') AS Semana, -- Semana ISO
    du.nombreprovincia AS Provincia,
    dc.nombrecontacto AS Cliente,
    SUM(tp.total_ventas) AS Total_Ventas
FROM TH_PRODUCTOS tp
JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid
JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid
JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid
JOIN DIM_clientes dc ON tp.clienteid = dc.clienteid
-- WHERE tp.provinciaid IN (23, 24, 25) -- Opcional
GROUP BY 
    tp.descripcion, 
    dp.nombreprov, 
    TO_CHAR(dt.fechaorden, 'YYYY'), 
    TO_CHAR(dt.fechaorden, 'IW'), 
    du.nombreprovincia, 
    dc.nombrecontacto
ORDER BY 
    Año, Semana, Total_Ventas DESC;

--prod,ptov,anio,mes,prov,cli,totalventas
SELECT 
    tp.descripcion AS Producto,
    dp.nombreprov AS Proveedor,
    TO_CHAR(dt.fechaorden, 'YYYY') AS Año, -- Año
    TO_CHAR(dt.fechaorden, 'MM') AS Mes, -- Mes (en formato numérico)
    du.nombreprovincia AS Provincia,
    dc.nombrecontacto AS Cliente,
    SUM(tp.total_ventas) AS Total_Ventas
FROM TH_PRODUCTOS tp
JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid
JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid
JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid
JOIN DIM_clientes dc ON tp.clienteid = dc.clienteid
--WHERE tp.provinciaid IN (23, 24, 25) -- Opcional
GROUP BY 
    tp.descripcion, 
    dp.nombreprov, 
    TO_CHAR(dt.fechaorden, 'YYYY'), 
    TO_CHAR(dt.fechaorden, 'MM'), 
    du.nombreprovincia, 
    dc.nombrecontacto
ORDER BY 
    Año, Mes, Total_Ventas DESC;






commit;



--pais,totalventas
SELECT 
    sp.nombreregion AS Pais, -- Nombre del país
    SUM(tp.total_ventas) AS Total_Ventas -- Suma total de ventas por país
FROM TH_productos tp
JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid -- Relación con ubicaciones
JOIN SDIM_paises sp ON du.paisid = sp.paisid -- Relación con países
GROUP BY sp.nombreregion -- Agrupamos por el nombre del país
ORDER BY Total_Ventas DESC; -- Ordenamos por ventas totales de mayor a menor


-- anio,mes,dia,pais,total_ventas
SELECT 
    TO_CHAR(dt.fechaorden, 'YYYY') AS Año,         -- Extrae el año
    TO_CHAR(dt.fechaorden, 'MM') AS Mes,          -- Extrae el mes (número)
    TO_CHAR(dt.fechaorden, 'DD') AS Día,          -- Extrae el día
    sp.nombreregion AS Pais,                      -- Nombre del país
    SUM(tp.total_ventas) AS Total_Ventas          -- Suma de ventas
FROM TH_productos tp
JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid   -- Relación con tabla temporal
JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid -- Relación con ubicaciones
JOIN SDIM_paises sp ON du.paisid = sp.paisid      -- Relación con países
GROUP BY 
    TO_CHAR(dt.fechaorden, 'YYYY'), 
    TO_CHAR(dt.fechaorden, 'MM'), 
    TO_CHAR(dt.fechaorden, 'DD'), 
    sp.nombreregion
ORDER BY 
    sp.nombreregion DESC,
    Año, Mes, Día, Pais;                          -- Orden cronológico por fecha y país

--prov,prov,anio,mes,dia,prov,pais,cli,total_ventas
SELECT 
    tp.descripcion AS Producto,                  -- Producto
    dp.nombreprov AS Proveedor,                 -- Proveedor
    TO_CHAR(dt.fechaorden, 'YYYY') AS Año,      -- Año
    TO_CHAR(dt.fechaorden, 'MM') AS Mes,        -- Mes
    TO_CHAR(dt.fechaorden, 'DD') AS Día,        -- Día
    du.nombreprovincia AS Provincia,            -- Provincia
    sp.nombreregion AS Pais,                    -- País
    dc.nombrecontacto AS Cliente,               -- Cliente
    SUM(tp.total_ventas) AS Total_Ventas        -- Total de ventas
FROM TH_PRODUCTOS tp
JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid     -- Relación con proveedores
JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid               -- Relación con temporal
JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid    -- Relación con ubicaciones
JOIN SDIM_paises sp ON du.paisid = sp.paisid                  -- Relación con países
JOIN DIM_clientes dc ON tp.clienteid = dc.clienteid           -- Relación con clientes
--WHERE tp.provinciaid IN (23, 24, 25)                        -- Filtrar si es necesario
GROUP BY 
    tp.descripcion, 
    dp.nombreprov, 
    TO_CHAR(dt.fechaorden, 'YYYY'), 
    TO_CHAR(dt.fechaorden, 'MM'), 
    TO_CHAR(dt.fechaorden, 'DD'), 
    du.nombreprovincia, 
    sp.nombreregion, 
    dc.nombrecontacto
ORDER BY 
    sp.nombreregion DESC,                                     -- País en orden descendente
    Año, Mes, Día,                                           -- Orden cronológico
    tp.descripcion;                                          -- Orden adicional por producto



SELECT 
    tp.descripcion AS Producto,                  -- Producto
    dp.nombreprov AS Proveedor,                 -- Proveedor
    TO_CHAR(dt.fechaorden, 'YYYY') AS Año,      -- Año
    TO_CHAR(dt.fechaorden, 'MM') AS Mes,        -- Mes
    TO_CHAR(dt.fechaorden, 'DD') AS Día,        -- Día
    du.nombreprovincia AS Provincia,            -- Provincia
    sr.nombreregion AS Region,                  -- Región
    sp.nombreregion AS Pais,                    -- País
    dc.nombrecontacto AS Cliente,               -- Cliente
    SUM(tp.total_ventas) AS Total_Ventas        -- Total de ventas
FROM TH_PRODUCTOS tp
JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid     -- Relación con proveedores
JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid               -- Relación con temporal
JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid    -- Relación con ubicaciones
JOIN SDIM_regiones sr ON du.regionid = sr.regionid            -- Relación con regiones
JOIN SDIM_paises sp ON du.paisid = sp.paisid                  -- Relación con países
JOIN DIM_clientes dc ON tp.clienteid = dc.clienteid           -- Relación con clientes
--WHERE tp.provinciaid IN (23, 24, 25)                        -- Filtrar si es necesario
GROUP BY 
    tp.descripcion, 
    dp.nombreprov, 
    TO_CHAR(dt.fechaorden, 'YYYY'), 
    TO_CHAR(dt.fechaorden, 'MM'), 
    TO_CHAR(dt.fechaorden, 'DD'), 
    du.nombreprovincia, 
    sr.nombreregion, 
    sp.nombreregion, 
    dc.nombrecontacto
ORDER BY 
    sp.nombreregion DESC,                                     -- País en orden descendente
    sr.nombreregion,                                          -- Región en orden
    Año, Mes, Día,                                           -- Orden cronológico
    tp.descripcion;                                          -- Orden adicional por producto




SELECT 
    dp.nombreprov AS Proveedor,                 -- Proveedor
    tp.descripcion AS Producto,                -- Producto
    TO_CHAR(dt.fechaorden, 'YYYY') AS Año,     -- Año
    TO_CHAR(dt.fechaorden, 'MM') AS Mes,       -- Mes
    TO_CHAR(dt.fechaorden, 'DD') AS Día,       -- Día
    du.nombreprovincia AS Provincia,           -- Provincia
    sr.nombreregion AS Region,                 -- Región
    sp.nombreregion AS Pais,                   -- País
    dc.nombrecontacto AS Cliente,              -- Cliente
    SUM(tp.total_ventas) AS Total_Ventas       -- Total de ventas
FROM DIM_proveedores dp
JOIN TH_PRODUCTOS tp ON dp.proveedorid = tp.proveedorid       -- Relación con productos
JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid              -- Relación con temporal
JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid   -- Relación con ubicaciones
JOIN SDIM_regiones sr ON du.regionid = sr.regionid           -- Relación con regiones
JOIN SDIM_paises sp ON du.paisid = sp.paisid                 -- Relación con países
JOIN DIM_clientes dc ON tp.clienteid = dc.clienteid          -- Relación con clientes
--WHERE dp.nombreprov = 'Proveedor X'                        -- Opcional: filtrar por proveedor específico
GROUP BY 
    dp.nombreprov, 
    tp.descripcion, 
    TO_CHAR(dt.fechaorden, 'YYYY'), 
    TO_CHAR(dt.fechaorden, 'MM'), 
    TO_CHAR(dt.fechaorden, 'DD'), 
    du.nombreprovincia, 
    sr.nombreregion, 
    sp.nombreregion, 
    dc.nombrecontacto
ORDER BY 
    dp.nombreprov,                                          -- Orden por proveedor
    sp.nombreregion DESC,                                   -- País en orden descendente
    sr.nombreregion,                                        -- Región
    Año, Mes, Día,                                          -- Cronológico
    tp.descripcion;                                         -- Producto


------------------C1----------------------------------------------
SELECT 
    Proveedor,
    Producto,
    Año,
    Mes,
    Día,
    Pais,
    Region,
    Provincia,
    Total_Ventas
FROM (
    SELECT 
        dp.nombreprov AS Proveedor,                  -- Proveedor
        tp.descripcion AS Producto,                 -- Producto
        TO_CHAR(dt.fechaorden, 'YYYY') AS Año,      -- Año
        TO_CHAR(dt.fechaorden, 'MM') AS Mes,        -- Mes
        TO_CHAR(dt.fechaorden, 'DD') AS Día,        -- Día
        sp.nombreregion AS Pais,                    -- País
        sr.nombreregion AS Region,                  -- Región
        du.nombreprovincia AS Provincia,            -- Provincia
        SUM(tp.total_ventas) AS Total_Ventas,       -- Total de ventas
        RANK() OVER (
            PARTITION BY dp.nombreprov, 
                         TO_CHAR(dt.fechaorden, 'YYYY'), 
                         TO_CHAR(dt.fechaorden, 'MM'), 
                         TO_CHAR(dt.fechaorden, 'DD'), 
                         sp.nombreregion, 
                         sr.nombreregion, 
                         du.nombreprovincia 
            ORDER BY SUM(tp.total_ventas) DESC
        ) AS Rango -- Clasifica los productos por ventas
    FROM TH_PRODUCTOS tp
    JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid     -- Relación con proveedores
    JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid               -- Relación con temporal
    JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid    -- Relación con ubicaciones
    JOIN SDIM_regiones sr ON du.regionid = sr.regionid            -- Relación con regiones
    JOIN SDIM_paises sp ON du.paisid = sp.paisid                  -- Relación con países
    GROUP BY 
        dp.nombreprov, 
        tp.descripcion, 
        TO_CHAR(dt.fechaorden, 'YYYY'), 
        TO_CHAR(dt.fechaorden, 'MM'), 
        TO_CHAR(dt.fechaorden, 'DD'), 
        sp.nombreregion, 
        sr.nombreregion, 
        du.nombreprovincia
)
WHERE Rango = 1 and Pais = 'Palaos'-- Filtra solo el producto más vendido en cada combinación
ORDER BY 
    Proveedor, Año, Mes, Día, Pais, Region, Provincia, Total_Ventas;


------------------------------------------`
SELECT 
    Proveedor,
    Producto,
    Anio,
    Mes,
    Dia,
    Pais,
    Region,
    Provincia,
    Total_Ventas
FROM (
    SELECT 
        dp.nombreprov AS Proveedor,                  -- Proveedor
        tp.descripcion AS Producto,                 -- Producto
        TO_CHAR(dt.fechaorden, 'YYYY') AS Anio,      -- Anio
        TO_CHAR(dt.fechaorden, 'MM') AS Mes,        -- Mes
        TO_CHAR(dt.fechaorden, 'DD') AS Dia,        -- Dia
        sp.nombreregion AS Pais,                    -- Pais
        sr.nombreregion AS Region,                  -- Region
        du.nombreprovincia AS Provincia,            -- Provincia
        SUM(tp.total_ventas) AS Total_Ventas,       -- Total de ventas
        RANK() OVER (
            PARTITION BY dp.nombreprov, 
                         TO_CHAR(dt.fechaorden, 'YYYY'), 
                         TO_CHAR(dt.fechaorden, 'MM'), 
                         TO_CHAR(dt.fechaorden, 'DD'), 
                         sp.nombreregion, 
                         sr.nombreregion, 
                         du.nombreprovincia 
            ORDER BY SUM(tp.total_ventas) DESC
        ) AS Rango -- Clasifica los productos por ventas
    FROM TH_PRODUCTOS tp
    JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid     -- Relacion con proveedores
    JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid               -- Relacion con temporal
    JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid    -- Relacion con ubicaciones
    JOIN SDIM_regiones sr ON du.regionid = sr.regionid            -- Relacion con regiones
    JOIN SDIM_paises sp ON du.paisid = sp.paisid                  -- Relacion con paises
    GROUP BY 
        dp.nombreprov, 
        tp.descripcion, 
        TO_CHAR(dt.fechaorden, 'YYYY'), 
        TO_CHAR(dt.fechaorden, 'MM'), 
        TO_CHAR(dt.fechaorden, 'DD'), 
        sp.nombreregion, 
        sr.nombreregion, 
        du.nombreprovincia
)
WHERE Rango = 1 and Pais = 'Palaos'-- Filtra solo el producto mas vendido en cada combinacion
ORDER BY 
    Proveedor, Anio, Mes, Dia, Pais, Region, Provincia, Total_Ventas;


----------------------------------


SELECT 
    Proveedor,
    Producto,
    Anio,
    Mes,
    Pais,
    Region,
    Provincia,
    Total_Ventas
FROM (
    SELECT 
        dp.nombreprov AS Proveedor,                  -- Proveedor
        tp.descripcion AS Producto,                 -- Producto
        TO_CHAR(dt.fechaorden, 'YYYY') AS Anio,     -- A�o
        TO_CHAR(dt.fechaorden, 'MM') AS Mes,        -- Mes
        TO_CHAR(dt.fechaorden, 'DD') AS Dia,        -- D�a
        sp.nombreregion AS Pais,                    -- Pa�s
        sr.nombreregion AS Region,                  -- Regi�n
        du.nombreprovincia AS Provincia,            -- Provincia
        SUM(tp.total_ventas) AS Total_Ventas,       -- Total de ventas
        RANK() OVER (
            PARTITION BY TO_CHAR(dt.fechaorden, 'YYYY'), 
                         TO_CHAR(dt.fechaorden, 'MM'), 
                         TO_CHAR(dt.fechaorden, 'DD'), 
                         sp.nombreregion, 
                         sr.nombreregion, 
                         du.nombreprovincia 
            ORDER BY SUM(tp.total_ventas) DESC
        ) AS Rango -- Clasifica los productos por ventas
    FROM TH_PRODUCTOS tp
    JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid     -- Relaci�n con proveedores
    JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid               -- Relaci�n con temporal
    JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid    -- Relaci�n con ubicaciones
    JOIN SDIM_regiones sr ON du.regionid = sr.regionid            -- Relaci�n con regiones
    JOIN SDIM_paises sp ON du.paisid = sp.paisid                  -- Relaci�n con pa�ses
    GROUP BY 
        dp.nombreprov, 
        tp.descripcion, 
        TO_CHAR(dt.fechaorden, 'YYYY'), 
        TO_CHAR(dt.fechaorden, 'MM'), 
        TO_CHAR(dt.fechaorden, 'DD'), 
        sp.nombreregion, 
        sr.nombreregion, 
        du.nombreprovincia
)
WHERE Rango = 1  and Pais = 'Palaos'-- Filtra solo el producto m�s vendido en cada combinaci�n
ORDER BY 
    Proveedor, Anio, Mes, Dia, Pais, Region, Provincia, Total_Ventas DESC;


-------------------------------

SELECT 
    Proveedor,
    Anio,
    Mes,
    Region,
    Provincia,
    Total_Productos
FROM (
    SELECT 
        dp.nombreprov AS Proveedor,               -- Proveedor
        TO_CHAR(dt.fechaorden, 'YYYY') AS Anio,  -- A�o
        TO_CHAR(dt.fechaorden, 'MM') AS Mes,     -- Mes
        sr.nombreregion AS Region,               -- Regi�n
        du.nombreprovincia AS Provincia,         -- Provincia
        COUNT(tp.descripcion) AS Total_Productos, -- Total de productos vendidos
        RANK() OVER (
            PARTITION BY TO_CHAR(dt.fechaorden, 'YYYY'), 
                         TO_CHAR(dt.fechaorden, 'MM'), 
                         sr.nombreregion, 
                         du.nombreprovincia
            ORDER BY COUNT(tp.descripcion) DESC
        ) AS Rango -- Clasifica a los proveedores por n�mero de productos vendidos
    FROM TH_PRODUCTOS tp
    JOIN DIM_proveedores dp ON tp.proveedorid = dp.proveedorid      -- Relaci�n con proveedores
    JOIN DIM_temporal dt ON tp.fechaid = dt.fechaid                -- Relaci�n con temporal
    JOIN DIM_ubicaciones du ON tp.provinciaid = du.provinciaid     -- Relaci�n con ubicaciones
    JOIN SDIM_regiones sr ON du.regionid = sr.regionid             -- Relaci�n con regiones
    GROUP BY 
        dp.nombreprov, 
        TO_CHAR(dt.fechaorden, 'YYYY'), 
        TO_CHAR(dt.fechaorden, 'MM'), 
        sr.nombreregion, 
        du.nombreprovincia
)
WHERE Rango = 1 -- Filtra solo el proveedor con el mayor n�mero de productos en cada combinaci�n
ORDER BY 
    Anio, Mes, Region, Provincia, Total_Productos DESC;







