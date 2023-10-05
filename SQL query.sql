
/*Query 1 - query used for first insight (S1/Q1)*/
WITH table1
AS (
	SELECT
		 f.title mov_title,
		 c.name mov_category
	FROM category c
	JOIN film_category fc ON fc.category_id = c.category_id
	JOIN film f ON f.film_id = fc.film_id
	JOIN inventory i ON i.film_id = f.film_id
	JOIN rental r ON r.inventory_id = i.inventory_id
	WHERE c.name IN (
			'Animation',
			'Children',
			'Classics',
			'Comedy',
			'Family',
			'Music',
			)
	),

	table2
AS (
	SELECT
		t.mov_title,
		t.mov_category,
		count(t.mov_category) AS rental_count
	FROM table1 t
	GROUP BY
			 1,
			 2
	ORDER BY
			 2,
			 1
	)
SELECT
	mov_category,
	sum(rental_count)
FROM table2
GROUP BY
		1
ORDER BY
		2 DESC;

/*Query 2 - query used for second insight(S1/Q3)*/
WITH table1
AS (
	SELECT
		c.name categ_name,
		f.rental_duration,
		NTILE(4) OVER (
			ORDER BY f.rental_duration
			) AS stand_quartiles
	FROM film f
	JOIN film_category fc ON fc.film_id = f.film_id
	JOIN category c ON c.category_id = fc.category_id
	WHERE c.name IN (
			'Animation',
			'Children',
			'Classics',
			'Comedy',
			'Family',
			'Music'
			)
	ORDER BY
			 1,
			 2
	)
SELECT categ_name,
	   stand_quartiles,
	   count(*) AS counts
FROM
	table1
GROUP BY
		 1,
		 2
ORDER BY
		 1,
     2;

/*Query 3 - query used for third insight(S2/Q1)*/
WITH table1
AS (
	SELECT
		r.rental_date,
		s.store_id store_ident,
		CAST(r.rental_date AS DATE) new_date
	FROM rental r
	JOIN payment p ON p.rental_id = r.rental_id
	JOIN staff st ON st.staff_id = p.staff_id
	JOIN store s ON s.store_id = st.store_id
	)
SELECT
	EXTRACT
		(month FROM new_date) AS rental_month,
	EXTRACT
		(year FROM new_date) AS rental_year,
	store_ident,
	COUNT(*) AS rent_orders

FROM
	table1
GROUP BY
    1,
	  2,
	  3
ORDER BY
	  4 DESC;

/*Query 4 - query used for forth insight(S2/Q2)*/
SELECT
	DISTINCT (payment_month),
	first_name || ' ' || last_name AS full_name,
	pay_permonth,
	total_amtpaid
FROM
	(
	SELECT
		p.customer_id,
		c.first_name,
		c.last_name,
		DATE_TRUNC
				('month', payment_date) AS payment_month,
	SUM(p.amount)
	OVER
			(
	    PARTITION BY p.customer_id,
			DATE_TRUNC
				('month', p.payment_date)
			) AS total_amtpaid,
	COUNT(*)
	OVER
			(
			PARTITION BY p.customer_id,
			DATE_TRUNC
				('month', p.payment_date)
			) AS pay_permonth
	FROM
      payment p
	JOIN customer c ON c.customer_id = p.customer_id
	GROUP BY
		      1,
		      2,
		      3,
		      payment_date,
		      p.amount
	ORDER BY
		      2
	) sub
ORDER BY
	     total_amtpaid DESC LIMIT 10;



/*REFRENCES
1. Udacity GPT Chatbot,learn.udacity.com
2. USE CASE STATEMENT - www.w3schools.com
3. SQL COUNT() WITH DISTINCT - w3resource
4. Filter BY multiple VALUES ON the same COLUMN - Stack Overflow
5. visualization - FROM - excel - visme.co*/
