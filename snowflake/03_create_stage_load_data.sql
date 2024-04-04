-------------------
-- Assignment 03
-------------------

USE DATABASE exercise_db;


-- Create SCHEMAS
CREATE OR REPLACE SCHEMA my_external_stages;
CREATE SCHEMA my_data;


-- Create STAGE object
CREATE OR REPLACE STAGE EXERCISE_DB.my_external_stages.aws_stage
    url='s3://snowflake-assignments-mc/loadingdata/'
;

-- Describe STAGE
DESC STAGE EXERCISE_DB.my_external_stages.aws_stage;

-- List files
LIST @my_external_stages.aws_stage;

-- Create table
CREATE TABLE EXERCISE_DB.MY_DATA."CUSTOMERS" (
  ID INT,
  first_name varchar,
  last_name varchar,
  email varchar,
  age int,
  city varchar
);

-- Load data: customers1.csv, customers2.csv
COPY INTO EXERCISE_DB.my_data.CUSTOMERS 
    FROM @my_external_stages.aws_stage
    file_format= (type = csv field_delimiter=';' skip_header=1)
    pattern='.*customers.*';


--- https://docs.snowflake.com/en/user-guide/querying-metadata
-- Create a file format
CREATE OR REPLACE FILE FORMAT my_customers_format
  TYPE = 'csv' FIELD_DELIMITER = ',';

-- Query the filename and row number metadata columns and the regular data columns in the staged file
-- Note that the table alias is provided to make the statement easier to read and is not required
SELECT METADATA$FILENAME
     , METADATA$FILE_ROW_NUMBER
     , METADATA$FILE_CONTENT_KEY
     , METADATA$FILE_LAST_MODIFIED
     , METADATA$START_SCAN_TIME
     , t.$1
     , t.$2 
     FROM @my_external_stages.aws_stage(file_format => my_customers_format) t
     LIMIT 10;
