CREATE TABLE EJECTIONS (
    RetrosheetID    VARCHAR2(12) NOT NULL,
    Date            DATE,
    GameNumber      VARCHAR2(2),
    PlayerID        VARCHAR2(8) NOT NULL,
    PlayerName      VARCHAR2(30),
    Team            VARCHAR2(3),
    PlayerRole      VARCHAR2(1),
    UmpireID        VARCHAR2(8),
    UmpireName      VARCHAR2(30),
    Inning          VARCHAR2(2),
    Reason          VARCHAR2(500)
);



ALTER TABLE EJECTIONS ADD CONSTRAINT EJECTIONS_PK PRIMARY KEY (RetrosheetID, PlayerID);