/* NOTE: creation regular account */
DROP USER username;
-- create user
CREATE USER username IDENTIFIED BY password;
-- basic priv
GRANT CREATE PUBLIC SYNONYM TO username;
GRANT CONNECT, RESOURCE TO username;
GRANT PDB_DBA TO username;
GRANT CREATE SESSION TO username;
GRANT CREATE TABLE TO username;
GRANT CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE TO username;
GRANT SELECT ANY TABLE TO username;
GRANT ANALYZE ANY TO username;
-- add to tablespace
ALTER USER username QUOTA UNLIMITED ON tablespacename;
ALTER USER username DEFAULT TABLESPACE tablespacename;
-- list
SELECT *
FROM all_users;