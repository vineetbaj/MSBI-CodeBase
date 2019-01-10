                    /*Wiseowl Parameters and Return Values*/
                    ----------------------------------------

create procedure spEnemyEpisodes
 @name VARCHAR(50)
as
begin
select SeriesNumber,EpisodeNumber,Title
from tblEpisode te
join tblEpisodeEnemy tee on te.EpisodeId=tee.EpisodeId
join tblEnemy ten on tee.EnemyId=ten.EnemyId
where EnemyName like '%'+@name+'%'
order by SeriesNumber,EpisodeNumber
end

execute spEnemyEpisodes 'Dalek'
execute spEnemyEpisodes 'ood'
execute spEnemyEpisodes 'auton'
execute spEnemyEpisodes 'silence'

-----------------------------------------------------------
go

create PROCEDURE spGetCategories
@catName VARCHAR(30),@after DATETIME
AS
begin
 select CategoryName,EventDate,te.CategoryID
 from tblEvent te
 join tblCategory tc on te.CategoryID=tc.CategoryID
 where CategoryName like '%'+@catName+'%'
 and EventDate > @after and te.CategoryID = @catID
END

EXECUTE spGetCategories 'death','19900101'

-----------------------------------------------------------
go
--Repetative concept--
-----------------------------------------------------------

Create PROCEDURE uspContinentEvents
 @continentName VARCHAR(50), @earlyDate DATE, @afterDate DATE
AS
begin
 select ContinentName,EventName,EventDate
 from tblEvent te
 join tblCountry tc on te.CountryID=tc.CountryID
 join tblContinent tco on tc.ContinentID=tco.ContinentID
 where (ContinentName like '%'+@continentName+'%') and 
 EventDate BETWEEN @earlyDate and @afterDate
END

EXECUTE uspContinentEvents 'Asia','19900101','20000101'

------------------------------------------------------------
go

create PROCEDURE spConcatenateString
as
BEGIN
 DECLARE @OutputParameter varchar(max);
 set @OutputParameter ='';
 SELECT @OutputParameter = @OutputParameter + ContinentName + ', '
 from tblContinent tco
 join tblCountry tc on tc.ContinentID=tco.ContinentID
 join tblEvent te on te.CountryID=tc.CountryID
 group by ContinentName
 having count(EventID)>50
 set @OutputParameter = LEFT(@OutputParameter,len(@OutputParameter)-1)
 select  @OutputParameter as 'Big Happenings';
END

EXECUTE spConcatenateString

-----------------------------------------------------------
go

create PROCEDURE spListEpisodes
@num INT = NULL
as
BEGIN
    if(@num is null)
     select * from tblEpisode 
    ELSE
     select * from tblEpisode where SeriesNumber = @num
END

EXECUTE spListEpisodes 2
EXECUTE spListEpisodes

------------------------------------------------------------
go

alter PROCEDURE spCompanionsForDoctor
@docname VARCHAR(20)
as
BEGIN
   select CompanionName
   from tblCompanion tc
   join tblEpisodeCompanion tec on tc.CompanionId = tec.CompanionId
   join tblEpisode te on tec.EpisodeId=te.EpisodeId
   join tblDoctor td on te.DoctorId=td.DoctorId
   group by DoctorName,CompanionName
   having DoctorName like '%'+@docname+'%'
END

execute spCompanionsForDoctor 'Ecc'

------------------------------------------------------------
go

create PROCEDURE spHowMuchLonger
AS
BEGIN
    DECLARE @num INT;
    select   @num = max(len(EventName))-min(len(EventName))
    from tblEvent
    return @num
END

declare @h int
EXECUTE @h = spHowMuchLonger
print @h

------------------------------------------------------------
GO

create PROCEDURE splinkProc1
@OutputParameter VARCHAR(max) out
AS
BEGIN
    set @OutputParameter = (SELECT ContinentName
    From tblContinent tco
    join tblCountry tc on tc.ContinentID=tco.ContinentID
    join tblEvent te on te.CountryID=tc.CountryID
    where EventDate = (select min(EventDate) from tblEvent))
END
go
create procedure splinkProc2
@Parameter VARCHAR(max) 
as
BEGIN
    SELECT EventName,EventDate,ContinentName
    From tblContinent tco
    join tblCountry tc on tc.ContinentID=tco.ContinentID
    join tblEvent te on te.CountryID=tc.CountryID
    where ContinentName=@Parameter
END

DECLARE @Variable VARCHAR(100) = ''
EXEC splinkProc1
@OutputParameter = @Variable OUTPUT
EXEC splinkProc2
@Parameter = @Variable

-------------------------------------------------------------
GO
--Repeatative concept--
-------------------------------------------------------------

create procedure spMostEventfulCountry
@cname varchar(50) out,
@numevents int out
AS
BEGIN
 select top 1 
 @cname=CountryName,@numevents=count(EventID)
 from tblEvent te
 join tblCountry tc on te.CountryID=tc.CountryID
 group by CountryName
 order by count(EventID) desc
END


declare @countryname VARCHAR(50);
declare @nevents int;
EXECUTE spMostEventfulCountry 
  @cname = @countryname  out,
  @numevents = @nevents out
print @countryname
PRINT @nevents