--BusinessFinancing.co.uk researched the oldest company that is still in business in (almost) every country and compiled the results into a dataset. 
--In this project, I'll explore that dataset.

--The database contains three tables: categories (category_code, category), countries(country_code, country, continent) and businesses (business, year_founded, category_code, country_code).



-- Select the oldest and newest founding years from the businesses table:

SELECT MIN(year_founded), 
       MAX(year_founded)
FROM businesses;
    
--output: The oldest open and operating business in the world founded in 578 and the youngest in 1999.
    


-- Getting the number of categories :

SELECT COUNT(*) 
   FROM categories; 

--Output: 19 categories.



-- Getting number of countries:

SELECT COUNT(*) 
    FROM countries;

--Output: 195 country.



-- Get the number of businesses where the founding year was before 1000:

SELECT COUNT(*)
    FROM businesses
    WHERE year_founded < 1000;   
    
-- Output: 6 businesses were founded before the year 1000.    
    
    
    
-- Which businesses were founded before 1000?

SELECT business, year_founded
  FROM businesses
    WHERE year_founded < 1000
    ORDER BY year_founded;
    
--Outout:   
 /**
  Kongō Gumi	578
  St. Peter Stifts Kulinarium	803
  Staffelter Hof Winery	862
  Monnaie de Paris 	864
  The Royal Mint	886
  Sean's Bar	900
  **/


-- What did Kongō Gumi (oldest business in the world)	do?

SELECT b.business, b.year_founded, c.category
    FROM businesses AS b
    INNER JOIN categories AS c
        ON b.category_code = c.category_code
    WHERE year_founded < 1000
    ORDER BY year_founded;
    
--Output: Kongō Gumi did Construction 



-- Which country did Kongō Gumi belongs to?

SELECT b.business, b.year_founded, b.country_code, coun.country, c.category
    FROM businesses AS b
    INNER JOIN categories AS c
        ON b.category_code = c.category_code
    INNER JOIN countries AS coun
        ON b.country_code = coun.country_code
    WHERE year_founded < 1000
    ORDER BY year_founded;
    
--Output:  Japan



-- Counting the categories of the oldest businesses in the world:

SELECT c.category, COUNT(c.category) AS n
    FROM businesses AS b
    INNER JOIN categories AS c
        ON b.category_code = c.category_code
    GROUP BY c.category
    ORDER BY n DESC
    LIMIT 10;
    
--Output: Top two industries are Banking & Finance then Distillers, Vintners, & Breweries.



-- Oldest and youngest business by continent

SELECT  cnt.continent, MIN(b.year_founded) as oldest ,  
        MAX(b.year_founded) as youngest
    FROM businesses AS b
    INNER JOIN countries as cnt
        ON b.country_code = cnt.country_code
    GROUP BY continent
    ORDER BY oldest;
    
--Output: Asia (Japan) has the oldest business and Europe has the freshest business.



-- Oldest Business in each continent:

SELECT b.business, cnt.continent, cnt.country, b.year_founded
    FROM businesses AS b
    INNER JOIN countries as cnt
        ON b.country_code = cnt.country_code
    GROUP BY cnt.continent, cnt.country, b.business, b.year_founded
    order by b.year_founded
   
--Outout: 
 /**Kongō Gumi	                      Asia	             Japan	     578
  St. Peter Stifts Kulinarium	      Europe	           Austria   	 803
  La Casa de Moneda de México	      North America	     Mexico	    1534
  Casa Nacional de Moneda	          South America    	 Peru	      1565
  Mauritius Post	                  Africa	           Mauritius	1772
  Australia Post                   	Oceania          	 Australia	1809 
  **/




-- Count the number of businesses in each continent and category

SELECT cnt.continent, c.category, COUNT(*) AS n
    FROM businesses AS b
    INNER JOIN categories as c
        ON b.category_code = c.category_code
    INNER JOIN countries as cnt
        ON b.country_code = cnt.country_code
    GROUP BY cnt.continent, c.category
    ORDER BY n DESC;
    
--Output: Africa, Banking & Finance,	17