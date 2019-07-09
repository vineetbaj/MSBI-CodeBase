-------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- Hackerrank SQL Exercise -------------------------------------------------
--------------------------------------------------Difficulty : Medium----------------------------------------------------

/*The PADS*/
SELECT Name+"("+(LEFT(Occupation,1))+")" from OCCUPATIONS ORDER BY Name 
  SELECT "There are a total of " + cast( count( Occupation) as nvarchar) +' '+ lower(Occupation)+"s." from OCCUPATIONS 
  group BY Occupation 
  order by count( Occupation),Occupation


/*Occupations*/
select Doctor, Professor, Singer,Actor from
(SELECT 
         ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) rn,
         [Name],
         [Occupation] 
     FROM 
         Occupations
  )as rc pivot
   (max(Name) for Occupation in(Doctor, Professor, Singer,Actor)) pivt

/*Binary Tree Nodes*/
select case 
    when P is null then CONVERT(varchar(10), N)+' Root'
    when N in (select P from BST) then  CONVERT(varchar(10), N)+' Inner'
    else CONVERT(varchar(10), N)+' Leaf'
    end
from BST
order by N

/*New Companies*/
SELECT c.company_code, c.founder, count(Distinct e.lead_manager_code), 
count(distinct e.senior_manager_code), count(distinct e.manager_code), 
count(distinct e.employee_code) FROM Company c 
JOIN Employee e ON c.company_code = e.company_code GROUP BY c.company_Code, c.founder ORDER BY c.company_code;

/*Weather Observation Station 18*/
SELECT CAST((MAX(LAT_N)-MIN(LAT_N)+ MAX(LONG_W)-MIN(LONG_W)) AS DECIMAL(18,4))  FROM STATION

/*Weather Observation Station 19*/
select cast(sqrt(square(max(LAT_N)-MIN(LAT_N))+SQUARE(MAX(LONG_W)-MIN(LONG_w))) as decimal(18,4)) FROM STATION

/*Weather Observation Station 20*/
with cte as(
SELECT
(
 (SELECT MAX(LAT_N) FROM
   (SELECT TOP 50 PERCENT LAT_N FROM STATION ORDER BY LAT_N) AS BottomHalf)
 +
 (SELECT MIN(LAT_N) FROM
   (SELECT TOP 50 PERCENT LAT_N FROM STATION ORDER BY LAT_N DESC) AS TopHalf)
) / 2 AS Median
)select cast(Median as numeric(10,4)) from cte

/*The Report*/
select case
when g.Grade>7 then s.Name
else NULL
end,g.Grade,s.Marks
from Students s,Grades g 
where s.Marks between g.Min_mark and g.Max_Mark 
order by g.Grade DESC,s.Name

/*Top Competitors*/
SELECT h.hacker_id, h.name FROM Submissions AS s JOIN Hackers AS h ON s.hacker_id = h.hacker_id
                                JOIN Challenges AS c ON s.challenge_id = c.challenge_id
                                JOIN Difficulty AS d ON c.difficulty_level = d.difficulty_level
WHERE s.score = d.score GROUP BY h.hacker_id, h.name HAVING COUNT(*)>1 ORDER BY COUNT(*) DESC, h.hacker_id;


/*Ollivander's Inventory*/
SELECT id, age, m.coins_needed, m.power FROM 
(SELECT code, power, MIN(coins_needed) AS coins_needed FROM Wands GROUP BY code, power) AS m
JOIN Wands AS w ON m.code = w.code AND m.power = w.power AND m.coins_needed = w.coins_needed
JOIN Wands_Property AS p ON m.code = p.code
WHERE p.is_evil = 0
ORDER BY m.power DESC, age DESC;

/*Challenges*/
SELECT h.hacker_id, 
       h.name, 
       COUNT(c.challenge_id) AS c_count
FROM Hackers h
JOIN Challenges c ON c.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name
HAVING c_count = 
    (SELECT COUNT(c2.challenge_id) AS c_max
     FROM challenges as c2 
     GROUP BY c2.hacker_id 
     ORDER BY c_max DESC limit 1)
OR c_count IN 
    (SELECT DISTINCT c_compare AS c_unique
     FROM (SELECT h2.hacker_id, 
                  h2.name, 
                  COUNT(challenge_id) AS c_compare
           FROM Hackers h2
           JOIN Challenges c ON c.hacker_id = h2.hacker_id
           GROUP BY h2.hacker_id, h2.name) cou
     GROUP BY c_compare
     HAVING COUNT(c_compare) = 1)
ORDER BY c_count DESC, h.hacker_id;

/*Contest Leaderboard*/
with cte(id,name,score,cid,rn) as
(select h.hacker_id,h.name,s.score,challenge_id,row_number() over (partition by h.hacker_id,challenge_id order by h.hacker_id,s.score desc) 
from Hackers h join Submissions s on (h.hacker_id=s.hacker_id) 
)select id,name,sum(score) from cte
group by id,name,rn
having sum(score)>0 and rn=1
order by sum(score) desc,id

/*Projects*/
SELECT start_date, MIN(end_date)
FROM 
    (SELECT start_date FROM PROJECTS WHERE start_date NOT IN (SELECT end_date FROM PROJECTS)) a,
    (SELECT end_date FROM PROJECTS WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)) b
where start_date < end_date
GROUP BY start_date
ORDER BY datediff(day, start_date, MIN(end_date)), start_date

/*Placements*/
select Name from Students s  join Packages p on s.ID=p.ID
 join Friends f on f.ID=s.ID
 join Packages p2 on f.Friend_ID=p2.ID
where p2.salary>p.salary
order by p2.salary

/*Symmetric Pairs*/
with cte as(
    select x,y,row_number() over (order by x,y) as rn from Functions
)select distinct c.x,c.y from cte c join cte c2 on c.y=c2.x 
where c2.y=c.x and c.rn<> c2.rn and c.x<=c.y
order by c.x

/*Print Prime Numbers*/
DECLARE 
@i INT, 
@a INT, 
@count INT, 
@p varchar(max)
SET @i = 1 
WHILE (@i <= 1000) 
BEGIN 
	SET @count = 0 
	SET @a = 1 
	WHILE (@a <= @i) 
	BEGIN 
		IF (@i % @a = 0) 
		SET @count = @count + 1 
		SET @a = @a + 1 
	END 
	IF (@count = 2)
	SET @P = CONCAT(@P,CONCAT(@i,'&')) 
	SET @i = @i + 1 
END
PRINT LEFT(@P, LEN(@P) - 1)

