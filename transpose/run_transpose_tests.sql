-- Johnny Chan, 2015-09-11

-- Illustrate how to transpose a table in SQL, from vertical to horizontal (and vice versa)
-- Run this code once the build_schema.sql has been run (to setup table structures).

-- prepare base table
INSERT INTO mytable VALUES (1, 'A', 34.4);
INSERT INTO mytable VALUES (1, 'B', 32.1);
INSERT INTO mytable VALUES (1, 'C', 29.1);
INSERT INTO mytable VALUES (2, 'A', 32.4);
INSERT INTO mytable VALUES (2, 'B', 35.2);
INSERT INTO mytable VALUES (2, 'C', 35.6);

-- let's take a look: mytable (the sample vertical table)
SELECT scanid, region, volume FROM mytable;

-- transpose that table (from vertical to horizontal)
INSERT INTO mytable2 (scanid, A_volume, B_volume, C_volume) (
	SELECT 
	    A.scanid,
	    A.volume AS A_volume,
	    B.volume AS B_volume,
	    C.volume AS C_volume
	FROM
	    mytable A INNER JOIN
	    mytable B ON (A.scanid = B.scanid) INNER JOIN
	    mytable C ON (B.scanid = C.scanid)
	WHERE
	    A.region = 'A' AND
	    B.region = 'B' AND
	    C.region = 'C'
);

-- let's take a look (the new horizontal table)
SELECT scanid, A_volume, B_volume, C_volume FROM mytable2;


-- let's transpose from horizontal to vertical!
INSERT INTO mytable3 (scanid, region, volume) (
	SELECT
		stack.scanid AS scanid,
		stack.region AS region,
		stack.volume AS volume
	FROM (
		select scanid, 'A' AS region, a_volume AS volume FROM mytable2
		union
		select scanid, 'B' AS region, b_volume AS volume FROM mytable2
		union
		select scanid, 'C' AS region, c_volume AS volume FROM mytable2
	) stack
	ORDER BY scanid, region
);

-- let's take a look (the new vertical table)
SELECT scanid, region, volume FROM mytable3;