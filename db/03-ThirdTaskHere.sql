\c nc_flix
select COUNT(movies.title), genres.genre_name
from movies
join movies_genres
using (movie_id)
join genres
using (genre_id)
group by genres.genre_name;

select avg(movies.rating) as avg_rating, stores.city
from movies
join stock
using (movie_id)
join stores
using (store_id)
where city = 'Newcastle'
group by city;

select * from movies
where rating > (select avg(rating) from movies)
and release_date BETWEEN '1990-01-01' AND '1999-12-31';

select max(rating) from movies;

select COUNT(stock.stock_id)
from movies
join stock
using (movie_id)
where rating = (select max(rating) from movies);