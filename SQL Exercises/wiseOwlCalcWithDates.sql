                        /*Calculations using dates*/
-------------------------------------------------------------------------------------------------

select EventName,EventDate,
    FORMAT(EventDate,'dd/MM/yyyy') as 'Using Format',
    'Using Convert' = CONVERT(varchar,EventDate,103)
from tblEvent

------------------------------

select EventName,EventDate,DATENAME(weekday,EventDate) as 'Day Of Week',
DATEPART(DAY,EventDate) as 'Day Number'
from tblEvent

------------------------------

select EventName,EventDate,DATEDIFF(DAY,EventDate,'1964/04/03') as 'Date Diff',abs(DATEDIFF(DAY,EventDate,'1964/04/03')) as 'abs date diff'
from tblEvent
order by [abs date diff];

------------------------------

select EventName,DATENAME(weekday,EventDate) +' '+ convert(varchar, getdate(), 106) as 'Full date'
from tblEvent
order by EventDate


----------------------------------