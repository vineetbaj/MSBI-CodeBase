                        /* Wiseowl Derived tables and CTEs */
                        -------------------------------------

;with cte AS
(
    select EventID,
    case 
    when EventDetails like '%this%' then 1
    else 0
    end as 'ifThis',
    case 
    when EventDetails like '%that%' then 1
    else 0
    end as 'ifThat'
    from tblEvent
)select count(EventID) as 'Number of events',ifThis,ifThat from cte
group by ifThis,ifThat

go---------------------------------------------------------

;with cte as (
    SELECT EpisodeId
    from tblEpisode
    join tblAuthor on tblEpisode.AuthorId=tblAuthor.AuthorId
    where AuthorName like '%MP%'
)select distinct CompanionName 
from tblEpisode te
join tblEpisodeCompanion tec on te.EpisodeId=tec.EpisodeId
join tblCompanion tc on tec.CompanionId=tc.CompanionId
where te.EpisodeId in (select * from cte)

go---------------------------------------------------------

;with cte as(
    select EventID,
    case 
    when YEAR(EventDate) < 1900 then '19th century or earlier'
    when YEAR(EventDate) < 2000 then '20th century'
    else '21st century' 
    end as 'Era'
    from tblEvent
)select Era,count([Era]) as 'Number of Events' from cte
group by  Era

go---------------------------------------------------------

--repeatative--
--repeatative--
go---------------------------------------------------------

;with cte as(
select EventName,EventDate,EventID,CHARINDEX('this',EventDetails,1) as 'this',CHARINDEX('that',EventDetails,1) as 'that'
from tblEvent
)
select EventName,EventDate from cte
where this < that and this<>0 and that<>0 

go---------------------------------------------------------

;with First_Half_CTE as
(
    select EventName, CategoryID
    from tblEvent
    where LEFT(EventName,1) BETWEEN 'a' and 'm'
)select EventName, CategoryName from First_Half_CTE c 
join tblCategory tc on c.CategoryID=tc.CategoryID

go---------------------------------------------------------
--repeatative concept-- to use right function instead on left.
go---------------------------------------------------------
--incomplete
;with cte as(
select *
from tblEvent
where EventName not like '%o%' and EventName not like '%w%' and EventName not like '%l%'
)
select * from
tblEvent te 
join tblCountry tc on te.CountryID=tc.CountryID
where tc.CountryID in (select CountryID from cte)

go---------------------------------------------------------
--select * from tblMenu
;with cte(MenuId,MenuName,[Breadcrumb]) as(
    SELECT MenuId, MenuName, cast(IIF(MenuName is null,MenuName,'Top')as varchar(max)) as 'Breadcrumb' 
    from tblMenu where MenuId=1
    union ALL
    select tm.MenuId, tm.MenuName, cast((c.Breadcrumb + ' > ' + c.MenuName) as [varchar](max)) as 'Breadcrumb'
    from tblMenu tm
    join cte c on tm.ParentMenuId=c.MenuId  
)select * from cte
order by MenuId

go---------------------------------------------------------
--leaving out this one
go---------------------------------------------------------

select distinct te.EpisodeId,Title
from tblEpisode te 
join tblDoctor td on te.DoctorId=td.DoctorId
join tblEpisodeEnemy tee on te.EpisodeId=tee.EpisodeId
join tblEnemy ten on tee.EnemyId=ten.EnemyId
where DoctorName ='David Tennant'
and ten.EnemyId not in (
    select ten.EnemyId
    from tblEpisode te 
    join tblDoctor td on te.DoctorId=td.DoctorId
    join tblEpisodeEnemy tee on te.EpisodeId=tee.EpisodeId
    join tblEnemy ten on tee.EnemyId=ten.EnemyId
    where DoctorName <>'David Tennant'
)

go----------------------------------------------------------

with cte as(
    select distinct CountryName,CategoryName
    from tblEvent te
    join tblCategory tc on te.CategoryID=tc.CategoryID
    join tblCountry tco on te.CountryID=tco.CountryID
    where CountryName='Space'
),cte_b as(
    select distinct CountryName,CategoryName
    from tblEvent te
    join tblCategory tc on te.CategoryID=tc.CategoryID
    join tblCountry tco on te.CountryID=tco.CountryID
    where CountryName<>'Space'
)
select distinct CountryName from cte_b
where CategoryName in (select CategoryName from cte)