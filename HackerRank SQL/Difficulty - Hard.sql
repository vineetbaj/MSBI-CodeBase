-------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- Hackerrank SQL Exercise -------------------------------------------------
---------------------------------------------------Difficulty : Hard-----------------------------------------------------
/*Interviews*/
WITH SUM_View_Stats AS (
SELECT challenge_id
    , total_views = sum(total_views)
    , total_unique_views = sum(total_unique_views)
FROM View_Stats 
GROUP BY challenge_id
)
,SUM_Submission_Stats AS (
SELECT challenge_id
    , total_submissions = sum(total_submissions)
    , total_accepted_submissions = sum(total_accepted_submissions)
FROM Submission_Stats 
GROUP BY challenge_id
)
SELECT    con.contest_id
        , con.hacker_id
        , con.name
        , SUM(total_submissions)
        , sum(total_accepted_submissions)
        , sum(total_views)
        , sum(total_unique_views)
FROM Contests con
INNER JOIN Colleges col
    ON con.contest_id = col.contest_id
INNER JOIN Challenges cha
    ON cha.college_id = col.college_id
LEFT JOIN SUM_View_Stats vs
    ON vs.challenge_id = cha.challenge_id
LEFT JOIN SUM_Submission_Stats ss
    ON ss.challenge_id = cha.challenge_id
GROUP BY con.contest_id,con.hacker_id,con.name
HAVING (SUM(total_submissions)
        +sum(total_accepted_submissions)
        +sum(total_views)
        +sum(total_unique_views)) <> 0
ORDER BY con.contest_ID


/*15 Days of Learning SQL*/
With rank_test as(
	select h.hacker_id as id,[name] as [person_name],submission_date as [date_time],count(h.hacker_id) as marks from hackers h
    join submissions s on h.hacker_id=s.hacker_id
    group by h.hacker_id,[name],submission_date
),cte as(
	select a.id as id,a.person_name,a.marks,a.date_time,a.rn as arn,b.rn as brn from 
	(
	select f.id,[person_name],marks,date_time,DENSE_RANK() over (partition by date_time order by date_time,marks desc,[id]) as rn
	from rank_test f
	) a
	join 
	(
	select id,[person_name],date_time,DENSE_RANK() over (partition by id order by date_time,[id]) as rn
	from rank_test
	) b 
	on a.date_time=b.date_time and  a.id=b.id
 ),cte_b as(
 select *,DENSE_RANK() over (partition by brn order by date_time,arn) as lrn from cte c
 join 
	(select distinct date_time as d_date,DENSE_RANK() over (order by date_time) as drn
	from rank_test) d
	on c.date_time=d.d_date
	where brn=drn
 ),cte_c as(
 select distinct be.date_time,cnt,g.id,g.person_name from cte_b as be
 join (select date_time,count(distinct id) as cnt from cte_b group by date_time) r on be.date_time=r.date_time
 join  (select a.id as id,a.person_name,a.marks,a.date_time,a.rn as arn from 
 (
 select f.id,[person_name],marks,date_time,DENSE_RANK() over (partition by date_time order by date_time,marks desc,[id]) as rn
 from rank_test f) a where a.rn=1) g 
 on be.date_time=g.date_time-- and g.person_name=be.person_name
 where lrn=1
 )
 select distinct x.date_time,real_cnt,x.id,x.person_name
 from cte_c x
 join (select date_time,COUNT(distinct id) as real_cnt from cte_b y group by date_time) z on x.date_time=z.date_time 
