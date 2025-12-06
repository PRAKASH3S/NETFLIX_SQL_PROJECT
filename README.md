# Netflix Movies and TV Shows Data Analysis using SQL
![](https://github.com/PRAKASH3S/NETFLIX_SQL_PROJECT/blob/main/logo.png)
This project focuses on exploring and analyzing Netflix’s catalog dataset using SQL to uncover business insights related to content strategy, production trends, and audience distribution.
##🎯 Objectives

The project aims to:

Understand Netflix’s content distribution across different dimensions (type, country, rating, and genre).

Solve 15 real-world business problems through structured SQL queries.

Demonstrate data engineering practices such as table creation, filtering, aggregation, ranking, and categorization.

Practice query optimization and use of advanced SQL concepts like window functions, CTEs, string manipulation, and date extraction.

##🧰 Tools & Technologies

SQL (PostgreSQL)

Dataset: Netflix titles dataset

Environment: SQL IDE

##🗂️ Database Schema
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

##💡 Business Problems Solved

1.Count the number of Movies vs TV Shows.

2.Find the most common rating for Movies and TV Shows.

3.List all Movies released in a specific year (e.g., 2020).

4.Identify the Top 5 countries with the most content.

5.Find the longest movie on Netflix.

6.Retrieve content added in the last 5 years.

7.List all titles directed by Rajiv Chilaka.

8.Find all TV Shows with more than 5 seasons.

9.Count content items in each genre/category.

10.Find yearly content release trends in India and top 5 years with highest output.

11.List all Documentaries on Netflix.

12.Identify content without a director listed.

13.Count how many movies actor ‘Salman Khan’ appeared in during the last 10 years.

14.Find the Top 10 actors with the most appearances in Indian movies.

15.Categorize content based on “kill” or “violence” keywords in descriptions — labeling as Good_Content or Bad_Content.
