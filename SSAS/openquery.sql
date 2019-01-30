--/*SIMPLE QUERY*/
--SELECT * FROM OPENQUERY("TS",
--' select 
--   {[Measures].[Sales Amount]} on columns,
--   exists({[Dim Customer].[First Name].MEMBERS},{[Dim Customer].[First Name].MEMBERS}) on rows
--from [ProductSalesCube]' )

--EXEC sp_serveroption 'INFO', 'DATA ACCESS', FALSE

/*Stores Procedure linking to a SSAS instance*/

alter PROCEDURE [dbo].[SP_FetchDataFromCube]
AS
BEGIN
	declare @mdx_query as varchar(max), @open_query as nvarchar(max), @linked_server as varchar(max),@ren varchar(max);
	create table #test (names varchar(max),name2 varchar(max));
	set @mdx_query = 'select 
					   { [Measures].[Sales Amount] } on columns,
					   exists({[Dim Customer].[First Name].MEMBERS},{[Dim Customer].[First Name].MEMBERS}) on rows
					  from [ProductSalesCube]'
	set @linked_server = N'TS'
	set @open_query = 'insert into #test SELECT * FROM OpenQuery ("'+@linked_server+'",'''+ @mdx_query + ''')'
	set @ren = 'select names,
				case 
				when name2 = ''0'' then lag(name2) over (order by names)
				else name2
				end as ''Value''
				from #test where names like ''a%'''
	--print @open_query
	--print @ren
	execute sp_executesql @open_query
	exec (@ren)
END

exec [dbo].[SP_FetchDataFromCube]


------------------------------------------------------------------------------------------------------------------
--For creating a linked server to a same instance we need to create a loopback linked server instance.
--Creating a linekd server by code.
EXEC master.dbo.sp_addlinkedserver
@server = N'SSASSRVR', -- name of linked server
@srvproduct=N'MSOLAP',
@provider=N'MSOLAP', -- see list of providers available on SQL Server under Linked Server node in SSMS Object Browser
@datasrc=N'****', -- machine or instance name  that host Analysis Services
@catalog=N'[ProductSales]' 

EXEC master.dbo.sp_addlinkedsrvlogin 
@rmtsrvname=N'SSASSRVR',
@useself=N'False',
@locallogin=NULL,
@rmtuser=N'*****',
@rmtpassword='******'