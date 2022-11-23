CREATE TABLE SCHEDULE (
    GameDate                DATE NOT NULL,
    NumberOfGames           VARCHAR2(1),
    DayOfWeek               VARCHAR2(3),
    VisitingTeam            VARCHAR2(3),
    VisitingTeamLeague      VARCHAR2(2),
    VisitingTeamGameAmount  NUMBER(3),
    HomeTeam                VARCHAR2(3) NOT NULL,
    HomeTeamLeague          VARCHAR2(2),
    HomeTeamGameAmount      NUMBER(3) NOT NULL,
    TimeOfDay               VARCHAR2(1),
    GameStatus              VARCHAR2(200),
    DateOfMakeup            VARCHAR2(200)
);



ALTER TABLE SCHEDULE ADD CONSTRAINT SCHEDULE_PK PRIMARY KEY (GameDate, HomeTeam, HomeTeamGameAmount);