                        /*WiseOwl Subqueries*/
                        ----------------------

select EventName,EventDate,CountryName
from tblEvent te
join tblCountry tc on (te.CountryID=tc.CountryID)
where EventDate > all(select EventDate from tblEvent where CountryID=21)
order by EventDate desc
--OR--
select EventName,EventDate,CountryName
from tblEvent te
join tblCountry tc on (te.CountryID=tc.CountryID)
where EventDate > (select max(EventDate) from tblEvent where CountryID=21)
order by EventDate desc

--------------------------------------------

SELECT top(5) EventName
from tblEvent
where len(EventName) > (select avg(len(EventName)) from tblEvent)

--------------------------------------------

SELECT ContinentName,EventName
from tblEvent te
join tblCountry tc on te.CountryID=tc.CountryID
join tblContinent tco on tc.ContinentID=tco.ContinentID
where tco.ContinentID in (
        SELECT top 3 tcon.ContinentID
        from tblEvent te
        join tblCountry tc on te.CountryID=tc.CountryID
        join tblContinent tcon on tc.ContinentID=tcon.ContinentID
        group by tcon.ContinentID
        order by count(EventID) 
)

---------------------------------------------

SELECT distinct CountryName
from tblEvent te
join tblCountry tc on te.CountryID=tc.CountryID
where tc.CountryID in (
        SELECT tco.CountryID
        from tblEvent te
        join tblCountry tco on te.CountryID=tco.CountryID
        group by tco.CountryID
        having count(EventID)>8
)

----------------------------------------------

SELECT EventName,EventDetails
from tblEvent te
join tblCountry tc on te.CountryID=tc.CountryID
join tblCategory tca on te.CategoryID=tca.CategoryID
where tc.CountryID not in (
    select top 30 CountryID
    from tblCountry
    order by CountryName desc
) and tca.CategoryID not in (
    select top 15 CategoryID
    from tblCategory
    order by CategoryName desc
) order by EventDate