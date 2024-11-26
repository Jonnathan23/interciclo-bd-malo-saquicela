ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER usuario_test IDENTIFIED BY 0000;
GRANT CONNECT, RESOURCE TO usuario_test;

grant select on Practica_PL_SQL.dim_clientes to usuario_test;
grant all on  Practica_PL_SQL.dim_clientes to usuario_test;
grant select, update, delete on Practica_PL_SQL.dim_clientes to usuario_test;

grant select on Practica_PL_SQL.dim_proveedores to usuario_test;
grant all on  Practica_PL_SQL.dim_proveedores to usuario_test;
grant select, update, delete on Practica_PL_SQL.dim_proveedores to usuario_test;

grant select on Practica_PL_SQL.dim_temporal to usuario_test;
grant all on  Practica_PL_SQL.dim_temporal to usuario_test;
grant select, update, delete on Practica_PL_SQL.dim_temporal to usuario_test;

grant select on Practica_PL_SQL.dim_ubicaciones to usuario_test;
grant all on  Practica_PL_SQL.dim_ubicaciones to usuario_test;
grant select, update, delete on Practica_PL_SQL.dim_ubicaciones to usuario_test;

grant select on Practica_PL_SQL.th_productos to usuario_test;
grant all on  Practica_PL_SQL.th_productos to usuario_test;
grant select, update, delete on Practica_PL_SQL.th_productos to usuario_test;
