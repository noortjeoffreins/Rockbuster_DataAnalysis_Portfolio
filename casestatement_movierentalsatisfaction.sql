/* This query analyzes rental behavior by categorizing movies based on their length using a CASE statement. */

SELECT		
	CASE	
		WHEN length BETWEEN 0 AND 60 THEN '0-60'
		WHEN length BETWEEN 61 AND 90 THEN '61-90'
		WHEN length BETWEEN 91 AND 120 THEN '91-120'
		WHEN length BETWEEN 121 AND 150 THEN '121-150'
		WHEN length BETWEEN 151 AND 151 THEN '151-180'
		ELSE '+181'
	END AS movie_length_range,	
	MIN (rental_rate) AS min_rental_rate,	
	MAX (rental_rate) AS max_rental_rate,	
	AVG (rental_rate) AS avg_rental_rate,	
	MIN (rental_duration) AS min_rental_duration,	
	MAX (rental_duration) AS max_rental_duration,	
	AVG (rental_duration) AS avg_rental_duration	
FROM film		
GROUP BY movie_length_range		
ORDER BY movie_length_range;		