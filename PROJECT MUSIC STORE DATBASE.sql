--Question set 3. Advance
/*Q3: Write a query that determines the customer that has spent the most on music for each country.
Write a query that returens the country along with the top customer and how  much they spent.
For countries where the top amount spent is shared, provide all customers who spent this amount.*/

WITH RECURSIVE 
customer_with_country AS(
	SELECT customer.customer_id, first_name, last_name, billing_country,SUM(total)AS total_spending
	FROM invoice
	JOIN customer ON customer.customer_id = invoice.customer_id
	GROUP BY 1,2,3,4
	ORDER BY 2,3 DESC),
	
country_max_spending AS(
	SELECT billing_country,MAX(total_spending) AS max_spending
	FROM customer_with_country
	GROUP BY billing_country)
		
SELECT cc.billing_country, cc.total_spending, cc.first_name, cc.last_name
FROM customer_with_country cc
JOIN country_max_spending ms
ON cc.billing_country = ms.billing_country
WHERE cc.total_spending = ms.max_spending
ORDER BY 1;