                        /*WiseOwl Variables*/
                        ---------------------

DECLARE @name varchar(50) = 'Vineet';
DECLARE @dob DATETIME,@cnt INTEGER;
SET @dob = getdate();
select @cnt = 2;

print @name 
print @cnt
print @dob

---------------------------------------

Declare @early DATE = (select min(EventDate) from tblEvent);
Declare @late DATE = (select max(EventDate) from tblEvent);
DECLARE @num INT = (select count(EventID) from tblEvent);
DECLARE @info varchar(20)= 'Summary of events';

select 'Title'=@info,'Earliest Date'=CONVERT([varchar],@early,101),'Latest Date'=CONVERT([varchar],@late,101),'Num of events'=@num;

----------------------------------------
GO
alter PROCEDURE spCalculateAge
 @currage date
AS
BEGIN
print 'the difference is '+cast(datediff(month,@currage,getdate()) as varchar)+' months.'
END
EXECUTE spCalculateAge '2015/11/12'

-------------------------------------------
GO
declare @EpisodeName varchar(100), @EpisodeId int = 54, @NumberCompanions int , @NumberEnemies int;

set @NumberCompanions = (select 
 Count(tblEpisode.EpisodeId)
from tblEpisode
join tblEpisodeCompanion on tblEpisode.EpisodeId=tblEpisodeCompanion.EpisodeId
GROUP by tblEpisode.EpisodeID,tblEpisode.Title
having tblEpisode.EpisodeId=@EpisodeId)

set @NumberEnemies = (select Count(tblEpisode.EpisodeId) 
from tblEpisode
join tblEpisodeEnemy on tblEpisode.EpisodeId= tblEpisodeEnemy.EpisodeID
GROUP by tblEpisode.EpisodeID,tblEpisode.Title
having tblEpisode.EpisodeId=@EpisodeId)

set @EpisodeName = (select Title from tblEpisode where EpisodeId=@EpisodeId)

SELECT
@EpisodeName as Title,
@EpisodeId as 'episode id',
@NumberCompanions as 'Number of companions',
@NumberEnemies as 'Number of enemies'

--------------------------------------------
DECLARE @enemy varchar(max);
SET @enemy =  '';
Select @enemy = @enemy + 
 case 
 when EnemyName is not null then EnemyName + ', ' 
 else ''
 End 
from tblEpisode te
join tblEpisodeEnemy tee on te.EpisodeId=tee.EpisodeId
join tblEnemy ten on tee.EnemyId=ten.EnemyId
where te.EpisodeId = 15
set @enemy = SUBSTRING(@enemy,1,len(@enemy)-1)
print @enemy

---------------------------------------------

select EventName,EventDate,CountryName
from tblEvent te
join tblCountry tc on te.CountryID=tc.CountryID
where year(EventDate) = 1964
order by EventDate

----------------------------------------------
 /*Rest 2 are also repeatative*/