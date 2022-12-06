SELECT SUM(new_cases)AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage
FROM `covidanalysis-370814.covid_data.covid_deaths`
WHERE continent IS NOT NULL
ORDER BY 1,2;


-- 2. 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

SELECT location, SUM(new_deaths) AS TotalDeathCount
FROM `covidanalysis-370814.covid_data.covid_deaths`
WHERE continent IS NULL 
AND location NOT IN ('World', 'European Union', 'International', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
GROUP BY location
ORDER BY TotalDeathCount DESC;


-- 3.

SELECT Location, Population, MAX(total_cases) as HighestInfectionCount,  MAX((total_cases/population))*100 as PercentPopulationInfected
FROM `covidanalysis-370814.covid_data.covid_deaths`
GROUP BY Location, Population
ORDER BY PercentPopulationInfected desc;


-- 4.


SELECT Location, Population, date, MAX(total_cases) AS HighestInfectionCount,  Max((total_cases/population))*100 AS PercentPopulationInfected
FROM `covidanalysis-370814.covid_data.covid_deaths`
GROUP BY Location, Population, date
ORDER BY PercentPopulationInfected DESC;