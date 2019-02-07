--------------------------------------------PARSENAME()------------------------------------------
/*
	Returns the specified part of an object name. 
	The parts of an object that can be retrieved are the object name, owner name, database name, and server name.
	Purpose : The task below split the string into multiple columns using parsename.
	Assumption : util.function_split() is a table valued functon which returns the table containing the splitted values as the rows of 
	column(val).
*/

declare @str varchar(max) = '1:A:10:20,1:B:70:40,3:C:99:11,4:D:15:60,5:E:20:30';

;with cte as(
select x.val
from util.function_split(@str, ',') as x
)SELECT PARSENAME(REPLACE(val,':','.'),4),
		PARSENAME(REPLACE(val,':','.'),3),
		PARSENAME(REPLACE(val,':','.'),2),
		PARSENAME(REPLACE(val,':','.'),1)
 from cte