/*INSERTING DATA INTO TABLE*/
--create table #t(id int identity,cust_id int,punch_type varchar(10),dates datetime)
----create unique clustered index idx_pk on #t (id)

--insert into #t values
--(1,'out','2019-04-16 12:48:59.467'),(2,'out','2019-04-16 10:00:59.467'),
--(3,'out','2019-04-16 10:49:00.467'),
--(1,'out','2019-04-14 16:19:59.467'),
--(1,'in','2019-04-14 17:19:59.467'),
--(1,'out','2019-04-15 00:19:59.467'),
--(1,'in','2019-04-15 09:29:59.467'),(1,'out','2019-04-15 13:00:59.467'),
--(1,'in','2019-04-15 13:49:00.467'),(1,'out','2019-04-15 16:19:59.467'),
--(1,'in','2019-04-15 17:19:59.467'),(1,'out','2019-04-15 19:00:59.467')
--(3,'in','2019-04-14 10:29:59.467'),(3,'out','2019-04-14 13:00:59.467'),
--(3,'out','2019-04-14 16:19:59.467'),
--(3,'in','2019-04-14 17:19:59.467'),
--(3,'in','2019-04-15 09:29:59.467'),(3,'out','2019-04-15 13:00:59.467'),
--(3,'in','2019-04-15 13:49:00.467'),(3,'out','2019-04-15 16:19:59.467'),
--(3,'in','2019-04-15 17:19:59.467'),(3,'out','2019-04-15 19:00:59.467'),
--(4,'in','2019-04-14 10:29:59.467'),(4,'out','2019-04-14 13:00:59.467'),
--(4,'in','2019-04-14 14:49:00.467'),
--(4,'out','2019-04-14 16:19:59.467'),
--(4,'in','2019-04-14 17:19:59.467'),
--(4,'in','2019-04-15 09:29:59.467'),(4,'out','2019-04-15 13:00:59.467'),
--(4,'in','2019-04-15 13:49:00.467'),(4,'out','2019-04-15 16:19:59.467'),
--(4,'in','2019-04-15 17:19:59.467'),(4,'out','2019-04-15 19:00:59.467')

--create table #desc(id int identity,cust_id int,[desc] varchar(100))
------
----,(1,01,'2019-04-16 11:19:59.467')
--drop table #n

select row_number() over (partition by cust_id order by cust_id,[dates]) as id,cust_id,punch_type,dates into #test from #t

--/*Intro*/
--select t.* from #test t
--join #desc d on t.cust_id=d.cust_id

SELECT  id,cust_id,
[in], [out] into #n
FROM
(SELECT *
 FROM #test) AS SourceTable
PIVOT
(
 min(dates)
 FOR punch_type IN ([in], [out])
) AS PivotTable
group by cust_id,id,[in], [out] 


--select a.* from #n a
 
-- select * from #test

update a 
set a.out = b.out
from #n a
left join #n b on a.id=b.id-1 and a.cust_id=b.cust_id

delete from #n 
where [in] is null and [out] is null

;with cte as
(
 select *,DATEDIFF(MINUTE,[in],[out]) as [TT] from #n
), cteb as (
 select cust_id,isnull(cast([in] as date),cast([out] as date)) as [dte],iif(
 sum(isnull(TT,-10000)) < 0,NULL,sum(TT)/60.00) as [tt],sum(TT)/60.00 as [actual] from cte
 group by  cust_id,isnull(cast([in] as date),cast([out] as date))
)
select * from cteb

