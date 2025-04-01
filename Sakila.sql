## SQL BASICS

## Assignment Questions: 

CREATE DATABASE employees;
USE employees;

#Q1 Create a table called employees with the following structure:  emp_id (integer,should not be NULL and should be a primary key),emp_name(text,should not be NULL), age(integer,should have a check constraint to ensure the age is at least 18),email(text,should be unique for each employee),salary(decimal,with a default value of 30,000).Write the SQL query to create the above table with all constraints.
CREATE TABLE employees (
emp_id INT NOT NULL PRIMARY KEY, 
emp_name VARCHAR(100) NOT NULL, 
age INT CHECK (age >= 18), 
email VARCHAR(255) UNIQUE, 
salary DECIMAL(10,2) DEFAULT 30000);

SELECT * FROM employees; 
INSERT INTO employees( emp_id, emp_name, age, email,salary) VALUES (1,'Shabana', 27,'shab@gmail.com', 30000);
SELECT * FROM employees;

#Q2 Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
-- Constraints in SQL are rules applied to table columns to ensure data accuracy and reliability. They prevent invalid data from being inserted.
-- Common Types of Constraints:
-- PRIMARY KEY - Ensures uniqueness for each record (e.g., emp_id).
-- FOREIGN KEY - Establishes a relationship between tables.
-- NOT NULL - Ensures that a column cannot have NULL values (e.g., emp_name).
-- UNIQUE - Ensures that all values in a column are distinct (e.g., email).
-- CHECK - Sets conditions for valid values (e.g., age >= 18).
-- DEFAULT - Assigns a default value if none is provided (e.g., salary = 30,000).
-- Constraints help maintain data consistency, prevent duplicates, and enforce business rules.

#Q3 Why would you apply the NOT NULL constraint? Can a primary key contain NULL values? Justify your answer.
-- The NOT NULL constraint ensures a column always has a value, preventing NULL values.
-- A Primary Key CANNOT contain NULL values because it uniquely identifies each record in the table. If NULL were allowed, some records would be unidentifiable.

#Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
-- Let’s assume we have an existing table called products without constraints:
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);
-- Adding a PRIMARY KEY Constraint
-- A PRIMARY KEY ensures each record is unique and cannot be NULL.
SELECT * FROM products;
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

INSERT INTO products (product_id, product_name, price) VALUES (1, 'Laptop', 800.00);
INSERT INTO products (product_id, product_name, price) VALUES (2, 'Mouse', 20.00);
INSERT INTO products (product_id, product_name, price) VALUES (1, 'Keyboard', 30.00); 

-- Adding a NOT NULL Constraint
-- To ensure product_name cannot be NULL:

ALTER TABLE products
MODIFY COLUMN product_name VARCHAR(50) NOT NULL;
INSERT INTO products (product_id, product_name, price) VALUES (3, NULL, 100.00);  

-- Adding a UNIQUE Constraint
-- To prevent duplicate product names:

ALTER TABLE products
ADD CONSTRAINT unique_product_name UNIQUE (product_name);

INSERT INTO products (product_id, product_name, price) VALUES (4, 'Monitor', 150.00);
INSERT INTO products (product_id, product_name, price) VALUES (5, 'Monitor', 170.00); 
-- Adding a CHECK Constraint
-- To ensure the price is always greater than 0:

ALTER TABLE products
ADD CONSTRAINT check_price CHECK (price > 0);
INSERT INTO products (product_id, product_name, price) VALUES (6, 'Headphones', -50.00); 

-- Adding a DEFAULT Constraint
-- To set the default price as 50.00:

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

INSERT INTO products (product_id, product_name) VALUES (7, 'Charger');
SELECT * FROM products WHERE product_id = 7;

-- Removing Constraints from an Existing Table
-- Removing a PRIMARY KEY Constraint
ALTER TABLE products
DROP CONSTRAINT pk_product;

-- Removing a NOT NULL Constraint
ALTER TABLE products
MODIFY COLUMN product_name VARCHAR(50) NULL;
-- Now, product_name can accept NULL values.

-- Removing a UNIQUE Constraint
ALTER TABLE products
DROP CONSTRAINT unique_product_name;
-- Now, multiple products can have the same product_name.

-- Removing a CHECK Constraint
ALTER TABLE products
DROP CONSTRAINT check_price;
-- Now, negative prices can be inserted.

-- Removing a DEFAULT Constraint
ALTER TABLE products
ALTER COLUMN price DROP DEFAULT;
-- Now, inserting a product without a price will result in NULL instead of 50.00.

#Q5 Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.Provide an example of an error message that might occur when violating a constraint.
-- If an operation violates a constraint, SQL throws an error.

-- Example Errors:
-- Inserting NULL into a NOT NULL column:
SELECT * FROM employees;
INSERT INTO employees (emp_id, emp_name) VALUES (1, NULL);
-- Error: ERROR: Column 'emp_name' cannot be null

-- Inserting duplicate value in a UNIQUE column:

INSERT INTO employees (emp_id, emp_name, email) VALUES (2, 'John', 'john@email.com');
INSERT INTO employees (emp_id, emp_name, email) VALUES (3, 'Jane', 'john@email.com');
-- Error: ERROR: Duplicate entry 'john@email.com' for key 'email'

-- Inserting a value that violates a CHECK constraint:

INSERT INTO employees (emp_id, emp_name, age) VALUES (4, 'Mark', 16);
-- Error: ERROR: Check constraint failed: age must be at least 18
-- Constraints prevent incorrect data from entering the database, ensuring data integrity.

#Q6 you created a products table without constraints as follows:
CREATE TABLE products(
	product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10,2));
-- Now,you realise that:
-- The product_id should be a primary key.
-- The price should have a default value of 50.00
SELECT * FROM products;
-- Make product_id a primary key
-- Set a default price of 50.00
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

#Q7 You have two tables:
-- students with columns: student_id, student_name, class_id
-- classes with columns: class_id, class_name
CREATE DATABASE students;
USE students;
SELECT * FROM students;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    class_id INT
);
-- Step 2: Insert Data into students Table
INSERT INTO students (student_id, student_name, class_id) VALUES 
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);
-- Step 3: Create the classes Table
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL
);
SELECT * FROM Classes;
-- Step 4: Insert Data into classes Table
INSERT INTO classes (class_id, class_name) VALUES 
(101, 'Math'),
(102, 'Science'),
(103, 'History');
-- Step 5: Fetch student_name and class_name Using INNER JOIN
SELECT students.student_name, classes.class_name
FROM students
INNER JOIN classes
ON students.class_id = classes.class_id;

#Q8 Display all order details with customer names and product names, ensuring all products are listed even if they are not associated with an order.
-- Table Creation and Data Insertion:
USE employees;
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT
);
SELECT * FROM Orders;


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO Customers (customer_id, customer_name) VALUES
(101, 'Alice'),
(102, 'Bob');

CREATE TABLE Productss (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    order_id INT
);

INSERT INTO Productss(product_id, product_name, order_id) VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);
-- SQL Query to Get Required Output:
SELECT 
    COALESCE(o.order_id, 'No Order') AS order_id, 
    COALESCE(c.customer_name, 'No Customer') AS customer_name, 
    p.product_name
FROM Productss p
LEFT JOIN Orders o ON p.order_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;

-- Explanation:
-- LEFT JOIN ensures all products are included, even those not linked to an order.
-- Orders are joined with customers to fetch customer_name.

-- Q9 Calculate the total sales amount for each product.
-- Table Creation and Data Insertion:
USE employees;
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    amount INT
);

INSERT INTO Sales (sale_id, product_id, amount) VALUES
(1, 101, 500),
(2, 102, 300),
(3, 101, 700);
USE employees;
CREATE TABLE Produccts (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

INSERT INTO Produccts (product_id, product_name) VALUES
(101, 'Laptop'),
(102, 'Phone');
-- SQL Query to Get Total Sales Amount per Product:
SELECT 
    p.product_name, 
    SUM(s.amount) AS total_sales
FROM Sales s
INNER JOIN Produccts p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Explanation:

-- INNER JOIN connects Sales and Products based on product_id.
-- SUM(amount) calculates total sales for each product.
-- GROUP BY ensures aggregation per product.

#Q10 Display all orders with customer names and product quantities.
-- Table Creation and Data Insertion:
USE students;
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT
);

INSERT INTO Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-02', 1),
(2, '2024-01-05', 2);

USE students;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO Customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob');

USE students;
CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO Order_Details (order_id, product_id, quantity) VALUES
(1, 101, 2),
(1, 102, 1),
(2, 101, 3);
-- SQL Query to Display Order Details:

SELECT 
    o.order_id, 
    c.customer_name, 
    od.product_id,
    od.quantity
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id;
-- Explanation:
-- INNER JOIN links Orders with Customers to get customer_name.
-- Another INNER JOIN connects Orders with Order_Details to fetch product_id and quantity.

### SQL COMMANDS: 


USE mavenmovies;

#Q1. Identify the primary keys and foreign keys in maven movies db. Discuss the differences.
-- (This requires schema analysis, but in general)
-- Primary Key: Uniquely identifies a record in a table.
-- Foreign Key: A reference to a Primary Key in another table.

#Q2. List all details of actors
SELECT * FROM mavenmovies.actor;

#Q3. List all customer information from DB.
SELECT * FROM mavenmovies.customer;

#Q4. List different countries.
SELECT DISTINCT country FROM country;

#Q5. Display all active customers.
SELECT * FROM customer WHERE active = 1;

#Q6. List all rental IDs for customer with ID 1.
SELECT rental_id FROM rental WHERE customer_id = 1;

#Q7. Display all the films whose rental duration is greater than 5.
SELECT * FROM film WHERE rental_duration > 5;

#Q8. List the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT COUNT(*) FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

#Q9. Display the count of unique first names of actors.
SELECT COUNT(DISTINCT first_name) FROM actor;

#Q10. Display the first 10 records from the customer table.
SELECT * FROM customer LIMIT 10;

#Q11. Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT * FROM customer WHERE first_name LIKE 'b%' LIMIT 3;

#Q12. Display the names of the first 5 movies which are rated as ‘G’.
SELECT title FROM film WHERE rating = 'G' LIMIT 5;

#Q13. Find all customers whose first name starts with "a".
SELECT * FROM customer WHERE first_name LIKE 'a%';

#Q14. Find all customers whose first name ends with "a".
SELECT * FROM customer WHERE first_name LIKE '%a';

#Q15. Display the list of first 4 cities which start and end with ‘a’.
SELECT city FROM city WHERE city LIKE 'a%a' LIMIT 4;

#Q16. Find all customers whose first name has "Ni" in any position.
SELECT * FROM customer WHERE first_name LIKE '%Ni%';

#Q17. Find all customers whose first name has "r" in the second position.
SELECT * FROM customer WHERE first_name LIKE '_r%';

#Q18. Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * FROM customer WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

#Q19. Find all customers whose first name starts with "a" and ends with "o".
SELECT * FROM customer WHERE first_name LIKE 'a%o';

#Q20. Get the films with PG and PG-13 rating using IN operator.
SELECT * FROM film WHERE rating IN ('PG', 'PG-13');

#Q21. Get the films with length between 50 to 100 using BETWEEN operator.
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

#Q22. Get the top 50 actors using LIMIT operator.
SELECT * FROM actor LIMIT 50;

#Q23. Get the distinct film IDs from the inventory table.
SELECT DISTINCT film_id FROM inventory;

### FUNCTIONS
## Basic Aggregate Functions: 
USE mavenmovies;

# Question 1: Retrieve the total number of rentals made in the Sakila database.
SELECT COUNT(*) AS total_rentals FROM rental;

# Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT AVG(rental_duration) AS avg_rental_duration FROM film;

# Question 3: Display the first name and last name of customers in uppercase.
SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name FROM customer;

# Question 4: Extract the month from the rental date and display it alongside the rental ID.
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

# Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id, COUNT(*) AS rental_count 
FROM rental 
GROUP BY customer_id;

# Question 6: Find the total revenue generated by each store.
SELECT store_id, SUM(amount) AS total_revenue 
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY store_id;

# Question 7: Determine the total number of rentals for each category of movies.
SELECT c.name AS category, COUNT(rental.rental_id) AS total_rentals
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category fc ON film.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

# Question 8: Find the average rental rate of movies in each language.
SELECT l.name AS language, AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

### Joins:

# Question 9: Display the title of the movie, customer’s first name, and last name who rented it.
SELECT f.title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

# Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

# Question 11: Retrieve the customer names along with the total amount they've spent on rentals.
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

# Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London').
SELECT c.first_name, c.last_name, f.title, ct.city
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ct.city = 'London';

### Advanced Joins and GROUP BY:

# Question 13: Display the top 5 rented movies along with the number of times they’ve been rented.
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

# Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT c.customer_id, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;

### Windows Functions:

#Q1. Rank the customers based on the total amount they've spent on rentals.
SELECT c.customer_id, c.first_name, c.last_name, 
       SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;


#Q2. Calculate the cumulative revenue generated by each film over time.
SELECT f.title, p.payment_date, SUM(p.amount) 
       OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;

#Q3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT f.film_id, f.title, f.length, AVG(f.rental_duration)
       OVER (PARTITION BY f.length) AS avg_rental_duration
FROM film f;

#Q4. Identify the top 3 films in each category based on their rental counts.
SELECT category, title, rental_count, ranking
FROM (
    SELECT c.name AS category, f.title, COUNT(r.rental_id) AS rental_count,
           RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS ranking
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.name, f.title
) ranked
WHERE ranking <= 3;

#Q5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
WITH rental_counts AS (
    SELECT c.customer_id, c.first_name, c.last_name, 
           COUNT(r.rental_id) AS total_rentals
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_id, first_name, last_name, total_rentals,
       total_rentals - AVG(total_rentals) OVER () AS rental_difference
FROM rental_counts;

#Q6. Find the monthly revenue trend for the entire rental store over time.
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, SUM(amount) AS monthly_revenue
FROM payment
GROUP BY month
ORDER BY month;

#Q7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
SELECT customer_id, first_name, last_name, total_spent
FROM (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
           PERCENT_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS percentile_rank
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) ranked
WHERE percentile_rank <= 0.20;

#Q8. Calculate the running total of rentals per category, ordered by rental count.
SELECT c.name AS category, COUNT(r.rental_id) AS rental_count,
       SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id)) AS running_total
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

#Q9. Find the films that have been rented less than the average rental count for their respective categories.
WITH rental_data AS (
    SELECT f.title, 
           c.name AS category, 
           COUNT(r.rental_id) AS rental_count,
           AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.name) AS avg_rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY f.title, c.name
)
SELECT title, category, rental_count
FROM rental_data
WHERE rental_count < avg_rental_count;

#Q10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
SELECT month, monthly_revenue
FROM (
    SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, SUM(amount) AS monthly_revenue,
           RANK() OVER (ORDER BY SUM(amount) DESC) AS ranking
    FROM payment
    GROUP BY month
) ranked
WHERE ranking <= 5;

### NORMALISATION & CTE
USE mavenmovies;

## 1. First Normal Form (1NF)
#Q1. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.

-- A table violates 1NF if it contains repeating groups or multiple values in a single column.

-- Example: film table with multiple categories in a single column

SELECT film_id, category_id FROM film_category;

-- This table already follows 1NF because it breaks categories into multiple rows.
-- If a table stored multiple categories in a single column like "Action, Comedy", it would violate 1NF.

##2. Second Normal Form (2NF)
#Q2: Choose a table in Sakila and determine whether it is in 2NF. If it violates 2NF, explain how to normalize it.

-- A table violates 2NF if it has partial dependencies, meaning a non-key attribute depends only on part of a composite primary key.

-- Example: film_actor Table

DESC film_actor;

-- It has a composite key (actor_id, film_id). If we added actor_name here, it would violate 2NF because actor_name depends only on actor_id.

-- Fix: Move actor_name to the actor table.

## 3. Third Normal Form (3NF)
#Q3. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize it.

-- A table violates 3NF if it has transitive dependencies, meaning a non-key column depends on another non-key column instead of the primary key.

-- Example: customer Table

DESC customer;

-- If customer has a city_name column, it violates 3NF because city_name depends on city_id, not customer_id.

--  Remove city_name from customer and join it via city_id.

## 4. Normalization Process
#Q4. Take a specific table in Sakila and normalize it up to at least 2NF.

-- Example: rental table normalization.
--  If rental stored customer_address, move it to customer table.
-- Ensure rental only stores customer_id, inventory_id, and rental_date.

## 5. CTE Basics
#Q5. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in.
WITH ActorFilms AS (
    SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS film_count
    FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id
    GROUP BY actor.actor_id
)
SELECT * FROM ActorFilms;


## 6. CTE with Joins
#Q6. Create a CTE that combines information from film and language tables to display the film title, language name, and rental rate.

WITH FilmDetails AS (
    SELECT film.title, language.name AS language_name, film.rental_rate
    FROM film
    JOIN language ON film.language_id = language.language_id
)
SELECT * FROM FilmDetails;

##7. CTE for Aggregation
#Q7. Write a query using a CTE to find the total revenue generated by each customer.

WITH CustomerRevenue AS (
    SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(payment.amount) AS total_revenue
    FROM customer
    JOIN payment ON customer.customer_id = payment.customer_id
    GROUP BY customer.customer_id
)
SELECT * FROM CustomerRevenue ORDER BY total_revenue DESC;

## 8. CTE with Window Functions
#Q8. Utilize a CTE with a window function to rank films based on rental duration.


WITH FilmRanking AS (
    SELECT film_id, title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS rank_position
    FROM film
)
SELECT * FROM FilmRanking;

## 9. CTE and Filtering
#Q9. Create a CTE to list customers who have made more than two rentals and join it with the customer table for additional details.

WITH FrequentRenters AS (
    SELECT customer_id, COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)
SELECT customer.first_name, customer.last_name, customer.email, FrequentRenters.rental_count
FROM customer
JOIN FrequentRenters ON customer.customer_id = FrequentRenters.customer_id;

## 10. CTE for Date Calculations
#Q10. Write a query using a CTE to find the total number of rentals made each month.

WITH MonthlyRentals AS (
    SELECT MONTH(rental_date) AS rental_month, COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY rental_month
)
SELECT * FROM MonthlyRentals;

## 11. CTE and Self-Join
#Q11. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together.

WITH ActorPairs AS (
    SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2, fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT a1.first_name AS actor1_name, a2.first_name AS actor2_name, ActorPairs.film_id
FROM ActorPairs
JOIN actor a1 ON ActorPairs.actor1 = a1.actor_id
JOIN actor a2 ON ActorPairs.actor2 = a2.actor_id;

## 12. CTE for Recursive Search
#Q12.Implement a recursive CTE to find all employees who report to a specific manager.
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT staff_id, first_name, last_name, store_id
    FROM staff
    WHERE store_id IS NOT NULL
    UNION ALL
    SELECT s.staff_id, s.first_name, s.last_name, e.store_id
    FROM staff s
    INNER JOIN EmployeeHierarchy e ON s.store_id = e.staff_id
)
SELECT * FROM EmployeeHierarchy;