-------------------
-- Assignment 02
-------------------

-- Create database
CREATE DATABASE EXERCISE_DB;

-- Create table
CREATE TABLE "EXERCISE_DB"."PUBLIC"."CUSTOMERS" (
  ID INT,
  first_name varchar,
  last_name varchar,
  email varchar,
  age int,
  city varchar
);

--Loading the data from S3 bucket
COPY INTO "EXERCISE_DB"."PUBLIC"."CUSTOMERS"
   FROM s3://snowflake-assignments-mc/gettingstarted/customers.csv
   file_format = (type = csv 
                  field_delimiter = ',' 
                  skip_header=1);

//Validate
USE DATABASE EXERCISE_DB;

SELECT * FROM customers;
