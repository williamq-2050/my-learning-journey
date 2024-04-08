-------------------
-- Assignment 14
-------------------

--1. Prepare the table and two roles to test the masking policies (you can use the statement below)

USE DEMO_DB;
USE ROLE ACCOUNTADMIN;
 
-- Prepare table --
create or replace table customers(
  id number,
  full_name varchar, 
  email varchar,
  phone varchar,
  spent number,
  create_date DATE DEFAULT CURRENT_DATE);
 
 
-- insert values in table --
insert into customers (id, full_name, email,phone,spent)
values
  (1,'Lewiss MacDwyer','lmacdwyer0@un.org','262-665-9168',140),
  (2,'Ty Pettingall','tpettingall1@mayoclinic.com','734-987-7120',254),
  (3,'Marlee Spadazzi','mspadazzi2@txnews.com','867-946-3659',120),
  (4,'Heywood Tearney','htearney3@patch.com','563-853-8192',1230),
  (5,'Odilia Seti','oseti4@globo.com','730-451-8637',143),
  (6,'Meggie Washtell','mwashtell5@rediff.com','568-896-6138',600);
 
show tables like '%customer%' ;
-- set up roles
CREATE OR REPLACE ROLE ANALYST_MASKED;
CREATE OR REPLACE ROLE ANALYST_FULL;
 
-- grant select on table to roles
GRANT USAGE ON DATABASE DEMO_DB TO ROLE ANALYST_MASKED;
GRANT USAGE ON DATABASE DEMO_DB TO ROLE ANALYST_FULL;

GRANT USAGE ON SCHEMA DEMO_DB.PUBLIC TO ROLE ANALYST_MASKED;
GRANT USAGE ON SCHEMA DEMO_DB.PUBLIC TO ROLE ANALYST_FULL;

GRANT SELECT ON TABLE DEMO_DB.PUBLIC.CUSTOMERS TO ROLE ANALYST_MASKED;
GRANT SELECT ON TABLE DEMO_DB.PUBLIC.CUSTOMERS TO ROLE ANALYST_FULL;
 
-- grant warehouse access to roles
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE ANALYST_MASKED;
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE ANALYST_FULL;
 
-- assign roles to a user
GRANT ROLE ANALYST_MASKED TO USER wquintero;
GRANT ROLE ANALYST_FULL TO USER wquintero;


-- 2. Create masking policy called name_mask that is showing '***' instead of the original varchar value except the role analyst_full is used in this case show the original value.
CREATE OR REPLACE MASKING POLICY name_mask 
AS (val varchar) RETURNS varchar ->
case        
    when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
    else '***'
end;

-- List and describe policies
SHOW MASKING POLICIES;
DESC MASKING POLICY name_mask;

-- Show columns with applied policies
SELECT * 
FROM table(information_schema.policy_references(policy_name=>'name_mask'));


-- 3. Apply the masking policy on the column full_name
ALTER TABLE IF EXISTS CUSTOMERS MODIFY COLUMN full_name 
SET MASKING POLICY name_mask;

-- Show columns with applied policies
SELECT * 
FROM table(information_schema.policy_references(policy_name=>'name_mask'));

-- 4. Validate the result using the role analyst_masked and analyst_full
USE ROLE ANALYST_FULL;
SELECT * FROM DEMO_DB.PUBLIC.CUSTOMERS;

USE ROLE ANALYST_MASKED;
SELECT * FROM CUSTOMERS;

-- 5. Unset the policy
USE ROLE ACCOUNTADMIN;

ALTER TABLE IF EXISTS CUSTOMERS MODIFY COLUMN full_name
UNSET MASKING POLICY;

-- 6. Alter the policy so that the last two characters are shown and before that only '***' (example: ***er)
CREATE OR REPLACE MASKING POLICY name_mask 
AS (val varchar) RETURNS varchar ->
case        
    when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
    else CONCAT('*******', RIGHT(val,2))
end;

-- 7. Apply the policy again on the column full name and validate the policy
ALTER TABLE IF EXISTS CUSTOMERS MODIFY COLUMN full_name 
SET MASKING POLICY name_mask;

USE ROLE ANALYST_FULL;
SELECT * FROM CUSTOMERS;

USE ROLE ANALYST_MASKED;
SELECT * FROM CUSTOMERS;

-- 8. Alter existing policies 
USE ROLE ACCOUNTADMIN;

ALTER MASKING POLICY name_mask SET BODY ->
case        
    when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
    else CONCAT(LEFT(val,2), '*******', RIGHT(val,1))
end;

USE ROLE ANALYST_FULL;
SELECT * FROM CUSTOMERS;

USE ROLE ANALYST_MASKED;
SELECT * FROM CUSTOMERS;

--- Table definiton
/*
create or replace TRANSIENT TABLE DEMO_DB.PUBLIC.CUSTOMERS (
	ID NUMBER(38,0),
	FULL_NAME VARCHAR(16777216) WITH MASKING POLICY DEMO_DB.PUBLIC.NAME_MASK,
	EMAIL VARCHAR(16777216),
	PHONE VARCHAR(16777216),
	SPENT NUMBER(38,0),
	CREATE_DATE DATE DEFAULT CURRENT_DATE()
);
*/