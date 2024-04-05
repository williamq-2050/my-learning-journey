-------------------
-- Assignment 06
-------------------

-- 1. Create a table called employees
CREATE OR REPLACE DATABASE COPY_DB;

USE DATABASE COPY_DB;

CREATE OR REPLACE SCHEMA my_external_stages;

CREATE OR REPLACE SCHEMA my_data;

CREATE OR REPLACE TABLE COPY_DB.my_data.EMPLOYEES (
  customer_id int,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(50),
  age int,
  department varchar(50)
);

-- 2. Create a stage object 
CREATE OR REPLACE STAGE COPY_DB.my_external_stages.aws_stage_copy
    url='s3://snowflake-assignments-mc/copyoptions/example2';
  
LIST @COPY_DB.my_external_stages.aws_stage_copy;

-- Take a pick at the format
CREATE OR REPLACE FILE FORMAT my_external_stages.my_file_format
  TYPE = CSV
  FIELD_DELIMITER = '|'
;

SELECT t.$1
FROM @my_external_stages.aws_stage_copy(file_format => my_external_stages.my_file_format) t
LIMIT 5;

-- 3. Create a file format object
CREATE OR REPLACE FILE FORMAT my_external_stages.my_file_format
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER=1
;
    
 -- 4. Use the copy option to only validate if there are errors
COPY INTO COPY_DB.my_data.EMPLOYEES
    FROM @my_external_stages.aws_stage_copy
    file_format = my_external_stages.my_file_format
    pattern='.*employee.*'
    VALIDATION_MODE = RETURN_ERRORS
;

--- 5. One value in the first_name column has more than 50 characters
COPY INTO COPY_DB.my_data.EMPLOYEES
    FROM @my_external_stages.aws_stage_copy
    file_format = my_external_stages.my_file_format
    pattern='.*employee.*'
    TRUNCATECOLUMNS = true
;