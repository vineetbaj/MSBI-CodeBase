--To get table name, latest identity column value, Maximum value that can be entered

ALTER procedure [dbo].[get_identity_inserts]
@database_name varchar(50)
as
begin
	IF DB_ID(@database_name) IS NOT NULL
	begin
		create table #table_name(
									dbname varchar(100),
									tbl_schema varchar(100),
									tbl_name varchar(500)
								)
		insert into #table_name(dbname,tbl_schema,tbl_name)
		SELECT TABLE_CATALOG,TABLE_SCHEMA,TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'

		--select * from #table_name
		;with cte as(SELECT   OBJECT_NAME(OBJECT_ID) AS TABLENAME,
			c.system_type_id,
			c.user_type_id ,
             c.NAME AS COLUMNNAME, 
             --SEED_VALUE, 
             --INCREMENT_VALUE, 
             LAST_VALUE as [Current Value],
			 case t.name
			  when 'int' then '2,147,483,647'
			  when 'bigint' then '9,223,372,036,854,775,807'
			  when 'numeric' then '10^38 - 1'
			  end as [Maximum Value]
			FROM     SYS.IDENTITY_COLUMNS c
			join sys.types t on t.system_type_id=c.system_type_id and t.user_type_id = c.user_type_id
			WHERE OBJECT_NAME(OBJECT_ID) in (select tbl_name from #table_name) and t.name in ('int','bigint','numeric')
			)
			select TABLENAME,[Current Value],[Maximum Value] from cte
	end
	else
	print 'Database doen not exists!!'
end
-------------------------------------------*-*-*---------------------------
/*
execute get_identity_inserts
'AdventureWorksDW2016'
*/