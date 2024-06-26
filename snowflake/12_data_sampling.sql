-------------------
-- Assignment 12
-------------------


-- 1. Sample 5% from the table "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."CUSTOMER_ADDRESS"
--    Use the ROW method and seed(2) to get a reproducible result.
--    Store the result in the DEMO_DB in a table called CUSTOMER_ADDRESS_SAMPLE_5.
CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.CUSTOMER_ADDRESS_SAMPLE_5
AS
SELECT *
FROM "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."CUSTOMER_ADDRESS"
SAMPLE ROW(5) SEED(2)
;


-- 2. Sample 1% from the table "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."CUSTOMER"
--    Use the SYSTEM method and seed(2) to get a reproducible result.
--    Store the result in the DEMO_DB in a table called CUSTOMER_SAMPLE_1.
CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.CUSTOMER_SAMPLE_1
AS
SELECT *
FROM "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."CUSTOMER"
SAMPLE SYSTEM(1) SEED(2)
;

-- 3. Questions for this assignment
--    How many rows are in the second created table CUSTOMER_SAMPLE_1?
select count(*) from DEMO_DB.PUBLIC.CUSTOMER_SAMPLE_1;