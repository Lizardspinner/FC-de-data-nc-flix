\c nc_flix
select * from movies
where release_date >= '2000-01-01';

select * from customers order by date_of_birth limit 1;

select * from customers 
where customer_name like 'D%'
order by date_of_birth DESC;

update movies
set cost = ROUND(cost * 0.95,2)
RETURNING *;








