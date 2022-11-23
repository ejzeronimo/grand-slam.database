/* 
NOTE: creates the table for transactions
*/

-- drop the old table
DROP TABLE transactions CASCADE CONSTRAINTS;

-- make the table schema
CREATE TABLE transactions (
    primarydate date, 
    time NUMBER (1, 0), 
    primarydateisapproximate NUMBER (1, 0), 
    secondarydate date, 
    secondarydateisapproximate NUMBER (1, 0), 
    transactionid VARCHAR2 (5) NOT NULL, 
    playerid VARCHAR2 (8) NOT NULL, 
    type VARCHAR2 (2) NOT NULL, 
    fromteam VARCHAR2 (32), 
    fromleague VARCHAR2 (32), 
    toteam VARCHAR2 (32), 
    toleague VARCHAR2 (32), 
    drafttype VARCHAR2 (3), 
    draftround NUMBER (2, 0), 
    picknumber NUMBER (2, 0), 
    otherinformation VARCHAR2 (512)
);

-- add the PK to the table
ALTER TABLE transactions ADD CONSTRAINT transactions_pk PRIMARY KEY (transactionid);

-- create ref
CREATE OR REPLACE PUBLIC SYNONYM transactions FOR admin.transactions;

-- after that commit all of the changes made
COMMIT;