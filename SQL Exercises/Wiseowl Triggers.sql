                            /* Wiseowl Triggers */
                            ----------------------

select CountryName,'old value' as 'change' into #tempTrigger from tblCountry
select * from #tempTrigger
create table tempTrigger(countryName varchar(200),change varchar(20))
go
ALTER TRIGGER trgAfterInsrert ON tempTrigger   
instead of INSERT  --if for|after is used then first insert will happen then other work list in the function.
AS  
 insert into tempTrigger values('samplhe','new')
  print 'here'
GO  
insert into tempTrigger values('samplesd','old')

select * from tempTrigger
--rest similar concept
go-----------------------------------------------------------------

--similar concept but to use if condition and adding a parameter