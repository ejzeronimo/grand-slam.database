/* 
NOTE: creates the table for people
*/

-- drop the old table
DROP TABLE person CASCADE CONSTRAINTS;

-- make the table schema
CREATE TABLE person (
    playerid VARCHAR2 (8) NOT NULL,
    lastname VARCHAR2 (30),
    firstname VARCHAR2 (50),
    usename VARCHAR2 (30),
    birthdate date,
    birthcity VARCHAR2 (50),
    birthstate VARCHAR2 (30),
    birthcountry VARCHAR2 (30),
    debutdateasplayer date,
    dateoflastgameasplayer date,
    debutdateasmanager date,
    dateoflastgameasmanager date,
    debutdateascoach date,
    dateoflastgameascoach date,
    debutdateasumpire date,
    dateoflastgameasumpire date,
    deathdate date,
    deathcity VARCHAR2 (50),
    deathstate VARCHAR2 (50),
    deathcountry VARCHAR2 (30),
    bat VARCHAR2 (1),
    throws VARCHAR2 (1),
    height VARCHAR2 (6),
    weight NUMBER (3),
    cemetery VARCHAR2 (50),
    cemeterycity VARCHAR2 (50),
    cemeterystate VARCHAR2 (30),
    cemeterycountry VARCHAR2 (30),
    cemeterynote VARCHAR2 (250),
    birthname VARCHAR2 (50),
    namechange VARCHAR2 (100),
    batchange VARCHAR2 (100),
    hof VARCHAR2 (100)
);

-- add the PK to the table
ALTER TABLE person ADD CONSTRAINT person_pk PRIMARY KEY (playerid);

-- create ref
CREATE OR REPLACE PUBLIC SYNONYM person FOR admin.person;

-- after that commit all of the changes made
COMMIT;