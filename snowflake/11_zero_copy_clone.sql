-------------------
-- Assignment 11
-------------------


-- 1. Create exercise table

-- Switch to role of accountadmin --
 
USE ROLE ACCOUNTADMIN;
CREATE OR REPLACE TRANSIENT DATABASE DEMO_DB;
USE WAREHOUSE COMPUTE_WH;
 
CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.SUPPLIER
AS
SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."SUPPLIER" LIMIT 100;


-- 2. Create a clone of that table called SUPPLIER_CLONE
CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.SUPPLIER_CLONE
CLONE DEMO_DB.PUBLIC.SUPPLIER;

-- 3. Update the clone table and copy the query id
UPDATE SUPPLIER_CLONE
SET S_PHONE='###';
 
--> Query ID: Query - 01b383bd-3201-2b92-0005-4cb60001fda2


-- 4. Create another clone from the updated clone using the time travel feature to clone before the update has been executed.
CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.SUPPLIER_CLONE_BEFORE
CLONE DEMO_DB.PUBLIC.SUPPLIER before (statement => '01b383bd-3201-2b92-0005-4cb60001fda2');

-- 5. validate
SELECT S_PHONE FROM DEMO_DB.PUBLIC.SUPPLIER_CLONE;
SELECT S_PHONE FROM DEMO_DB.PUBLIC.SUPPLIER_CLONE_BEFORE;

-- 6. drop source and check clone.
show tables;
DROP TABLE DEMO_DB.PUBLIC.SUPPLIER;
show tables;
