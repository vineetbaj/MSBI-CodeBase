alter view testView 
as SELECT AuthorName,DoctorName,Title,EpisodeDate
from tblEpisode te
join tblAuthor ta on te.AuthorId=ta.AuthorId
join tblDoctor td on te.DoctorId=td.DoctorId 
where SUBSTRING(Title,1,1)='F'
go
select * from testView

---------------------------------------------------
---Remaining-------

