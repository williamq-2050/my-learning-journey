-- Producer Account creates SHARE (Read-Only)
-- Consumer Account creates Database FROM SHARE 
-- For non-Snowflake users, create a Reader Account to be used as a Consumer

-- Create OUR_FIRST_DB
-------------------------
CREATE DATABASE OUR_FIRST_DB;
USE DATABASE OUR_FIRST_DB;
CREATE SCHEMA OUR_FIRST_DB.CUST_SCHEMA;
CREATE TABLE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER
AS
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER LIMIT 100;

-- Create a share object
-------------------------
CREATE OR REPLACE SHARE CUSTOMER_SHARE;

-- Grant usage on database
GRANT USAGE ON DATABASE OUR_FIRST_DB TO SHARE CUSTOMER_SHARE; 

-- Grant usage on schema
GRANT USAGE ON SCHEMA OUR_FIRST_DB.CUST_SCHEMA TO SHARE CUSTOMER_SHARE; 

-- Grant SELECT on table
GRANT SELECT ON TABLE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER TO SHARE CUSTOMER_SHARE; 

-- Validate Grants
SHOW GRANTS TO SHARE CUSTOMER_SHARE;


-- Add existing Snowflake Consumer Account (see first part of URL)
---------------------------------------------
ALTER SHARE CUSTOMER_SHARE ADD ACCOUNT=<consumer-account-id>;


--------------------------------------
------ For non-Snowflake users
------ Creates a READER account
--------------------------------------

-- Create Reader Account
--------------------------
CREATE MANAGED ACCOUNT wq_reader_account_01
ADMIN_NAME = wqreaderadmin,
ADMIN_PASSWORD = 'admi1n@WQ0#0',
TYPE = READER;
/*
{
    "accountName":"WQ_READER_ACCOUNT_01",
    "accountLocator":"MA41551",
    "url":"https://kmhiiea-wq_reader_account_01.snowflakecomputing.com",
    "accountLocatorUrl":"https://ma41551.ca-central-1.aws.snowflakecomputing.com"
}
*/
-- Make sure to have selected the role of accountadmin
------------------------------------------------------
-- Show accounts
SHOW MANAGED ACCOUNTS;

-- Add Snowflake reader Account (see accountLocator)
---------------------------------------------
ALTER SHARE CUSTOMER_SHARE ADD ACCOUNT = <reader-account-id>;
--SHARE_RESTRICTIONS=false;


----------------------------------------------------------------------------
------ Connect to the Reader account (see accountLocatorUrl)
-- https://ma41551.ca-central-1.aws.snowflakecomputing.com
-- User: wqreaderadmin
----------------------------------------------------------------------------

USE ROLE ACCOUNTADMIN;

-- Show all shares (consumer and producers)
SHOW SHARES;

-- See details on share (<owner_account>.<share name>)
DESC SHARE KMHIIEA.PC02145.CUSTOMER_SHARE;

-- Create a database in consumer account using the share
CREATE DATABASE DATA_SHARE_DB FROM SHARE KMHIIEA.PC02145.CUSTOMER_SHARE;

-- Setup virtual warehouse
CREATE WAREHOUSE READ_WH WITH
WAREHOUSE_SIZE='X-SMALL'
AUTO_SUSPEND = 180
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE;

-- Validate table access
SELECT * 
FROM  DATA_SHARE_DB.CUST_SCHEMA.CUSTOMER;


-- Keep control of the ACCOUNTADMIN, creating less privileged users
----------------------------------------------------------------------

-- Create role and user
CREATE ROLE USE_DATA_FROM_SHARE;
CREATE USER M1RIAM PASSWORD = 'OmG_passw@ord=123';
GRANT ROLE USE_DATA_FROM_SHARE TO USER M1RIAM;

-- Grant usage on warehouse
GRANT USAGE ON WAREHOUSE READ_WH TO ROLE USE_DATA_FROM_SHARE;

-- Grating privileges on a Shared Database for other users
GRANT IMPORTED PRIVILEGES ON DATABASE DATA_SHARE_DB TO ROLE USE_DATA_FROM_SHARE;

----------------------------------------------------------------------------
------ Connect to the Reader account (see accountLocatorUrl)
-- https://ma41551.ca-central-1.aws.snowflakecomputing.com
-- User: M1RIAM
----------------------------------------------------------------------------
SELECT * 
FROM  DATA_SHARE_DB.CUST_SCHEMA.CUSTOMER;


-- Changes in the Producer account are available in the Consumer account
UPDATE OUR_FIRST_DB.CUST_SCHEMA.CUSTOMER
SET C_ADDRESS = CONCAT(C_ADDRESS, ' HOLA')
WHERE C_CUSTKEY = 60001;
