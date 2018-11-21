                                /* Wiseowl Table-valued functions*/
                                -----------------------------------
 
create FUNCTION fnEventsForYear(
    @yr int
)
RETURNS TABLE
as
 RETURN
  select *
  from tblEvent
  where year(EventDate) = @yr
go
select * from dbo.fnEventsForYear(1918) t
JOIN tblCountry on t.CountryID=tblCountry.CountryID

go-------------------------------------------------------------------

ALTER FUNCTION fnEpisodesByDoctor(
    @nam varchar(20)
)
RETURNS TABLE
AS
    RETURN
        SELECT
        EpisodeId,EpisodeNumber,Title,SeriesNumber,AuthorId
        FROM
        tblEpisode te
        join tblDoctor td on te.DoctorId=td.DoctorId
        where DoctorName like '%'+@nam+'%'
GO
SELECT * FROM dbo.fnEpisodesByDoctor('Chris')

go-------------------------------------------------------------------

ALTER FUNCTION fnChosenEpisodes(
@sno int,
@aName varchar(100)
)
RETURNS TABLE
AS
 return
    select Title,AuthorName,DoctorName
    from 
    tblEpisode te
    join tblDoctor td on te.DoctorId=td.DoctorId
    join tblAuthor ta on te.AuthorId=ta.AuthorId
    where AuthorName like IIF(@aName IS NULL, AuthorName,'%'+@aName+'%' ) and 
    SeriesNumber= IIF(@sno IS NULL, SeriesNumber, @sno ) 
GO
SELECT * FROM dbo.fnChosenEpisodes(1,'russell')
SELECT COUNT(*) FROM dbo.fnChosenEpisodes(2,'moffat')
SELECT COUNT(*) FROM dbo.fnChosenEpisodes(2,null)
SELECT COUNT(*) FROM dbo.fnChosenEpisodes(null,'moffat')
SELECT COUNT(*) FROM dbo.fnChosenEpisodes(null,null)

go------------------------------------------------------------------

alter FUNCTION fnContinentSummary(
@cont VARCHAR(100),
@month varchar(100)
)
RETURNS TABLE
AS
 return
    SELECT ContinentName,count(EventID) as 'No. of events',(tc.CountryID) as 'No. of countries',( tca.CategoryID) as 'No. of categories',EventDate
    from tblEvent te
    join tblCountry tc on te.CountryID=tc.CountryID
    join tblCategory tca on te.CategoryID=tca.CategoryID
    join tblContinent tco on tc.ContinentID=tco.ContinentID
    group by ContinentName,EventDate,tc.CountryID,tca.CategoryID
    having ContinentName like '%'+@cont+'%' and datename(MONTH,EventDate) = @month
GO
SELECT ContinentName,count([No. of events]),count(distinct [No. of countries]),count(distinct [No. of categories]) FROM dbo.fnContinentSummary('Europe','April')
group by ContinentName

go----------------------------------------------------------------------

select SeriesNumber,EpisodeNumber,Title, DoctorName, AuthorName, CompanionName+','+EnemyName as 'appearing'
from tblEpisode te 
join tblDoctor td on te.DoctorId=td.DoctorId
join tblAuthor ta on te.AuthorId=ta.AuthorId
join tblEpisodeCompanion tec on te.EpisodeId=tec.EpisodeId
join tblCompanion tc on tec.CompanionId=tc.CompanionId
join tblEpisodeEnemy tee on te.EpisodeId=tee.EpisodeId
join tblEnemy ten on tee.EnemyId=ten.EnemyId
where CompanionName+','+EnemyName like '%wilf%' or CompanionName+','+EnemyName like '%ood%'
--similar concept--
go-----------------------------------------------------------------------

alter FUNCTION NameGoesHere
(@vow varchar(2))
RETURNS @tblInfo TABLE
([info] varchar(100)
,[type] varchar(100)
)
AS
BEGIN
INSERT INTO @tblInfo
select CountryName, 'Country'
from tblCountry
where CountryName like '%'+@vow+'%'
INSERT INTO @tblInfo
select ContinentName, 'Continent'
from tblContinent
where ContinentName like '%'+@vow+'%'
INSERT INTO @tblInfo
select CategoryName, 'Category'
from tblCategory
where CategoryName like '%'+@vow+'%'
RETURN
END
go
SELECT * from dbo.NameGoesHere('a')
order by info

