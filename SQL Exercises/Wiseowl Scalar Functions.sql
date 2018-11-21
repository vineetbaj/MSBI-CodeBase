                        /*Wiseowl Scalar Functions*/
                        ----------------------------

create function fnReign(@start date,@end DATE)
returns int
as
BEGIN
RETURN datediff(DAY,@start,isnull(@end,getdate())) 
END

select DoctorName, 'Reign in days' = dbo.fnReign(FirstEpisodeDate,LastEpisodeDate) from tblDoctor

--------------------------------------------------------------------
go
create function fnCountLetters(@evntName VARCHAR(100),@eventinfo VARCHAR(max))
returns int
as
BEGIN
RETURN (len(@evntName)+len(@eventinfo)) 
END

select EventName,EventDetails,EventDate,dbo.fnCountLetters(EventName,EventDetails) as 'Total Letters'
from tblEvent

---------------------------------------------------------------------
GO

ALTER function fnEpisodeDescription(@type VARCHAR(100))
returns int
as
BEGIN
DECLARE @cnt int = 0;
select @cnt = count(EpisodeId)
from tblEpisode 
group by EpisodeType
having EpisodeType = @type
return @cnt
END

select EpisodeType,dbo.fnEpisodeDescription(EpisodeType)
from tblEpisode
group by EpisodeType

------------------------------------------------------------------------
GO

create function fnGetMonth(@evntdate date)
returns VARCHAR(20)
as
BEGIN
RETURN datename(mm,@evntdate) 
END

select EventName,EventDetails,EventDate, dbo.fnGetMonth(EventDate) as 'Month Name'
from tblEvent

-------------------------------------------------------------------------
GO
--repeatative concept--
-------------------------------------------------------------------------
go
alter function fnGetEventInfo(@evntname varchar(30))
returns VARCHAR(20)
as
BEGIN
  DECLARE @get varchar(20);
    set @get = case 
        when (select EventDate from tblEvent WHERE EventName=@evntname) = (select max(EventDate) from tblEvent) then 'newest' 
        when (select EventDate from tblEvent WHERE EventName=@evntname) = (select min(EventDate) from tblEvent) then 'oldest'
        When (select EventName from tblEvent WHERE EventName=@evntname) = (select top 1 EventName from tblEvent order by EventName) then 'First Alphabetically'
        When (select EventName from tblEvent WHERE EventName=@evntname) = (select top 1 EventName from tblEvent order by EventName desc) then 'Last Alphabetically'
        else 'Not a Winner'
        end 
    return @get
END


select EventName, dbo.fnGetEventInfo(EventName) as 'Info'
from tblEvent
order by EventDate

--------------------------------------------------------------------------------