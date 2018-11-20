                    /*Wise owl joins*/
                    ------------------
--First approach
select ta.AuthorName,te.Title,te.EpisodeType
from tblAuthor ta
inner join tblEpisode te on (ta.AuthorId=te.AuthorId)
where te.EpisodeType like '%Special%'
order by Title
--Second Approach
select ta.AuthorName,te.Title,te.EpisodeType
from tblAuthor ta, tblEpisode  te
where ta.AuthorId=te.AuthorId and te.EpisodeType like '%Special%'
order by Title

-------------------------------------------------------

select EventName,EventDate,tc.CategoryName
from tblEvent te
right join tblCategory tc on (te.CategoryID=tc.CategoryID)      --can also use full outer join
order by EventDate DESC

--------------------------------------------------------

select CountryName,'What happened'=EventName,'When happened'=EventDate
from tblEvent te
join tblCountry tc on te.CountryID=tc.CountryID 
order by EventDate

--------------------------------------------------------

select AuthorName
from tblAuthor ta
join tblEpisode te ON ta.AuthorId=te.AuthorId
join tblEpisodeEnemy tee ON te.EpisodeId=tee.EpisodeId
join tblEnemy ten ON tee.EnemyId=ten.EnemyId
where EnemyName='Daleks'
--------------------------------------------------------

select DoctorName,Title
from tblDoctor td
join tblEpisode te on te.DoctorId=td.DoctorId
where datepart(YEAR,EpisodeDate) = 2010; 

--------------------------------------------------------

select AuthorName,Title,DoctorName,EnemyName,'Total Length'=len(AuthorName)+len(Title)+len(DoctorName)+len(EnemyName)
from tblAuthor ta
join tblEpisode te ON ta.AuthorId=te.AuthorId
join tblDoctor td ON te.DoctorId=td.DoctorId
join tblEpisodeEnemy tee ON te.EpisodeId=tee.EpisodeId
join tblEnemy ten ON tee.EnemyId=ten.EnemyId
where len(AuthorName)+len(Title)+len(DoctorName)+len(EnemyName)<40

--------------------------------------------------------
select EventName,EventDate,CountryName,ContinentName
from tblCountry tc
join tblEvent te on te.CountryID=tc.CountryID
join tblContinent tco on tc.ContinentID = tco.ContinentID
where CountryName='Russia' or ContinentName='Antarctic'

--------------------------------------------------------
select CountryName
from tblCountry tc
full outer join tblEvent te on te.CountryID=tc.CountryID
where EventName is null;