USE SAKILA;

##Select the first name, last name, and email address of all the customers who have rented a movie.

SELECT* from customer;
SELECT* from rental;
SELECT* from payment;

select c.first_name , c.last_name , c.email , r.customer_id ,p.amount from customer c
JOIN rental r on c.customer_id = r.customer_id
JOIN payment p on r.customer_id = p.customer_id;

## What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

SELECT ROUND(AVG(amount),2) FROM payment;

select CONCAT (c.first_name , ' ', c.last_name) as CLIENT  ,ROUND(AVG(p.amount),2) AS payment_pro from customer c
JOIN rental r on c.customer_id = r.customer_id
JOIN payment p on r.customer_id = p.customer_id
GROUP BY r.customer_id ;

##Select the name and email address of all the customers who have rented the "Action" movies.

 
SELECT * FROM category;
SELECT*FROM FILM;
SELECT* FROM film_category;
 
DROP view if exists clien_pay;
CREATE VIEW  clien_pay AS;

select CONCAT (c.first_name , ' ', c.last_name) as CLIENT , c.email , ROUND(AVG(p.amount),2) AS payment_pro  from customer c
JOIN rental r on c.customer_id = r.customer_id
JOIN payment p on r.customer_id = p.customer_id
GROUP BY r.customer_id;

CREATE VIEW  categori1  AS
SELECT ca.name , i.inventory_id from inventory i
JOIN film f on i.film_id = f.film_id
JOIN film_category fc on f.film_id = fc.film_id
JOIN category ca on fc.category_id = ca.category_id;

SELECT* FROM categori1 ;
SELECT * FROM client1;

CREATE VIEW  client1 AS
SELECT r.inventory_id , CONCAT (c.first_name , ' ', c.last_name) as CLIENT , c.email  , ROUND(AVG(p.amount),2) AS payment_pro  from customer c
JOIN rental r on c.customer_id = r.customer_id
JOIN payment p on r.customer_id = p.customer_id
GROUP BY r.customer_id , r.inventory_id;

SELECT c.CLIENT , c.email ,ca.name from client1 c
JOIN categori1 ca on c.inventory_id = ca.inventory_id
WHERE ca.name = 'Action' ;

### Use la declaración de caso para crear una nueva columna que clasifique las columnas existentes como
#transacciones de alto valor o de alto valor según el monto del pago. Si la cantidad está entre 0 y 2, la etiqueta debe ser lowy si la cantidad está entre 2 y 4, la etiqueta debe ser medium, y si es más de 4, entonces debe ser high

CREATE TEMPORARY TABLE clientP
select DISTINCT r.customer_id , CONCAT(c.first_name ,' ' , c.last_name) as client ,p.amount from customer c
JOIN rental r on c.customer_id = r.customer_id
JOIN payment p on r.customer_id = p.customer_id;

SET SQL_SAFE_UPDATES = 0;
ALTER TABLE clientP ADD COLUMN etiqueta VARCHAR(10);

UPDATE clientP
SET etiqueta = CASE
    WHEN amount BETWEEN 0 AND 2 THEN 'low'
    WHEN amount BETWEEN 2 AND 4 THEN 'medium'
    WHEN amount > 4 THEN 'high'
    ELSE 'unknown'
    END;
SELECT*FROM clientP;



