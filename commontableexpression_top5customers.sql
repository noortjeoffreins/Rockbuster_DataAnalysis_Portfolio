/* This query retrieves the top 5 customers from the top 10 cities across the top 10 countries using a CTE. */

-- Step 1: Creating a CTE that contains a subquery to select the top 10 cities from the top 10 countries based on customer count. The CTE will be referenced later in the main query.
WITH top_10_cities AS (
    SELECT
        city.city
    FROM customer
        INNER JOIN address ON customer.address_id = address.address_id
        INNER JOIN city ON address.city_id = city.city_id
        INNER JOIN country ON city.country_id = country.country_id
    WHERE country.country IN 
        (SELECT country.country 
        FROM customer
           INNER JOIN address ON customer.address_id = address.address_id
           INNER JOIN city ON address.city_id = city.city_id
           INNER JOIN country ON city.country_id = country.country_id
        GROUP BY country.country
        ORDER BY COUNT (customer.customer_id) DESC
        LIMIT 10)
    GROUP BY country.country, city.city
    ORDER BY COUNT(customer.customer_id) DESC
    LIMIT 10
)

-- Step 2: Querying the top 5 customers based on the highest total amount paid, joining multiple tables to retrieve data from the top 10 cities in the CTE above.
SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    city.city,
    country.country,
    SUM(payment.amount) AS customer_total
FROM payment
    INNER JOIN customer ON payment.customer_id = customer.customer_id
    INNER JOIN address ON customer.address_id = address.address_id
    INNER JOIN city ON address.city_id = city.city_id
    INNER JOIN country ON city.country_id = country.country_id
WHERE city.city IN 
    (SELECT city FROM top_10_cities) -- Use the cities identified by the CTE
GROUP BY customer.customer_id, customer.first_name, customer.last_name, country.country, city.city
ORDER BY customer_total DESC
LIMIT 5; -- Limit the results to the top 5 customers by total payment amount