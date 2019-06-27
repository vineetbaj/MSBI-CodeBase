-------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- Interview Bit Exercise --------------------------------------------------
------------------------------------------------------ Database ---------------------------------------------------------

--Neutral Reviewers
select distinct reviewer_name
from reviewers r
join ratings rg on r.reviewer_id=rg.reviewer_id
where reviewer_stars is NULL

--Movie Character
select distinct concat(director_first_name,director_last_name) as director_name ,movie_title
from movies m
join movies_directors md on m.movie_id=md.movie_id
join directors d on md.director_id=d.director_id
join movies_cast mc on m.movie_id=mc.movie_id
where role='SeanMaguire' and (director_first_name+''+director_last_name) is not null

--Short Films
select movie_title,movie_year,concat(director_first_name,director_last_name) as director_name,
concat(actor_first_name,actor_last_name) as actor_name,role
from movies m
join movies_cast mc on m.movie_id=mc.movie_id
join actors a on a.actor_id=mc.actor_id
join movies_directors md on m.movie_id=md.movie_id
join directors d on d.director_id=md.director_id
order by movie_time 
LIMIT 1

--Actors and their Movies
select distinct movie_title
from movies m
inner join movies_cast mc on m.movie_id=mc.movie_id
where exists (select c.actor_id, c.movie_id from movies_cast  c
where c.actor_id = mc.actor_id
and c.movie_id <> mc.movie_id
)