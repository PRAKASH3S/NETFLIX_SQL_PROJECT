---verify whether table got created
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix (
    show_id       VARCHAR(6),
    type          VARCHAR(10),
    title         VARCHAR(150),
    director      VARCHAR(208),
    casts         VARCHAR(1000),
    country       VARCHAR(150),
    date_added    VARCHAR(50),
    release_year  INT,
    rating        VARCHAR(10),
    duration      VARCHAR(15),
    listed_in     VARCHAR(80),
    description   VARCHAR(250)
);
SELECT * FROM netflix;

-- 15 Business Problems & Solutions


-- 15 Business Problems & Solutions

'''1. Count the number of Movies vs TV Shows
2. Find the most common rating for movies and TV shows
3. List all movies released in a specific year (e.g., 2020)
4. Find the top 5 countries with the most content on Netflix
5. Identify the longest movie
6. Find content added in the last 5 years
7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
8. List all TV shows with more than 5 seasons
9. Count the number of content items in each genre
10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
11. List all movies that are documentaries
12. Find all content without a director
13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.'''



SELECT 
	* 
FROM 
	netflix;
--1. Count the number of Movies vs TV Shows
SELECT 
	type,
	COUNT(*) AS total_content
FROM 
	netflix
GROUP BY 
	type;

--2. Find the most common rating for movies and TV shows

SELECT 
	type,
	rating
FROM 
	(SELECT 
	type,
	rating,
	count(*) AS COUNT,
	RANK() OVER(PARTITION BY type ORDER BY count(*) DESC) as ranking
FROM netflix
Group by type, rating) AS t1
WHERE RANKING = 1;

----3. List all movies released in a specific year (e.g., 2020)
SELECT * FROM NETFLIX;
SELECT 
	title
FROM NETFLIX
WHERE type = 'Movie' and release_year = 2020;

---4. Find the top 5 countries with the most content on Netflix

SELECT 
	TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS new_country,
	COUNT(show_id) AS total_content
FROM 
	netflix
GROUP BY 
	new_country
ORDER BY total_content DESC
LIMIT 5;

---5. Identify the longest movie
SELECT 
    title,
    CAST(REPLACE(duration, ' min', '') AS INTEGER) AS duration_minutes
FROM 
    netflix
WHERE 
    type = 'Movie' 
    AND duration IS NOT NULL
ORDER BY 
    duration_minutes DESC
LIMIT 1;

---6.Find content added in the last 5 years
SELECT 
	*
FROM
	netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE -INTERVAL '5 years';

----7.Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT
	type, 
	title, 
	director
FROM 
	netflix
WHERE 
	director = 'Rajiv Chilaka';

---8. List all TV shows with more than 5 seasons

SELECT
	*	
FROM 
	netflix
WHERE type ='TV Show' and SPLIT_PART(duration, ' ', 1)::numeric > 5;

---9. Count the number of content items in each genre


SELECT
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
	COUNT(*) AS total_content
FROM 
	netflix
GROUP BY
	genre
ORDER BY 
	genre ASC;

--- 10.Find each year and the  number of content release in India on netflix.

WITH country_split AS (
    SELECT 
        EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
        TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name
    FROM netflix
)
SELECT 
    year,
    COUNT(*) AS india_releases
FROM country_split
WHERE country_name = 'India'
GROUP BY year
ORDER BY year;

---11. List all movies that are documentaries(869 without unnest)
SELECT 
	*
FROM 
	netflix
WHERE 
	listed_in	ILIKE '%Documentaries%';

--12. Find all content without a director
SELECT 
	* 
FROM 
	netflix
WHERE director IS NULL;

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT 
	*
FROM 
	netflix
WHERE 
	casts ILIKE '%Salman Khan%'
AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10
--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actors,
	COUNT(*) AS total_content
FROM 
	netflix
WHERE
	country ILIKE '%india%'
GROUP BY 
	1
ORDER BY 
	2 DESC
LIMIT 10

--15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.

WITH new_table 
AS
(
SELECT 
	*,
	CASE
	WHEN
		description ILIKE '%kill%' OR
		description ILIKE '%violence%'
		THEN 'Good_Content'
		ELSE 'Bad_Content'
		END category
FROM NETFLIX
)
SELECT 
	category,
	COUNT(*) as total_content
FROM 
	new_table
GROUP BY 
	category;


