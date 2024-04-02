-------------------
-- Assignment 01
-------------------

-- Use one of these roles: SYSADMIN, SECURITYADMIN, or ACCOUNTADMIN
USE ROLE SYSADMIN;

-- Create WAREHOUSE, that automatically suspend after 10 minutes of not being used and resumes when needed
CREATE WAREHOUSE EXERCISE_WH
WAREHOUSE_SIZE = XSMALL
AUTO_SUSPEND = 600  
AUTO_RESUME = TRUE 
COMMENT = 'This is a virtual warehouse of size X-SMALL';

-- To drop
DROP WAREHOUSE EXERCISE_WH;
