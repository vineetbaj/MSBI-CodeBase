                                /*Wiseowl Pivots*/
                                ------------------
with cte as(
    select year(EpisodeDate) as 'year',SeriesNumber,count(EpisodeId) as 'Num'
    from tblEpisode
    group by SeriesNumber,year(EpisodeDate)
) select Year as 'Episode Year',isnull([1],0) as '1',
isnull([2],0) as '2',
isnull([3],0) as '3',
isnull([4],0) as '4',
isnull([5],0) as '5'
from 
(select * from cte) as src
pivot(
    sum(Num)
    for SeriesNumber in ([1],[2],[3],[4],[5])
) as PivotTable

go--------------------------------------------------------

with cte as(
    select  DoctorName, substring(EpisodeType,1,CHARINDEX(' ',EpisodeType)) as 'type'
    from tblEpisode te
    join tblDoctor td on te.DoctorId=td.DoctorId
) select DoctorName,[Normal],[Christmas] 
from cte as src
pivot (
    count(type)
    for type in ([Normal],[Christmas])
) as pivotTable