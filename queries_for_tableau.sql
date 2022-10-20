SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 AS DeathPercentage
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations`
WHERE continent IS NOT NULL
order by 1,2;


-- 2. 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(new_deaths) AS TotalDeathCount
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations`
WHERE continent IS NULL 
AND location NOT IN ('World', 'European Union', 'International', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
GROUP BY location
ORDER BY TotalDeathCount DESC;


-- 3.

SELECT Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations`
GROUP BY Location, Population
ORDER BY PercentPopulationInfected desc;


-- 4.


SELECT Location, Population, date, MAX(total_cases) AS HighestInfectionCount,  Max((total_cases/population))*100 AS PercentPopulationInfected
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations`
GROUP BY Location, Population, date
ORDER BY PercentPopulationInfected DESC;