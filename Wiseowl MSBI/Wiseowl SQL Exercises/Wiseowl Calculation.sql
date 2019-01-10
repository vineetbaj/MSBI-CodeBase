select Country,KmSquared,WalesUnits=(KmSquared/20761),AreaLeftOver=(KmSquared%20761),
WalesComparison=cast((KmSquared/20761) as varchar(max))+' x Wales plus '+cast((KmSquared%20761) as varchar(max))+' sq. km.' from dbo.CountriesByArea
order by Country

---------------
GO

select EventName + ' (Category ' + cast((CategoryID) AS varchar(max)) + ')' as 'Event (category)',EventDate from tblEvent

--------------

select EventName,EventDate, CHARINDEX('this',EventDetails,1) as 'this',CHARINDEX('that',EventDetails,1) as 'that',CHARINDEX('that',EventDetails,1)-CHARINDEX('this',EventDetails,1) as 'offset' from tblEvent
where CHARINDEX('that',EventDetails,1)<>0 and CHARINDEX('this',EventDetails,1)<>0

---------------------

select ContinentName,Summary, ISNULL(Summary,'No Summary') as 'Using ISNULL',Coalesce(Summary,NULL,'No Summary') as 'Using COALESCE',
(
    select 
    case
        when Summary is NULL then 'No Summary' 
        else Summary
    end
) as 'Using CASE'
from tblContinent;

--------------------------------

select EventName,
(select case
when substring(EventName,Len(EventName),1) in ('a','e','i','o','u') and substring(EventName,1,1) in ('a','e','i','o','u') then 'Begins and ends with boring'
when substring(EventName,1,1)=substring(EventName,Len(EventName),1) then 'Non Boring'
else 'Boring' 
end) as 'verdict' from dbo.tblEvent
where (substring(EventName,Len(EventName),1) in ('a','e','i','o','u') and substring(EventName,1,1) in ('a','e','i','o','u'))
or (substring(EventName,1,1)=substring(EventName,Len(EventName),1))
-----------------------------------

select CountryName,
(
    select case
    when ContinentID in (1,3) then 'Eurasia'
    when ContinentID in (5,6) then 'Americas'
    when ContinentID in (2,4) then 'Somewhere hot'
    when ContinentID = 7 then 'Somewhere cold'
    else 'Somewhere else'
    end
) as 'newCol'
from tblCountry
order by newCol DESC