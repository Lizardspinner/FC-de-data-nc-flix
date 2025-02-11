\c nc_flix
select DISTINCT location from customers
where location NOT IN (select city from stores);

select location from customers
union
select city from stores;

with stockiest_city as(
    select 
        stores.store_id,
        stores.city as stock_city,
        count(stock_id) as stock_count
from stock 
join stores using (store_id)
where stores.city in (
    select city from stores
    intersect
    select location from customers 
)
group by stores.store_id, stores.city
order by stock_count DESC
limit 1
), most_abundant_genre as (
    select 
    genres.genre_id,
    genres.genre_name as genrename,
    count(stock.stock_id) as genre_count
    from genres
    join movies_genres using (genre_id)
    join movies using (movie_id)
    join stock using (movie_id)
    where stock.store_id = (select store_id from stockiest_city)
    group by genres.genre_id, genres.genre_name
    order by genre_count DESC
    limit 1
    )

select 
    (select stock_city from stockiest_city) as store_location,
    (select store_id from stockiest_city) as store_id,
    (select genrename from most_abundant_genre) as most_abundant_genre;