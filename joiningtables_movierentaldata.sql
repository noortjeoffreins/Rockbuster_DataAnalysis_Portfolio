/* This query joins tables to analyze movie rental behavior by country. */

SELECT
	country.country,
	film.film_id,
	film.title,
	film.length,
	AVG (rental_rate) AS average_customer_rating,
	COUNT (rental.rental_id) AS count_rented		
FROM film
	INNER JOIN inventory ON film.film_id = inventory.film_id
	INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
	INNER JOIN customer ON rental.customer_id = customer.customer_id
	INNER JOIN address ON customer.address_id = address.address_id
	INNER JOIN city ON address.city_id = city.city_id
	INNER JOIN country ON city.country_id = country.country_id
GROUP BY country.country, film.film_id, film.title, film.length
ORDER BY country.country ASC;