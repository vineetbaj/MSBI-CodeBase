                            /* Wiseowl Archived */
                            ----------------------

create TABLE #bigPeople (
    id int identity primary key,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
)

insert into #bigPeople (
    first_name, last_name
)
select FirstName, LastName
from tblPerson
where len(FirstName)+len(LastName) > 20

select * from #bigPeople

begin try 
 drop table #bigPeople;
end try
BEGIN CATCH
 select  'already done' as 'no'
end CATCH;

go---------------------------------------------------------

create function fnWeekDay (
    @dateToName date
) returns VARCHAR(20)
as
begin
 return datename(WEEKDAY,@dateToName)
END
go
select dbo.fnWeekDay(EventDate) as 'Day of Week', count(EventID) as 'Number of Events'
from tblEvent
group by dbo.fnWeekDay(EventDate);

go---------------------------------------------------------

create function fnTableCourses (
    @startDate date,
    @endDate date
)returns TABLE
AS
 return
    select ScheduleId,CourseName,StartDate from tblCourse tc
    join tblSchedule ts on tc.CourseId=ts.CourseId
    where StartDate BETWEEN @startDate and @endDate
GO
select * from dbo.fnTableCourses('01/01/2010','01/31/2010') order by StartDate

go---------------------------------------------------------
select EventName,EventDate
from tblEvent
order by EventDate DESC
go---------------------------------------------------------
--join with continent<>'europe'
go---------------------------------------------------------
--count function on eventid by countries
go---------------------------------------------------------

select WebsiteName,CategoryName,WebsiteUrl
from tblCategory tc 
join tblWebsite tw on tc.CategoryId=tw.CategoryId
where CategoryName='Search Engine'

go---------------------------------------------------------

select t.orgId, OrgName
from tblOrg t
join tblPerson tp on t.OrgId=tp.OrgId
group by t.OrgId,OrgName
having count(Personid) > 12

go---------------------------------------------------------
--prev done similar concept
go---------------------------------------------------------

    select ScheduleId,CourseName,StartDate,NumberDays,DATEADD(day,NumberDays,StartDate) as 'End date' from tblCourse tc
    join tblSchedule ts on tc.CourseId=ts.CourseId

go---------------------------------------------------------
--use len function and order by desc
go---------------------------------------------------------

select EventName,convert([date],EventDate,103) as 'Date of Event',DATEDIFF(year,EventDate,GETDATE()) as 'Years ago'
from tblEvent
order by [Years ago]

go---------------------------------------------------------

select ContinentName
from tblContinent tc
left outer join tblCountry tco on tc.ContinentId=tco.ContinentId
WHERE CountryId is null

go---------------------------------------------------------

--similar concept
go---------------------------------------------------------
declare @id int;
declare @name varchar(50);
declare @db_cursor CURSOR 
set @db_cursor = cursor for SELECT TrainerId,TrainerName
from tblTrainer

open @db_cursor
fetch NEXT from @db_cursor into @id,@name
while @@FETCH_STATUS = 0
BEGIN
    print @name + ' (id '+cast(@id as varchar(10))+')'
fetch NEXT from @db_cursor into @id,@name
END
close @db_cursor
deallocate @db_cursor

go---------------------------------------------------------

create view view_name
as 
    SELECT EventName,EventDate
    from tblEvent te
    join tblCountry tc on te.CountryId=tc.CountryId
    join tblContinent tco on tco.ContinentId=tc.ContinentId
    where ContinentName = 'Africa'
go
select * from view_name

go---------------------------------------------------------
--repeatative
--next also repeatative
go---------------------------------------------------------

select * from tblEvent
where EventDate > all(select EventDate from tblEvent where EventDate like '%European Union%')

go---------------------------------------------------------

declare @TechieCourses table(ScheduleId int,StartDate date,CourseName varchar(100),TrainerId nvarchar(200));
insert into @TechieCourses(
    ScheduleId,
    StartDate,
    CourseName,
    TrainerId
) select ScheduleId,StartDate,CourseName,TrainerIds from tblCourse tc
join tblSchedule ts on tc.CourseId=ts.CourseId
where (','+ cast(ts.TrainerIds as [varchar](100)) + ',') like '%,2936,%'

select * from @TechieCourses

go---------------------------------------------------------

select tc.CountryId,CountryName,isnull(tc.ContinentId,0) as 'Continent' from tblCountry tc
left join tblContinent tco on tc.ContinentId = tco.ContinentId
order by CountryName desc

go---------------------------------------------------------
--without cte
select CourseName,tp.PersonId
from tblPerson tp
join tblDelegate td on tp.Personid=td.PersonId
join tblSchedule ts on td.ScheduleId=ts.ScheduleId
join tblCourse tc on ts.CourseId=tc.CourseId
where tp.Personid in (
select tp.PersonId
from tblPerson tp
join tblDelegate td on tp.Personid=td.PersonId
group by tp.Personid
having COUNT(DelegateId) >=6)
order by CourseName

go---------------------------------------------------------
--easy
go---------------------------------------------------------
select count(*) from tblPerson as p
join tblPersonStatus as tp on p.PersonStatusId=tp.PersonStatusId
where PersonStatusName='Current'

select count(*) from tblPerson as p
join tblPersonStatus as tp on p.PersonStatusId=tp.PersonStatusId
where PersonStatusName='Obsolete'

go---------------------------------------------------------

create function fnExtraText(
    @name varchar(max),
    @desc varchar(max)
) returns INT
as
begin
  return (len(@desc) - len(@name))
  end
go
select EventName,[Description],dbo.fnExtraText(EventName,[Description]) as 'Extra Text'
from tblEvent 
order by [Extra Text] desc

go---------------------------------------------------------

create function fnNiceDate(
    @EventDate date
) returns varchar(max)
as
begin
  return (datename(WEEKDAY,@EventDate) +' '+ cast(convert(varchar, @EventDate, 106) as [varchar](100)))
  end
go

select EventName,EventDate,dbo.fnNiceDate(EventDate) as 'Nice Date'
from tblEvent
order by EventDate desc