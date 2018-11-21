                        /*Wiseowl Creating tables*/
                        ---------------------------

create TABLE tblProductionCompany(
    ProductionCompanyId int IDENTITY(1,1) PRIMARY KEY,
    ProductionComapnyName VARCHAR(max),
    Abbreviation VARCHAR(100)
)
insert into tblProductionCompany values('British Broadcasting Corporation','BBC'),
('Canadian Broadcasting Corporation','CBC');

select * from tblProductionCompany

------------------------------------------------------
--repeatative concepts
------------------------------------------------------

-- create table summaryData(
--     SummaryItems VARCHAR(max),
--     CountEvents int
-- )

select 'The Last millenium' as 'SummaryItems',count(te.EventID) as 'CountEvents' into summaryData  from tblEvent te
where EventDate < '20000101';

-------------------------------------------------------

select ContinentName,count(distinct tc.CountryID) as 'Countries in continent','Events in Continent'=count(EventID),'Earliest continent event'=min(EventDate),'Latest Continent event'=max(EventDate)
into continentSummaryData
from tblEvent te
join tblCountry tc on te.CountryID=tc.CountryID
join tblContinent tco on tc.ContinentID=tco.ContinentID
group by ContinentName

select * from continentSummaryData

--------------------------------------------------------
if exists(
select * from INFORMATION_SCHEMA.columns
where TABLE_NAME='tblgenre'  and COLUMN_NAME='genreID')
  print 'It contains the table tblgenre'
ELSE
print 'It does not contain the table tblgenre'  