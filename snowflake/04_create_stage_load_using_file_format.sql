-------------------
-- Assignment 04
-------------------

USE DATABASE exercise_db;


-- Create SCHEMAS
CREATE OR REPLACE SCHEMA my_external_stages;
CREATE OR REPLACE SCHEMA my_data;


-- Create STAGE object
CREATE OR REPLACE STAGE EXERCISE_DB.my_external_stages.aws_stage
    url='s3://snowflake-assignments-mc/fileformat/'
;

-- Describe STAGE
DESC STAGE EXERCISE_DB.my_external_stages.aws_stage;

-- List files
LIST @my_external_stages.aws_stage;

-- Take a pick at the format
SELECT t.$1
FROM @my_external_stages.aws_stage t
LIMIT 10;

-- Create a file format
CREATE OR REPLACE FILE FORMAT my_external_stages.my_customers_format
  TYPE = 'csv' 
  FIELD_DELIMITER = '|'
  SKIP_HEADER=1
;


-- Create table
CREATE OR REPLACE TABLE EXERCISE_DB.MY_DATA."CUSTOMERS" (
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
    file_format = my_external_stages.my_customers_format
    files = ('customers4.csv');
