\c nc_flix
select AVG(rating) from movies
where release_date BETWEEN '1980-01-01' AND '1989-12-31';

select location,
SUM(CASE 
    WHEN loyalty_points is NULL
    THEN 0
    ELSE loyalty_points
END) as total,
AVG(CASE 
    WHEN loyalty_points is NULL
    THEN 0
    ELSE loyalty_points
END) as average
from customers
group by location;

