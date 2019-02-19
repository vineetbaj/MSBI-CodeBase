-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- LeetCode Problems ----------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

--Combine 2 tables
select FirstName, LastName, City, State
from Person p
left join Address a on p.PersonId=a.PersonId

--Second highest
with cte as (
 select top 2 Salary from Employee
    order by Salary desc
)select top 1 Salary from cte
order by Salary

--Nth highest Salary
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
     select distinct Salary
          from 
           (select dense_rank() over (order by salary desc) as Ranks, ID, Salary
            from Employee) as a
            where a.Ranks = @N
    
    )
        
END
