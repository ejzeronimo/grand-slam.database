/* 
NOTE: creates the table for ejections
*/

-- drop the old table
DROP TABLE ejections CASCADE CONSTRAINTS;

-- make the table schema
CREATE TABLE ejections (
    gameid VARCHAR2 (12) NOT NULL,
    "date" date,
    gamenumber VARCHAR2 (2),
    playerid VARCHAR2 (8) NOT NULL,
    playername VARCHAR2 (30),
    team VARCHAR2 (3),
    playerrole VARCHAR2 (1),
    umpireid VARCHAR2 (8),
    umpirename VARCHAR2 (30),
    inning VARCHAR2 (2),
    reason VARCHAR2 (500)
);

-- add the PK to the table
ALTER TABLE ejections ADD CONSTRAINT ejections_pk PRIMARY KEY (gameid, playerid);

-- create ref
CREATE OR REPLACE PUBLIC SYNONYM ejections FOR admin.ejections;

-- after that commit all of the changes made
COMMIT;