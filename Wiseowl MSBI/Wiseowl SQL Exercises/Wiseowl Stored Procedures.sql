                    /*Wiseowl Stored Procedures*/
                    -----------------------------

create procedure uspCountriesAsia
AS
BEGIN
    select CountryName
    from tblCountry tc
    join tblContinent tco on (tc.ContinentID=tco.ContinentID)
    where tco.ContinentID=1
    order by CountryName
END

exec uspCountriesAsia
go  --Another Method--
create PROCEDURE uspCountriesEurope
as
BEGIN
    select CountryID,CountryName
    from tblCountry tc
    join tblContinent tco on (tc.ContinentID=tco.ContinentID)
    where tco.ContinentID=3
    order by CountryName
end
EXEC uspCountriesEurope


-----------------------------------------------------
go
---------------------------------------------------

create PROCEDURE Wiseowl2
AS
BEGIN
    SELECT SeriesNumber,EpisodeNumber,Title,EpisodeDate,DoctorName
    from tblEpisode te
    join tblDoctor td on te.DoctorId=td.DoctorId
    where DoctorName='Matt Smith' and YEAR(EpisodeDate)=2012
END
EXEC Wiseowl2

-----------------------------------------------------
go
-----------------------------------------------------

CREATE PROCEDURE uspAugustEvents
AS
BEGIN
    SELECT top 5 EventID,EventName,EventDetails,EventDate
    from tblEvent
    where month(EventDate)=08
END
exec uspAugustEvents


-----------------------------------------------------
go
-----------------------------------------------------

CREATE PROCEDURE spMoffats
AS
BEGIN
    SELECT Title
    from tblAuthor ta
    join tblEpisode te on ta.AuthorId=te.AuthorId
    where AuthorName='Steven Moffat'
    order by EpisodeDate desc
END
EXEC spMoffats

-------------------------------------------------------
go
-------------------------------------------------------

create procedure spSummariseEpisodes
as 
BEGIN
    SELECT top 3 CompanionName,COUNT(te.EpisodeId) as 'Number of Episodes'
    from tblEpisode te
    JOIN tblEpisodeCompanion tec on te.EpisodeId=tec.EpisodeId
    join tblCompanion tca on tec.CompanionId=tca.CompanionId
    GROUP by CompanionName
    order by [Number of Episodes] desc

    SELECT top 3 EnemyName,COUNT(te.EpisodeId) as 'Number of Episodes'
    from tblEpisode te
    JOIN tblEpisodeEnemy tee on te.EpisodeId=tee.EpisodeId
    join tblEnemy tca on tee.EnemyID=tca.EnemyId
    GROUP by EnemyName
    order by [Number of Episodes] desc
END
EXEC spSummariseEpisodes