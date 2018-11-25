                            /*Wiseowl Transactions*/
                            ------------------------

BEGIN TRAN
    INSERT INTO tblDoctor(
        DoctorName,
        DoctorNumber
    ) VALUES (
        'Shaun the Sheep',
        13
    )

if 2+2=5         --when 2+2=4 then the above insert will be rollbacked.
    ROLLBACK
ELSE
    commit tran

select * from tblDoctor

--------------------------------------------------------

BEGIN TRAN
    if exists(select EventID from tblEvent where EventName='My Dob')
       print 'Already exists'
    ELSE
        INSERT into tblEvent values ('My Dob','born on this date',GETDATE(),null,null)
COMMIT TRAN           

select * from tblEvent

---------------------------------------------------------

BEGIN TRAN
delete from tblEpisode where EpisodeId=10
if (select count(EpisodeID) from tblEpisode) > 101
    COMMIT tran;
ELSE
    print 'The tables can''t be rollbacked'  ;  
    ROLLBACK

--------------------------------------------------------------
/*Repeatative concept*/
-------------------------------------------------------------
GO

DECLARE @Continent VARCHAR(20)='Westeros';
SET IDENTITY_INSERT tblContinent ON;
-- INSERT INTO tblContinent (ContinentID,ContinentName)
-- VALUES (9,@Continent)
select * from tblContinent

Begin TRANSACTION
DELETE tblContinent where ContinentName= @Continent;
if(LEFT('Vineet',1)<>'W')
begin
 ROLLBACK TRANSACTION;
 SELECT 'YOu lost' as 'Result';
 end
ELSE 
 BEGIN
    COMMIT TRANSACTION
    select 'YOu won' as Result;
END
SET IDENTITY_INSERT tblContinent OFF;