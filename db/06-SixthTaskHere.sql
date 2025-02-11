\c nc_flix
SELECT * FROM customers;

ALTER TABLE customers ADD COLUMN IF NOT EXISTS age INTEGER;
UPDATE customers 
SET age = EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth));

WITH customer_info AS(
SELECT customer_name AS name, location, age, loyalty_points,
case
    WHEN loyalty_points IS NULL
    OR loyalty_points = 0 THEN 'doesn''t even go here'
    WHEN loyalty_points < 10 THEN 'bronze status'
    WHEN loyalty_points <= 100 THEN 'silver status'
    WHEN loyalty_points > 100 THEN 'gold status'
END loyalty_membership_status
FROM customers) SELECT * FROM customer_info 
ORDER BY location, COALESCE(loyalty_points,0) DESC;



