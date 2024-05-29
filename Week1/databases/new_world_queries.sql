select name from country where population > 8000000;

select name from country like '%land%';

SELECT name FROM country WHERE name LIKE '%land%';

select name from city where population between 500000 and 1000000;

SELECT city.name
FROM city
JOIN country ON city.id = country.capital
WHERE country.continent = 'Europe';

select name from country where city >10 and total_city_population >50000000;

select country.name from country join city on country.code = city.country_code
group by country.name
having count(city.id) > 10 and sum(city.population) > 50000000;
desc country;

desc city;

SELECT country.name
FROM country
JOIN city ON country.code = city.country_code
GROUP BY country.name
HAVING COUNT(city.id) > 10 AND SUM (city.population) > 50000000;

desc country;

select country.name
from country
join city on country.code = city.countryCode
group by country.name
having count(city.id) > 10 and sum(city.population) > 50000000;

desc table;

desc city;

select city.name 
from city 
join country on city.CountryCode = country.Code 
where country.name in (
    select country.name 
    from country 
    join city on country.Code = city.CountryCode 
    group by country.Name 
    having count(city.ID) > 10 and sum(city.Population) > 50000000
) and city.Population > 5000000;


select country.Continent, country.Name, city.Name as Capital
from country 
join city on country.Capital = city.ID 
where (country.Population / country.SurfaceArea) > 1000;

select Continent, Name, SurfaceArea 
from country 
where Continent != 'Antarctica' 
and SurfaceArea = (
    select max(SurfaceArea) 
    from country as c 
    where c.Continent = country.Continent
);


use 




