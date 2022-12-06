SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM `covidanalysis-370814.covid_data.covid_deaths`
ORDER BY 1,2;

-- Looking at total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country
SELECT location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS death_percentage 
FROM `covidanalysis-370814.covid_data.covid_deaths`
ORDER BY 1,2;

-- Looking at total cases vs total deaths for US
-- shows likelihood of dying if you contract covid in the US
SELECT location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS death_percentage 
FROM `covidanalysis-370814.covid_data.covid_deaths`
WHERE location LIKE '%States%'
ORDER BY 1,2;

-- Looking at total cases vs population
-- shows what percentage of population caught covid in the US
SELECT location, date, total_cases, population,(total_cases/population)*100 AS infection_percentage 
FROM `covidanalysis-370814.covid_data.covid_deaths`
WHERE location LIKE '%States%'
ORDER BY 1,2;

-- Looking at countries with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS highest_infection_count,MAX((total_cases/population))*100 AS infection_percentage 
FROM `covidanalysis-370814.covid_data.covid_deaths`
GROUP BY location, population
ORDER BY infection_percentage DESC;

-- Showing countries with the highest death count per population
SELECT location, MAX(total_deaths) AS total_death_count
FROM `covidanalysis-370814.covid_data.covid_deaths`
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC;

-- Showing the continents with the highest death counts
SELECT continent, MAX(total_deaths) AS total_death_count
FROM `covidanalysis-370814.covid_data.covid_deaths`
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;

-- Global numbers
-- By day
SELECT date, SUM(new_cases)AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage
FROM `covidanalysis-370814.covid_data.covid_deaths`
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

-- Overall
SELECT SUM(new_cases)AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage
FROM `covidanalysis-370814.covid_data.covid_deaths`
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Looking at total population vs vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM `covidanalysis-370814.covid_data.covid_deaths` AS dea
JOIN `covidanalysis-370814.covid_data.covid_vaccinations` AS vac
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

-- Using a CTE

WITH PopvsVac AS( 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM `covidanalysis-370814.covid_data.covid_deaths` AS dea
JOIN `covidanalysis-370814.covid_data.covid_vaccinations` AS vac
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)

SELECT *, (rolling_people_vaccinated/population)*100
FROM PopvsVac;

-- Using a temp table
CREATE TEMP TABLE  percent_population_vaccinated AS(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM `covidanalysis-370814.covid_data.covid_deaths` AS dea
JOIN `covidanalysis-370814.covid_data.covid_vaccinations` AS vac
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
);

SELECT *, (rolling_people_vaccinated/population)*100
FROM percent_population_vaccinated;
