/* NOTE: creation functions/outline */
SELECT *
FROM v$containers;
-- list pdbs
SELECT con_id, name, open_mode
FROM v$pdbs;
-- kill the old pluggable database
ALTER PLUGGABLE DATABASE pluggabledatabasename close INSTANCES = ALL;
ALTER PLUGGABLE DATABASE pluggabledatabasename UNPLUG INTO 'pluggabledatabasename.xml';
DROP PLUGGABLE DATABASE pluggabledatabasename;
-- create the pdb
CREATE PLUGGABLE DATABASE pluggabledatabasename ADMIN USER databaseadmin IDENTIFIED BY adminpassword FILE_NAME_CONVERT = (
    '/pdbseed', '/pluggabledatabasename'
);
ALTER PLUGGABLE DATABASE pluggabledatabasename open;
ALTER PLUGGABLE DATABASE pluggabledatabasename SAVE STATE;
-- context switch to the pluggable database
ALTER SESSION SET container = pluggabledatabasename;
-- make new tablespace
CREATE TABLESPACE tablespacename DATAFILE 'tablespacename.dbf' SIZE 1g;
-- list tablespaces
SELECT tablespace_name, status, contents
FROM user_tablespaces;
-- assign admin to it
ALTER USER databaseadmin QUOTA UNLIMITED ON tablespacename;
ALTER USER databaseadmin DEFAULT TABLESPACE tablespacename;
-- print admin default
SELECT default_tablespace
FROM dba_users
WHERE username = 'databaseadmin';