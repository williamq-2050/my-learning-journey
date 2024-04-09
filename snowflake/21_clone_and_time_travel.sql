-- It is a metadata operation
-- After the clone operation objects are independent
-- Incurs in additional storage cost for the changes
-- At DATABASE, SCHEMA, and TABLE level
-- TEMPORARY table to PERMANENT table not allowed

-- Create OUR_FIRST_DB
-------------------------
CREATE DATABASE OUR_FIRST_DB;
USE DATABASE OUR_FIRST_DB;
CREATE SCHEMA OUR_FIRST_DB.CUST_SCHEMA;
CREATE TABLE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER
AS
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER LIMIT 100;

-- Clone Database
-------------------------
CREATE TRANSIENT DATABASE OUR_FIRST_DB_CLONE
CLONE OUR_FIRST_DB;

-- Clone Schema same database
-------------------------
CREATE TRANSIENT SCHEMA OUR_FIRST_DB.CUST_SAME_DB_CLONE
CLONE OUR_FIRST_DB.CUST_SCHEMA;

-- Clone Schema differenct database
-------------------------
CREATE TRANSIENT SCHEMA OUR_FIRST_DB_CLONE.CUST_OTHER_DB_CLONE
CLONE OUR_FIRST_DB.CUST_SCHEMA;

-- Clone Table
-------------------------
CREATE OR REPLACE TABLE OUR_FIRST_DB_CLONE.CUST_OTHER_DB_CLONE.CUSTOMER_CLONE
CLONE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER;

-- Clone non TEMPORARY to a TEMPORARY Table
-------------------------
CREATE TEMPORARY TABLE OUR_FIRST_DB_CLONE.CUST_SCHEMA.CUSTOMER_TMP
CLONE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER;

-- Clone TEMPORARY Table to a TEMPORARY 
-------------------------
CREATE TEMPORARY TABLE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER_TMP_FROM_TMP
CLONE OUR_FIRST_DB_CLONE.CUST_SCHEMA.CUSTOMER_TMP;

-- Clone TEMPORARY Table to a TRANSIENT table
-------------------------
CREATE TRANSIENT TABLE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER_TRANSIENT_FROM_TMP
CLONE OUR_FIRST_DB_CLONE.CUST_SCHEMA.CUSTOMER_TMP;

-- OUR_FIRST_DB_CLONE is TRANSIENT
CREATE TABLE OUR_FIRST_DB_CLONE.CUST_SCHEMA.CUSTOMER_FROM_TMP
CLONE OUR_FIRST_DB_CLONE.CUST_SCHEMA.CUSTOMER_TMP;

-- FAILS: Clone TEMPORARY Table to a PERMANENT Table
--------------------------------------------------
CREATE TABLE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER_FROM_TMP
CLONE OUR_FIRST_DB_CLONE.CUST_SCHEMA.CUSTOMER_TMP;

-- Clone Table with time travel
---------------------------------
CREATE OR REPLACE TABLE OUR_FIRST_DB_CLONE.CUST_OTHER_DB_CLONE.CUSTOMER_CLONE
CLONE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER BEFORE (STATEMENT => '<your-query-id>');

CREATE OR REPLACE TABLE OUR_FIRST_DB_CLONE.CUST_OTHER_DB_CLONE.CUSTOMER_CLONE
CLONE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER BEFORE (TIMESTAMP => 'your-timestamp'::timestamp_tz);

CREATE OR REPLACE TABLE OUR_FIRST_DB_CLONE.CUST_OTHER_DB_CLONE.CUSTOMER_CLONE
CLONE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER AT (OFFSET => -60*1.5);
