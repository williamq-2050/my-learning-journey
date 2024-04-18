-- It is a metadata operation
-- At SCHEMA and TABLE level

-- Create OUR_FIRST_DB
-------------------------
CREATE DATABASE OUR_FIRST_DB;
USE DATABASE OUR_FIRST_DB;
CREATE SCHEMA OUR_FIRST_DB.CUST_SCHEMA;
CREATE TABLE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER
AS
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER LIMIT 100;

-- Clone Databases
-------------------------
CREATE OR REPLACE TRANSIENT DATABASE OUR_FIRST_DB_CLONE
CLONE OUR_FIRST_DB;

CREATE OR REPLACE TRANSIENT DATABASE OUR_SECOND_DB_CLONE
CLONE OUR_FIRST_DB;

-- Clone Schema
-------------------------
CREATE SCHEMA OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE
CLONE OUR_FIRST_DB_CLONE.CUST_SCHEMA;

-- Clone Table
-------------------------
CREATE OR REPLACE TABLE OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER_CLONE
CLONE OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER;

-- Change some data
------------------------
UPDATE OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER_CLONE
SET C_ADDRESS = NULL;

SELECT COUNT(*) FROM OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER WHERE C_ADDRESS IS NULL;
SELECT COUNT(*) FROM OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER_CLONE WHERE C_ADDRESS IS NULL;

-- SWAP tables
---------------------
ALTER TABLE OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER
SWAP WITH OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER_CLONE;

SELECT COUNT(*) FROM OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER WHERE C_ADDRESS IS NULL;
SELECT COUNT(*) FROM OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER_CLONE WHERE C_ADDRESS IS NULL;

-- SWAP schemas
---------------------
ALTER SCHEMA OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE
SWAP WITH OUR_FIRST_DB_CLONE.CUST_SCHEMA;

SELECT COUNT(*) FROM OUR_FIRST_DB_CLONE.CUST_SCHEMA_CLONE.CUSTOMER WHERE C_ADDRESS IS NULL;
SELECT COUNT(*) FROM OUR_FIRST_DB_CLONE.CUST_SCHEMA.CUSTOMER WHERE C_ADDRESS IS NULL;

