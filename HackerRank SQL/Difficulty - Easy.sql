-------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- Hackerrank SQL Exercise -------------------------------------------------
---------------------------------------------------Difficulty : Easy-----------------------------------------------------

/* Revising the Select Query I*/
select * from CITY where POPULATION>100000 and COUNTRYCODE = 'USA'

/* Revising the Select Query II */
select NAME from CITY where POPULATION>120000 and COUNTRYCODE='USA'

/* Select All */
select * from CITY;

/*Select By ID */
select * from CITY where id=1661

/*Japanese Cities' Attributes*/
select * from CITY where COUNTRYCODE='JPN'

/*Japanese Cities' Names*/
select NAME from CITY where COUNTRYCODE='JPN'

/*Weather Observation Station*/ 
-- 1
SELECT CITY,STATE FROM STATION

-- 2
select cast(sum(LAT_N) as decimal(18,2)),cast(sum(LONG_W) as decimal(18,2)) from STATION

-- 3
SELECT DISTINCT(CITY) FROM STATION WHERE ID%2=0

-- 4
SELECT COUNT(CITY)-COUNT(DISTINCT(CITY)) FROM STATION

-- 5
SELECT TOP(1) CITY,LEN(CITY) FROM STATION GROUP BY CITY HAVING LEN(CITY)=(SELECT MIN(LEN(CITY)) FROM STATION) UNION ALL 
SELECT TOP(1) CITY,LEN(CITY) FROM STATION GROUP BY CITY HAVING LEN(CITY)=(SELECT MAX(LEN(CITY)) FROM STATION) 

-- 6
SELECT CITY FROM STATION WHERE CITY LIKE 'a%' or CITY LIKE 'e%' or CITY LIKE 'i%' or CITY LIKE 'o%' or CITY LIKE 'u%'

-- 7
select distinct(CITY) from STATION where CITY like '%[A,E,I,O,U]'

-- 8
select CITY from STATION where CITY like '[A,E,I,O,U]%[A,E,I,O,U]'

-- 9
select DISTINCT(CITY) from STATION where CITY not like '[A,E,I,O,U]%'

-- 10
select distinct(CITY) from STATION where CITY not LIKE '%[A,E,I,O,U]'

-- 11
select distinct(CITY) from STATION where CITY not LIKE '[A,E,I,O,U]%[A,E,I,O,U]'

-- 12
select distinct(CITY) from STATION where CITY NOT LIKE '[A,E,I,O,U]%' and CITY NOT LIKE '%[A,E,I,O,U]';

-- 13
select cast(sum(LAT_N) as decimal(18,4)) from STATION where LAT_N>38.7880 and LAT_N<137.2345

-- 14
select top(1) cast(LAT_N as decimal(18,4))from STATION where LAT_N<137.2345 order by LAT_N desc

-- 15
select cast(LONG_W as decimal(18,4)) from STATION where LAT_N=(select top(1) LAT_N from STATION where LAT_N<137.2345 order by LAT_N desc)

-- 16
select top(1) cast(LAT_N as decimal(18,4)) from STATION where LAT_N>38.7780 order by LAT_N

-- 17
select cast(LONG_W AS DECIMAL(18,4)) FROM STATION 
WHERE LAT_N = (SELECT TOP(1) LAT_N FROM STATION WHERE LAT_N >38.7780 ORDER BY LAT_N )

/*Higher Than 75 Marks */
SELECT Name FROM STUDENTS WHERE Marks > 75 ORDER BY RIGHT(Name, 3), ID;

/*Employee Names */
select name from Employee  order by name

/*Employee Salaries */
select name from Employee where salary > 2000 and months<10 order by employee_id;

/*Type of Triangle */

SELECT
  CASE 
    WHEN A + B <= C or A + C <= B or B + C <= A THEN 'Not A Triangle'
    WHEN A = B and B = C THEN 'Equilateral'
    WHEN A = B or A = C or B = C THEN 'Isosceles'
    WHEN A <> B and B <> C THEN 'Scalene'
  END 
FROM TRIANGLES

/*Revising Aggregations - The Count Function */
select count(NAME) from CITY where POPULATION>100000;

/*Revising Aggregations - The Sum Function */
select sum(POPULATION) from CITY where DISTRICT='California'

/*Revising Aggregations - Averages */
select avg(POPULATION) from CITY where DISTRICT='California'

/*Average Population */
select avg(POPULATION) FROM CITY

/*Japan Population */
SELECT sum(POPULATION) FROM CITY WHERE COUNTRYCODE='JPN'

/*Population Density Difference */
select max(POPULATION)-MIN(POPULATION) from CITY

/*The Blunder*/
SELECT CEILING( CAST(AVG(Salary) AS DECIMAL) - AVG(CAST(REPLACE(Salary, 0, '') AS DECIMAL)-1) ) FROM EMPLOYEES

/*Top Earners*/
SELECT MAX(salary * months), COUNT(*) FROM Employee WHERE salary * months = (SELECT MAX(salary * months) FROM Employee);

/*Asian Population */
select sum(CITY.POPULATION) from CITY
join COUNTRY on (CITY.CountryCode = COUNTRY.Code) where CONTINENT='Asia'

/*African Cities*/
select CITY.NAME from CITY
join COUNTRY on (CITY.CountryCode = COUNTRY.Code) where CONTINENT='Africa'

/*Average Population of Each Continent */
select COUNTRY.CONTINENT,avg(CITY.POPULATION) from CITY
join COUNTRY on (CITY.CountryCode = COUNTRY.Code) 
group by COUNTRY.CONTINENT

/*Draw The Triangle 1 */
with cte as
(select 20 as i union all
 select i-1 as i from cte where i > 0)
select REPLICATE('* ', i) from cte

/*Draw The Triangle 2 */
with cte as
(select 1 as i union all
 select i+1 as i from cte where i < 20)
select REPLICATE('* ', i) from cte