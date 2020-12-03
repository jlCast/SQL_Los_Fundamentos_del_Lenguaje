-- Creci�n del tablespace en el datafile especificado para almacenar las tablas
CREATE TABLESPACE SQL_lfdl 
   DATAFILE 'SQL_lfdl.dbf' 
   SIZE 20m -- Tama�o inicial
   AUTOEXTEND ON; -- Autoincremento del espacio asignado
-- Consultamos la tabla dba_data_files mostrando el tablespace al que pertenece cada data file y su tama�o
SELECT 
   tablespace_name, 
   file_name, 
   bytes / 1024/ 1024  MB
FROM
   dba_data_files;
-- Creamos un usuario en el tablespace generado
CREATE USER SQL_lfdl_user 
IDENTIFIED BY contrase�a 
DEFAULT TABLESPACE SQL_lfdl;
-- Concedemos todos los privilegios al usuario creado
GRANT ALL PRIVILEGES TO SQL_lfdl_user ;
-- Mostramos la tabla dba_users para ver el usuario creado
SELECT * FROM dba_users;
-- Consultamos en el diccionario "dba_sys_privs" los privilegios del usuario creado
SELECT grantee, privilege FROM dba_sys_privs
WHERE grantee='SQL_LFDL_USER'
ORDER BY privilege;
-- Creamos una nueva conexi�n con el usuario creado
-- Visualizamos el usuario actual
SHOW USER;
