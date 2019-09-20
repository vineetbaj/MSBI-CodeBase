								/*Table Partition*/
								-------------------
CREATE PARTITION FUNCTION [WorkOrder] (Date)
AS RANGE RIGHT FOR VALUES 
('2011-06-01', '2011-07-01', '2011-08-01');

CREATE PARTITION SCHEME psSales
AS PARTITION [WorkOrder] 
ALL TO ([Primary]);

CREATE TABLE Sales (
	SalesDate DATE,
	Quantity INT
) ON psSales(SalesDate);

INSERT INTO Sales(SalesDate, Quantity)
SELECT ModifiedDate,OrderQty
from [AdventureWorks2016].[Production].[WorkOrder]

select * from Sales
select * from sys.partitions

SELECT o.name objectname,i.name indexname, partition_id, partition_number, [rows]
FROM sys.partitions p
INNER JOIN sys.objects o ON o.object_id=p.object_id
INNER JOIN sys.indexes i ON i.object_id=p.object_id and p.index_id=i.index_id