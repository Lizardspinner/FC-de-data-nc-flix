\c nc_flix
select DISTINCT location from customers
where location NOT IN (select city from stores);

select location from customers
union
select city from stores;

select stores.store_id, COUNT(stock.stock_id) stock_count from stores
join 
stock using (store_id)
where city in (select location from customers)
group by stores.store_id
order by stock_count DESC
limit 1;

select * from genres
join
movies_genres using (genre_id)
join
movies using (movie_id)
join
stock using (movie_id)
join
stores using (store_id)
where store_id = (select stores.store_id, COUNT(stock.stock_id) stock_count from stores
join 
stock using (store_id)
where city in (select location from customers)
group by stores.store_id
order by stock_count DESC
limit 1);
