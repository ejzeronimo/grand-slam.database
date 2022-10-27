/* NOTE: create a test table*/
CREATE TABLE test (
    hello VARCHAR2 (50)
);
-- insert a test record
INSERT INTO test (
    hello
) VALUES (
    'world'
);
-- check if they have the test table
SELECT * from test;
-- create ref
CREATE OR REPLACE PUBLIC SYNONYM test for admin.test;