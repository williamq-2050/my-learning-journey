-------------------
-- Assignment 08
-------------------

-- 0. Create database and schemas
CREATE OR REPLACE DATABASE COPY_DB;

USE DATABASE COPY_DB;

CREATE OR REPLACE SCHEMA my_external_stages;

CREATE OR REPLACE SCHEMA my_data;

-- See Assignment 07
-- 1. Query from the previously created JSON_RAW  table. 
SELECT *
FROM my_data.JSON_RAW
;

--2. Select the attributes 
SELECT raw_column:id::int as id
     , raw_column:first_name::string as first_name
     , raw_column:last_name::string as last_name
     , raw_column:Skills
FROM my_data.JSON_RAW
;

--3. The skills column contains an array.
SELECT raw_column:id::int as id
     , raw_column:first_name::string as first_name
     , raw_column:last_name::string as last_name
     , raw_column:Skills[0]::string as skills_1
     , raw_column:Skills[1]::string as skills_2
     , ARRAY_SIZE(raw_column:Skills) as total_skills
     , raw_column:Skills
FROM my_data.JSON_RAW
;
--4. Create a table and insert the data for these 4 columns in that table
CREATE OR REPLACE TABLE my_data.table_from_json AS
SELECT raw_column:id::int as id
     , raw_column:first_name::string as first_name
     , raw_column:last_name::string as last_name
     , raw_column:Skills[0]::string as skills_1
     , raw_column:Skills[1]::string as skills_2
     , ARRAY_SIZE(raw_column:Skills) as total_skills
FROM my_data.JSON_RAW
;

--
SELECT t.*
FROM my_data.table_from_json t
WHERE t.FIRST_NAME = 'Florina'
;
