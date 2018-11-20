                    /*WiseOwl Aggregation and Grouping*/
                    ------------------------------------

select AuthorName,count(EpisodeId) as 'Total Episodes',min(EpisodeDate) as 'Earlieat Episode',max(EpisodeDate) as 'Latest Episode'
from tblAuthor ta
join tblEpisode te on (ta.AuthorId=te.AuthorId) 
GROUP by AuthorName
order by [Total Episodes] desc;

-----------------------------------------------------

select AuthorName,DoctorName,count(EpisodeId) as 'Episodes'
from tblAuthor ta
join tblEpisode te on (ta.AuthorId=te.AuthorId) 
join tblDoctor td on (te.DoctorId=td.DoctorId)
group by AuthorName,DoctorName
having  count(EpisodeId) > 5
order by Episodes desc;

-----------------------------------------------------

select CategoryName,count(EventID) as 'No of events'
from tblCategory tc
join tblEvent te on tc.CategoryID=te.CategoryID 
group by CategoryName
order by [No of events] desc;

-----------------------------------------------------

select 'Episode Year'=datepart(year,EpisodeDate),EnemyName,COUNT(te.EpisodeId) as 'Number of Episodes'
from tblEpisode te
join tblEpisodeEnemy tee on te.EpisodeId=tee.EpisodeId
join tblEnemy ten on tee.EnemyId=ten.EnemyId 
join tblDoctor td on te.DoctorId=td.DoctorId
GROUP by datepart(year,EpisodeDate),EnemyName,BirthDate
having datepart(year,BirthDate)<1970 and COUNT(te.EpisodeId)>1
order by [Episode Year],[Number of Episodes] desc;

------------------------------------------------------

select 'Number of events'=count(EventID),'Last Event'=max(EventDate),'First Event'=min(EventDate)
from tblEvent

------------------------------------------------------

select substring(CategoryName,1,1) as 'Category Initial',count(EventID) as 'Number of events',cast(avg(cast(len(EventName) as decimal(10,2))) AS numeric(10,2)) as 'Average Event Length Name'
from tblCategory tc
join tblEvent te on te.CategoryID=tc.CategoryID 
group by substring(CategoryName,1,1)

------------------------------------------------------

select ContinentName,CountryName,count(EventID)
from tblEvent te
join tblCountry tc on te.CountryID=tc.CountryID
join tblContinent tco on tc.ContinentID=tco.ContinentID
group by ContinentName,CountryName

------------------------------------------------------

select substring(cast(datepart(year,EventDate) as [varchar](4)),1,2)+'th Century' as 'Century',count(EventID) as 'Number of events'
from tblEvent
group by substring(cast(datepart(year,EventDate) as [varchar](4)),1,2) with cube
order by Century;