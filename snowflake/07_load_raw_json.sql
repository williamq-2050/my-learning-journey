-------------------
-- Assignment 07
-------------------

-- 0. Create database and schemas
CREATE OR REPLACE DATABASE COPY_DB;

USE DATABASE COPY_DB;

CREATE OR REPLACE SCHEMA my_external_stages;

CREATE OR REPLACE SCHEMA my_data;

-- 1. Create a stage object 
CREATE OR REPLACE STAGE COPY_DB.my_external_stages.aws_stage_copy
    url='s3://snowflake-assignments-mc/unstructureddata/';
  
LIST @COPY_DB.my_external_stages.aws_stage_copy;

-- 2. Create a file format object
CREATE OR REPLACE FILE FORMAT my_external_stages.my_file_format
  TYPE = JSON
;

-- 3. Create a table called JSON_RAW
CREATE OR REPLACE TABLE COPY_DB.my_data.JSON_RAW (
  raw_column variant
);
    
-- 4. Use the copy option to only validate if there are errors
COPY INTO COPY_DB.my_data.JSON_RAW
    FROM @my_external_stages.aws_stage_copy
    file_format = my_external_stages.my_file_format
;

SELECT *
FROM my_data.JSON_RAW
;

