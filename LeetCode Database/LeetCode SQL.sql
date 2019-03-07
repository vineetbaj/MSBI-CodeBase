-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- LeetCode Problems ----------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

--Combine 2 tables
select FirstName, LastName, City, State
from Person p
left join Address a on p.PersonId=a.PersonId

--Second highest
declare @Salary int;
SELECT @Salary = Salary
FROM (
       SELECT
         [Salary],
         (DENSE_RANK()
         OVER
         (
           ORDER BY [Salary] DESC)) AS rnk
       FROM Employee
       GROUP BY Salary
     ) AS A
WHERE A.rnk = 2

select 
case 
when @Salary is not null then @Salary
else null 
end as 'SecondHighestSalary'

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

--Not boring movies
select * from cinema
where description <> 'boring'
and id % 2 <> 0 
order by rating desc

--Rank Scores
select Score,dense_rank() over(order by Score desc) Rank
from Scores
order by Score desc

--Consecutive Numbers
select distinct Num as consecutiveNums
from 
(
    select Num,sum(c) over (order by Id) as step 
    from 
        (
            select id, num, 
            case 
            when LAG(Num) OVER     (order by id)- Num = 0 then 0 
            else 1
            end as c
            from logs
        ) i
) o
group by Num,step
having count(*)>=3

--Employees Earning More Than Their Managers
select m.Name as 'Employee' from Employee e
join Employee m on e.Id=m.ManagerId
where m.Salary>e.Salary

--Duplicate Emails
select distinct p.Email from Person p
join Person t on p.Id <> T.Id
where p.Email=t.Email

--Customers Who Never Order
select Name as 'Customers' from Customers c
left join Orders o on c.Id = o.CustomerId
where o.Id is null

--Department Highest Salary
SELECT
    Department.Name AS Department,
    Employee.Name AS Employee,
    Employee.Salary AS Salary
FROM
    (
    SELECT MAX(Salary) AS Salary, DepartmentId
    FROM Employee
    GROUP BY DepartmentId
    ) Emp
    
    JOIN Department
    ON Department.Id = Emp.DepartmentId
    
    JOIN Employee
    ON Employee.Salary = Emp.Salary
    AND Employee.DepartmentId = Emp.DepartmentId

--Swap Salary
update salary
set sex = case
when sex='m' then 'f'
else 'm'
end

--Department Top Three Salaries
with cte as
(select e.Id,e.Name,Salary,d.Name as 'dname',d.Id as 'did',dense_rank() over (partition by DepartmentId order by Salary desc) rn
from Employee e
join Department d on e.DepartmentId = d.Id)
select dname as 'Department',Name as 'Employee',Salary from cte
where rn<=3
order by did,Salary desc

--Delete Duplicate Emails
DELETE p from Person p, Person q where p.Id>q.Id AND q.Email=p.Email 

--Rising Temperature
select w.Id from Weather w
join Weather u on DATEDIFF(day,u.RecordDate,w.RecordDate)=1
where w.Temperature>u.Temperature

--Trips and Users
with cte as
(select Request_at,
        case 
        when Driver_Id not in (select Users_id from Users where Banned='Yes') and Client_Id not in (select Users_id from Users where Banned='Yes') then 1
		else 0 
        end as 'tot',
        case
		when Status = 'cancelled_by_driver' 
			 and Driver_Id not in (select Users_id from Users where Banned='Yes')
			 and Client_Id not in (select Users_id from Users where Banned='Yes') then 1
        when Status = 'cancelled_by_client'
			 and Client_Id not in (select Users_id from Users where Banned='Yes')
			 and Driver_Id not in (select Users_id from Users where Banned='Yes') then 1
		else 0
		end as 'castot'
from Trips t)
select Request_at as 'Day',cast (cast(sum(castot) as decimal(18,2))/cast(iif(sum(tot)<>0,sum(tot),1) as decimal(18,2))  as decimal(18,2))as 'Cancellation Rate' from cte
group by Request_at
having Request_at in ('2013-10-01','2013-10-02','2013-10-03')

--Big Countries
Select name Name, population Population, area Area
from world
where area > 3000000 or
population > 25000000