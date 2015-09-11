-- Johnny Chan, 2015-09-11

-- Illustrate how to transpose a table in SQL, from vertical to horizontal (and vice versa)
-- This code build the schema for this exercise.

-- Sample table: in vertical format
CREATE TABLE mytable (
  scanid INT,
  region VARCHAR(3),
  volume NUMERIC
);

-- For Test 1: transpose vertical table to this horizontal table
CREATE TABLE mytable2 (
  scanid INT,
  A_volume NUMERIC,
  B_volume NUMERIC,
  C_volume NUMERIC  
);

-- For Test 2: transpose horizontal table to this vertical format
CREATE TABLE mytable3 (
  scanid INT,
  region VARCHAR(3),
  volume NUMERIC
);
