------------------------------------------------------------------------
-- https://docs.snowflake.com/en/sql-reference/functions/flatten
------------------------------------------------------------------------

-- Use an array for testing:
with some_data
as (
select array_construct('Hello', 'world', 'good', 'news', 'today') as col_array
)
select TYPEOF(t.col_array) as col_type
     , t.col_array
from some_data as t;

-- Flattens into a table with metadata for each row:
with some_data
as (
select t.* 
from table(flatten(array_construct('Hello', 'world', 'good', 'news', 'today'))) as t
)
select t.*
     , TYPEOF(t.value) as value_type
from some_data as t
;

-- Using LATERAL to Pulls out just the values from the array:
with some_data
as (
select array_construct('Hello', 'world', 'good', 'news', 'today') as col_array
)
select l.value::string as col_string
from some_data as t
   , lateral flatten(input => t.col_array) as l
;

-- Using LATERAL to Pulls out just the values from JSON
with some_data
as (
select col1 as id
     , parse_json(col2) as c
from values
   (12712555,
   '{ name:  { first: "John", last: "Smith"},
     contact: [
     { business:[
       { type: "phone", content:"555-1234" },
       { type: "email", content:"j.smith@company.com" } ] } ] }'),
   (98127771,
   '{ name:  { first: "Jane", last: "Doe"},
     contact: [
     { business:[
       { type: "phone", content:"555-1236" },
       { type: "email", content:"j.doe@company.com" } ] } ] }') as v(col1, col2) 
)
-- Note the multiple instances of LATERAL FLATTEN in the FROM clause of the following query.
-- Each LATERAL view is based on the previous one to refer to elements in
-- multiple levels of arrays.
SELECT id as "ID"
     , f.value AS "Contact"
     , TYPEOF(f.value) as col_type 
     , f1.value:type AS "Type"
     , f1.value:content AS "Details"
FROM some_data p
   , lateral flatten(input => p.c, path => 'contact') f
   , lateral flatten(input => f.value:business) f1
;
