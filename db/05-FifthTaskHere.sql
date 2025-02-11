\c nc_flix

WITH stores_with_sequels AS (
    select stores.store_id, count(stock.stock_id) AS sequels
    FROM stores 
    join stock using (store_id)
join movies using (movie_id) 
WHERE movies.title LIKE '%II%' 
OR movies.title LIKE '%III%'
OR movies.title LIKE '%IV%'
OR movies.title LIKE '%V%'
OR movies.title LIKE '%VI%'
OR movies.title LIKE '%VII%'
OR movies.title LIKE '%VIII%'
OR movies.title LIKE '%IX%'
OR movies.title LIKE '%X%'
OR movies.title LIKE '%XI%'
GROUP BY stores.store_id)

SELECT store_id, sequels FROM stores_with_sequels 
ORDER BY sequels DESC LIMIT 1;

ALTER TABLE movies ADD COLUMN IF NOT EXISTS is_sequel boolean;

SELECT * FROM movies;

UPDATE movies SET is_sequel = true 
Where movies.title LIKE '%II%' 
OR movies.title LIKE '%III%'
OR movies.title LIKE '%IV%'
OR movies.title LIKE '%V%'
OR movies.title LIKE '%VI%'
OR movies.title LIKE '%VII%'
OR movies.title LIKE '%VIII%'
OR movies.title LIKE '%IX%'
OR movies.title LIKE '%X%'
OR movies.title LIKE '%XI%';

WITH stores_with_sequels AS (
    select stores.store_id, count(stock.stock_id) AS sequels
    FROM stores 
    join stock using (store_id)
join movies using (movie_id) 
WHERE movies.is_sequel = true
GROUP BY stores.store_id)

SELECT store_id, sequels FROM stores_with_sequels 
ORDER BY sequels DESC LIMIT 1;



