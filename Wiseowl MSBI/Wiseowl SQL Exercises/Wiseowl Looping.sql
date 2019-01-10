                            /* Wiseowl Looping */
                            ---------------------

DECLARE @counter int = year('19951116');
DECLARE @endValue int = year(getdate());

while @counter <> @endValue
begin
    declare @cnteve int;
    select @cnteve=count(EventID) 
    from tblEvent
    group by year(EventDate)
    HAVING year(EventDate)= @counter
    PRINT cast(@cnteve as varchar(50)) + ' events occured in the year '+cast(@counter as varchar(50))
    set @counter = @counter + 1
END

--------------------------------------------------------

DECLARE @cntouter int = 2;
DECLARE @cntinner int = 2;
declare @flag int;
WHILE @cntouter <> 1000
BEGIN
    set @flag = 0;
    set @cntinner = 2;
    WHILE @cntinner < @cntouter
    BEGIN
        if @cntouter % @cntinner = 0
          set @flag = 1;   
    set @cntinner = @cntinner + 1 
    END
    if @flag = 0
        print @cntouter
    set @cntouter = @cntouter + 1
END

---------------------------------------------------------
go
---still to convert month number into month name---
DECLARE @counter int = 1;
declare @evnt VARCHAR(max);
while @counter <> 12
BEGIN
 set @evnt = ''
 declare @evd VARCHAR(20); 
 select @evnt = @evnt + EventName + ','
 from tblEvent
 where MONTH(EventDate) = @counter and YEAR(EventDate)=1997
 if(@counter < 10)
    set @evd = '19970'+cast(@counter as varchar(2))+'01'
 ELSE
    set @evd = '1997'+cast(@counter as varchar(2))+'01'
 if @evnt = ''
    PRINT 'Events occurred in the month of '+datename(mm,cast(@evd as date))+' : No Event'
 ELSE
    PRINT 'Events occurred in the month of '+datename(mm,cast(@evd as date))+' : '+left(@evnt,len(@evnt)-1)
 set @counter = @counter + 1; 
END