                    /*Wiseowl Temp tables and Table Variables*/
                    -------------------------------------------

select distinct te.DoctorId as 'characterID',DoctorName as 'Character Name','Doctor' as 'Character type'
into #characters from tblDoctor te

set IDENTITY_INSERT #characters off;

INSERT INTO #characters (
[Character Name],
[Character type]
) 
select distinct DoctorName as [Character Name],'Enemy' as [Character type]
from tblDoctor te
select * from #characters

set IDENTITY_INSERT #characters on;

go-------------------------------------------------------------------

declare @characters table(characterID int,[Character Name] varchar(max),[Character Type] varchar(max));


INSERT INTO @characters(
characterID,
[Character Name],
[Character Type]

)
select distinct te.DoctorId as 'characterID',DoctorName as 'Character Name','Doctor' as 'Character type'
from tblDoctor te


select * from @characters

------------------------------------------------------------------------

select left(EventName,1) as 'Initials', COUNT(EventID) as 'No. of Events'
into #tempTable
from tblEvent
group by LEFT(EventName,1)

select * from #tempTable
INSERT INTO #tempTable
values ('xz', 57) --Generate an error :  String or binary data would be truncated.
                  --Because the original data type is too small
                  --So creating a new temp table.
                  
create table #Eventsbyletter([First Letter] varchar(max),
[No of Events] INT
)
INSERT INTO #Eventsbyletter (
[First Letter],
[No of Events]
)
SELECT 
left(EventName,1), 
COUNT(EventID)
from tblEvent te
group by LEFT(EventName,1)

INSERT INTO #Eventsbyletter
values ('xz', 57)
select * from #Eventsbyletter
order by [First Letter]

go-------------------------------------------------------------------

declare @category table([categoryID] int identity,[categoryName] varchar(200),[Num of events] int);

insert into
@category(
    [categoryName] ,
    [Num of events]
)
select top 1 CategoryName,count(EventID)
from tblEvent te
join tblCategory tc on te.CategoryID=tc.CategoryID
group by CategoryName
order by count(EventID) desc

select * from @category
----similar step with country and continent

go--------------------------------------------------------------------

declare @oddtable table([CountryNAme] varchar(30),[CountryID] int);

insert into 
@oddtable
(
 [CountryNAme],
 [CountryID]
)
select CountryName,CountryID
from tblCountry
where CountryID%2<>0

select EventName,CountryNAme from @oddtable ot
join tblEvent te on ot.CountryID=te.CountryID
where EventName not like '%'+CountryNAme+'%' and right(CountryNAme,1)=RIGHT(EventName,1)

go--------------------------------------------------------------------
;with cte as(
select year(te.EventDate) as 'Year',tc.CountryName,count(te.EventID) as 'Number of events'
    ,row_number() over (partition by YEAR(EventDate) order by count(te.EventID) desc) as 'rn'
    from tblEvent te
    join tblCountry tc on te.CountryID=tc.CountryID
    group by YEAR(te.EventDate),CountryName
)
SELECT Year as 'Year of Events',CountryName as 'Country of Events',[Number of events] from cte
where rn=1

go--------------------------------------------------------------------

select te.EpisodeId,Title, SeriesNumber,EpisodeNumber,AuthorName as 'Why'
from tblEpisode te
join tblEpisodeCompanion tec on te.EpisodeId=tec.EpisodeId
join tblCompanion tc on tec.CompanionId=tc.CompanionId
join tblAuthor ta on te.AuthorId=ta.AuthorId
where (CompanionName='Amy Pond' and AuthorName='Steven Moffat')

go--------------------------------------------------------------------

declare @testTable table(EnemyId int,[Enemy Name] varchar(30),Description varchar(max));
insert into @testTable(
    EnemyId,[Enemy Name],[Description]
) 
select EnemyId,EnemyName,[Description] from tblEnemy
select EnemyId,[Enemy Name],case
when len([Description]) > 75 then SUBSTRING([Description],1,75)+'...' 
else  SUBSTRING([Description],1,75)
end 
as description from @testTable

go--------------------------------------------------------------------