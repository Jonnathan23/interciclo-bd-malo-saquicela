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

COMMIT;

select count(clienteid) from clientes;

SELECT * FROM clientes;

--- Llenado de la tabla proveedores con provincias usando cursores

DECLARE
    CURSOR proveedores_cur IS
        SELECT proveedorid FROM proveedores;
    
    p_id clientes.clienteid%TYPE;
    pointer number := 1;
    
BEGIN

    OPEN proveedores_cur;
    
    LOOP
        FETCH proveedores_cur INTO p_id;
    
        EXIT WHEN proveedores_cur%NOTFOUND;
        
        if pointer < 20 then 
            pointer := pointer + 1;
        else
            pointer := 1;
        end if;
        update proveedores
        set provinciaid = pointer
        where proveedorid = p_id;
        
     END LOOP;
     
     CLOSE proveedores_cur;
END;

COMMIT;


-- Crear procedimiento para actualizar datos con valores aleatorios
CREATE OR REPLACE PROCEDURE llenar_metodo IS
BEGIN
    -- Actualizar datos en clientes con valores aleatorios
    UPDATE clientes
    SET metodoid = ROUND(DBMS_RANDOM.VALUE(1, 3)), -- Método aleatorio entre 1 y 3
        meses = CASE
                   WHEN metodoid = 3 THEN ROUND(DBMS_RANDOM.VALUE(1, 12)) -- Si es crédito, meses entre 1 y 12
                   ELSE 0 -- Para otros métodos, 0 meses
               END
    WHERE metodoid IS NULL;

    -- Actualizar datos en proveedores con valores aleatorios
    UPDATE proveedores
    SET metodoid = ROUND(DBMS_RANDOM.VALUE(1, 3)), -- Método aleatorio entre 1 y 3
        meses = CASE
                   WHEN metodoid = 3 THEN ROUND(DBMS_RANDOM.VALUE(1, 12)) -- Si es crédito, meses entre 1 y 12
                   ELSE 0 -- Para otros métodos, 0 meses
               END
    WHERE metodoid IS NULL;
END;


-- Ejecutar el procedimiento
BEGIN
    llenar_metodo;
END;


-- Crear procedimiento para asignar meses si el metodoid es 3
CREATE OR REPLACE PROCEDURE asignar_meses IS
BEGIN
    -- Actualizar los meses para clientes donde metodoid = 3
    UPDATE clientes
    SET meses = ROUND(DBMS_RANDOM.VALUE(1, 12)) -- Generar un valor entre 1 y 12
    WHERE metodoid = 3 AND (meses IS NULL OR meses = 0);

    -- Actualizar los meses para proveedores donde metodoid = 3
    UPDATE proveedores
    SET meses = ROUND(DBMS_RANDOM.VALUE(1, 12)) -- Generar un valor entre 1 y 12
    WHERE metodoid = 3 AND (meses IS NULL OR meses = 0);
END;


-- Ejecutar el procedimiento
BEGIN
    asignar_meses;
END;



COMMIT;
