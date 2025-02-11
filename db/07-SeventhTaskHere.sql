\c nc_flix

-- Design a way of storing information on rentals. A rental should 
-- track the following information:
-- rental_id
-- stock_id
-- rental_start
-- rental_end
-- customer_id
-- Add some rental rows we can query later.

CREATE TABLE IF NOT EXISTS rentals (
    rental_id SERIAL PRIMARY KEY,
    stock_id INT REFERENCES stock(stock_id),
    rental_start DATE,
    rental_end DATE,
    customer_id INT REFERENCES customers(customer_id)
);

-- INSERT INTO rentals
-- (stock_id, rental_start, rental_end, customer_id)
-- VALUES
-- (1, '2025-02-11', '2025-02-25', 2),
-- (3, '2024-12-11', '2024-12-25', 6),
-- (7, '2024-10-05', '2024-10-19', 10);

-- Finally, we have a customer in one of our stores! They wish to rent a film but have some requirements:
-- The film must be age-appropriate (classification of U).
-- The film must be available in Birmingham.
-- The film must not have been rented more than 5 times already.
-- Instead of creating a list of only the films that match this criteria, create an output 
-- that marks yes or no in a column that represents the requirement.

-- SELECT movie_id FROM stock WHERE stock.store_id =
-- (SELECT store_id from stores WHERE stores.city = 'Birmingham');

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


-- --check movie rented fewer than 5 times previously:
-- SELECT movie_id, stock_id FROM stock;


-- SELECT stock.movie_id, stock.stock_id 
-- FROM stock WHERE stock.stock_id IN(
--     SELECT stock_id 
--     FROM rentals
--     GROUP BY stock_id
--     HAVING COUNT(stock_id) < 5);

