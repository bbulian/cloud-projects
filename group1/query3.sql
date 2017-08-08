SELECT
  DayOfWeek AS Weekday,
  round(avg(ArrDelay),2) as avg_delay
FROM aviation
WHERE cancelled = 0
GROUP BY DayOfWeek
ORDER BY avg_delay;

-- Query ID = hadoop_20170808185910_58c60324-1b01-4def-a899-b5d91c639bf9
-- Total jobs = 1
-- Launching Job 1 out of 1
--
--
-- Status: Running (Executing on YARN cluster with App id application_1502175039084_0016)
--
-- ----------------------------------------------------------------------------------------------
--         VERTICES      MODE        STATUS  TOTAL  COMPLETED  RUNNING  PENDING  FAILED  KILLED
-- ----------------------------------------------------------------------------------------------
-- Map 1 .......... container     SUCCEEDED     33         33        0        0       0       0
-- Reducer 2 ...... container     SUCCEEDED     20         20        0        0       0       0
-- Reducer 3 ...... container     SUCCEEDED      1          1        0        0       0       0
-- ----------------------------------------------------------------------------------------------
-- VERTICES: 03/03  [==========================>>] 100%  ELAPSED TIME: 29.01 s
-- ----------------------------------------------------------------------------------------------
-- OK
-- 6	4.3
-- 2	5.99
-- 7	6.61
-- 1	6.72
-- 3	7.2
-- 4	9.09
-- 5	9.72
-- Time taken: 29.936 seconds, Fetched: 7 row(s)

-- //////

SELECT
  total.dayofweek AS dayofweek,
  100.0 * ontime.nr_flights / total.nr_flights AS ontime_arrival
FROM
  (SELECT dayofweek, count(flightnum) AS nr_flights FROM aviation WHERE cancelled = 0 GROUP BY dayofweek) total
  JOIN
  (SELECT dayofweek, count(flightnum) AS nr_flights FROM aviation WHERE cancelled = 0 AND arrdelayminutes = 0 GROUP BY dayofweek) ontime
  ON total.dayofweek = ontime.dayofweek
ORDER BY ontime_arrival DESC
LIMIT 10;


-- hive> SELECT
--     >   total.dayofweek AS dayofweek,
--     >   100.0 * ontime.nr_flights / total.nr_flights AS ontime_arrival
--     > FROM
--     >   (SELECT dayofweek, count(flightnum) AS nr_flights FROM aviation WHERE cancelled = 0 GROUP BY dayofweek) total
--     >   JOIN
--     >   (SELECT dayofweek, count(flightnum) AS nr_flights FROM aviation WHERE cancelled = 0 AND arrdelayminutes = 0 GROUP BY dayofweek) ontime
--     >   ON total.dayofweek = ontime.dayofweek
--     > ORDER BY ontime_arrival DESC
--     > ;
-- Query ID = hadoop_20170728200442_8c2c9309-b3a4-4d9b-ad28-e6fd3e3251cf
-- Total jobs = 1
-- Launching Job 1 out of 1
--
--
-- Status: Running (Executing on YARN cluster with App id application_1501268061716_0007)
--
-- ----------------------------------------------------------------------------------------------
--         VERTICES      MODE        STATUS  TOTAL  COMPLETED  RUNNING  PENDING  FAILED  KILLED
-- ----------------------------------------------------------------------------------------------
-- Map 1 .......... container     SUCCEEDED     67         67        0        0       0       0
-- Map 5 .......... container     SUCCEEDED     67         67        0        0       0       0
-- Reducer 2 ...... container     SUCCEEDED     16         16        0        0       0       0
-- Reducer 3 ...... container     SUCCEEDED     12         12        0        0       0       0
-- Reducer 4 ...... container     SUCCEEDED      1          1        0        0       0       0
-- Reducer 6 ...... container     SUCCEEDED      8          8        0        0       0       0
-- ----------------------------------------------------------------------------------------------
-- VERTICES: 06/06  [==========================>>] 100%  ELAPSED TIME: 30.13 s
-- ----------------------------------------------------------------------------------------------
-- OK
-- dayofweek	ontime_arrival
-- 6	57.13029576609161
-- 2	53.721914013968274
-- 7	53.22532201699457
-- 1	52.905269532758574
-- 3	51.5274953827783
-- 4	48.17019913144984
-- 5	47.22778056488582
-- Time taken: 31.23 seconds, Fetched: 7 row(s)
