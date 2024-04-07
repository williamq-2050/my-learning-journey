-------------------
-- Assignment 09
-------------------

-- 1. Create exercise table
-- Switch to role of accountadmin --
 
USE ROLE ACCOUNTDMIN;
USE DATABASE DEMO_DB;
USE WAREHOUSE COMPUTE_WH;
 
CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.PART
AS
SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."PART";
 
SELECT P_MFGR, count(*) cnt 
FROM PART
GROUP BY P_MFGR
ORDER BY P_MFGR DESC;

-- Query - 01b3801a-3201-2a7f-0005-4cb600019f16

-- 2. Update the table

UPDATE DEMO_DB.PUBLIC.PART
SET P_MFGR='Manufacturer#CompanyX'
WHERE P_MFGR='Manufacturer#5';
 
----> Note down query id here: Query - 01b3801b-3201-2a7f-0005-4cb600019f4e
----> Or go to Monitoring / Query History
SELECT P_MFGR, count(*) cnt 
FROM PART
GROUP BY P_MFGR
ORDER BY P_MFGR DESC;


-- 3.1: Travel back using the offset until you get the result of before the update
SELECT P_MFGR, count(*) cnt 
FROM PART at (OFFSET => -60*8)
GROUP BY P_MFGR
ORDER BY P_MFGR DESC;

-- 3.2: Travel back using the query id to get the result before the update
SELECT P_MFGR, count(*) cnt 
FROM PART before (statement => '01b3801b-3201-2a7f-0005-4cb600019f4e')
GROUP BY P_MFGR
ORDER BY P_MFGR DESC;

-- 3.3: Travel back using the timestamp to get the result before the update
SHOW PARAMETERS like '%timezone%';
-- America/Los_Angeles
ALTER SESSION SET TIMEZONE ='UTC'
SELECT DATEADD(MINUTE, -10, CURRENT_TIMESTAMP)

SELECT P_MFGR, count(*) cnt 
FROM PART before (timestamp => '2024-04-07 02:35:19.948'::timestamp)
GROUP BY P_MFGR
ORDER BY P_MFGR DESC;

ALTER SESSION SET TIMEZONE ='America/Los_Angeles';
SHOW PARAMETERS like '%timezone%';