-- 1
SELECT name 
FROM world 
WHERE population > (SELECT population FROM world WHERE name = 'Russia');

-- 2
SELECT name 
FROM world 
WHERE continent = 'Europe' 
AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom');

-- 3
SELECT name, continent 
FROM world 
WHERE continent IN (
    SELECT continent FROM world WHERE name IN ('Argentina', 'Australia')
)
ORDER BY name;

-- 4
SELECT name, population 
FROM world 
WHERE population > (SELECT population FROM world WHERE name = 'United Kingdom') 
AND population < (SELECT population FROM world WHERE name = 'Germany');

-- 5
SELECT name, 
       CONCAT(ROUND((population * 100.0) / 
       (SELECT population FROM world WHERE name = 'Germany'), 0), '%') AS percentage
FROM world
WHERE continent = 'Europe';

-- 6
SELECT name 
FROM world 
WHERE gdp > ALL (SELECT gdp FROM world WHERE continent = 'Europe' AND gdp IS NOT NULL);

-- 7
SELECT continent, name, area
FROM world 
WHERE area IN (
    SELECT MAX(area) 
    FROM world 
    GROUP BY continent
);


-- 8
SELECT continent, name
FROM world
WHERE (continent, name) IN (
    SELECT continent, MIN(name)
    FROM world
    GROUP BY continent
);

-- 9
SELECT name, continent, population
FROM world
WHERE continent IN (
    SELECT continent
    FROM world
    GROUP BY continent
    HAVING MIN(population) <= 25000000 AND MAX(population) <= 25000000
);

-- 10
SELECT name, continent
FROM world x
WHERE population > ALL (
  SELECT 3 * population
  FROM world y
  WHERE y.continent = x.continent AND y.name != x.name
);

