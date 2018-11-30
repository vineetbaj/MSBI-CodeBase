select CategoryID,CategoryName
from tblCategory
where CategoryID=11

--------------
select EventName,eventdate
from tblEvent
where CategoryID=11
----------------
select EventName,EventDetails,EventDate
from tblEvent
where ((CategoryID=4) or (EventDetails like '% water %') or (CountryID in (8,22,30,35)))
and EventDate> '1970-01-01'

----------------

select * from tblEvent
where EventDate between '2005-02-01' and '2005-02-28'

------------------

select * from tblEvent
where CategoryID <> 14 and EventDetails  like '%train%'

-----------------

select EventName,len(EventName) as length from tblEvent
order by len(EventName)