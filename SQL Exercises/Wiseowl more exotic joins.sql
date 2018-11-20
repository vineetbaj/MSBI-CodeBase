                /*WiseOwl More exotic joins*/
                -----------------------------

select CompanionName
from tblCompanion tc
full outer join tblEpisodeCompanion te on (te.CompanionId=tc.CompanionId) 
where EpisodeId is null

------------------------------------------------------
SELECT 
    Family.[FamilyName],
    ISNULL('All categories' +
    IIF(ParentFamily.FamilyId = 25,'',' > ' +ParentFamily.[FamilyName]) + ' > ' +
    TopFamily.[FamilyName], 'All categories') AS 'Family path'
FROM
    [dbo].[tblFamily] AS Family
    LEFT JOIN [dbo].[tblFamily] AS ParentFamily
        ON Family.ParentFamilyId = ParentFamily.FamilyID    
    LEFT JOIN [dbo].[tblFamily] AS TopFamily
        ON Family.FamilyId = TopFamily.FamilyID    
ORDER BY
    Family.[FamilyName]
-------------------------------------------