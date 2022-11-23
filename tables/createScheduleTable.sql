/* 
NOTE: creates the table for schedules
*/

-- drop the old table
DROP TABLE schedule CASCADE CONSTRAINTS;

-- make the table schema
CREATE TABLE schedule (
    gamedate date NOT NULL,
    numberofgames VARCHAR2 (1),
    dayofweek VARCHAR2 (3),
    visitingteam VARCHAR2 (3),
    visitingteamleague VARCHAR2 (2),
    visitingteamgameamount NUMBER (3),
    hometeam VARCHAR2 (3) NOT NULL,
    hometeamleague VARCHAR2 (2),
    hometeamgameamount NUMBER (3) NOT NULL,
    timeofday VARCHAR2 (1),
    gamestatus VARCHAR2 (200),
    dateofmakeup date
);

-- add the PK to the table
ALTER TABLE schedule ADD CONSTRAINT schedule_pk PRIMARY KEY (gamedate, hometeam, hometeamgameamount);

-- create ref
CREATE OR REPLACE PUBLIC SYNONYM schedule FOR admin.schedule;

-- after that commit all of the changes made
COMMIT;