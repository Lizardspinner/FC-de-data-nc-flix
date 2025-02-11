\c nc_flix

CREATE TABLE IF NOT EXISTS rentals (
    rental_id SERIAL PRIMARY KEY,
    stock_id INT REFERENCES stock(stock_id),
    rental_start DATE,
    rental_end DATE,
    customer_id INT REFERENCES customers(customer_id)
);

SELECT stock.stock_id,
movies.title, movies.classification, movies.movie_id,
CASE 
    WHEN movies.classification = 'U' THEN 'yes'
    WHEN movies.classification IS NULL THEN NULL
    ELSE 'no'
END is_age_appropriate,
CASE 
    WHEN movies.movie_id IN (
        SELECT stock.movie_id 
        FROM stock 
        JOIN stores ON stock.store_id = stores.store_id
        WHERE stores.city = 'Birmingham'
    )
    THEN 'yes'
    ELSE 'no'
END is_in_birmingham, 
CASE
    WHEN stock.stock_id IN (
        SELECT stock_id FROM rentals
        GROUP BY stock_id
        HAVING COUNT(stock_id) < 5) THEN 'yes'
    ELSE 'no'
END rented_under_5
FROM movies JOIN stock USING (movie_id);

