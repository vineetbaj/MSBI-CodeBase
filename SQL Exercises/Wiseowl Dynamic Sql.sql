                        /* Wiseowl Dynamic SQL exercise */
                        ----------------------------------

declare @tableName varchar(200) = 'tblEvent';
DECLARE @SQL VARCHAR(MAX) = 'SELECT * FROM ' + @tableName;
exec(@SQL)

go---------------------------------------------------------

declare @sortColumn VARCHAR(20) = 'EventName';
declare @SortOrder VARCHAR(20) = 'DESC';
declare @tableName varchar(200) = 'tblEvent';
DECLARE @SQL VARCHAR(MAX) = 'SELECT * FROM ' + @tableName + ' order by '+ @sortColumn+ ' '+@SortOrder;
exec(@SQL)

go---------------------------------------------------------

declare @saveName VARCHAR(max) ='';
select @saveName = @saveName + EventName + ', '
from tblEvent;
print @saveName