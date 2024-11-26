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

SELECT * FROM proveedores;

