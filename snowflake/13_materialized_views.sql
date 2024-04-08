-------------------
-- Assignment 13
-------------------

USE DATABASE DEMO_DB;

-- 1. Create a materialized view called PARTS 
--    in the database DEMO_DB from the following statement:
CREATE OR REPLACE MATERIALIZED VIEW DEMO_DB.PUBLIC.PARTS_MV
AS 
SELECT 
AVG(PS_SUPPLYCOST) as PS_SUPPLYCOST_AVG,
AVG(PS_AVAILQTY) as PS_AVAILQTY_AVG,
MAX(PS_COMMENT) as PS_COMMENT_MAX
FROM"SNOWFLAKE_SAMPLE_DATA"."TPCH_SF100"."PARTSUPP"
;

-- Execute the SELECT before creating the materialized view 
-- and note down the time until the query is executed.


-- Questions for this assignment

-- How long did the SELECT statement take initially?
-- 10s

-- How long did the execution of the materialized view take?
-- 6.9s