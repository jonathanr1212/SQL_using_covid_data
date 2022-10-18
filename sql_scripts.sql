SELECT location, date, total_cases, new_cases, total_deaths, population FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations` 
ORDER BY 1, 2;

-- Checking total cases vs total deaths
-- Shows the likelihood if you contract covid in your country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations` 
ORDER BY 1, 2;

-- Looking at the total cases vs population
-- Shows what percentage of population got covid

SELECT location, date, total_cases, population, (total_cases/population)*100 AS InfectionPercentage
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations` 
WHERE location LIKE '%States%'
ORDER BY 1, 2;

-- Looking at countries with highest infection rate compared to population

SELECT location,population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS InfectionPercentage
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations` 
GROUP BY location, population
ORDER BY InfectionPercentage DESC;


-- Showing countries with the highest death count per population

SELECT location, MAX(total_deaths) AS TotalDeathCount
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations` 
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- Let's see what happens when we look death counts at it by continent
SELECT continent, MAX(total_deaths) AS TotalDeathCount
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations` 
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Looking at global numbers per day
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS DeathPercentage
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations` 
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2;

-- Looking at global numbers total
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS DeathPercentage
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations` 
WHERE continent IS NOT NULL
ORDER BY 1, 2;

-- Looking at total population vs vaccinations
SELECT continent, location, date, population, new_vaccinations
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations`
WHERE continent IS NOT NULL
ORDER BY 2,3;

-- Checking rolling count for each location
SELECT continent, location, date, population, new_vaccinations,
SUM(new_vaccinations) 
OVER(PARTITION BY location
ORDER BY location, date) AS RollingPeopleVaccinated,
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations`
WHERE continent IS NOT NULL
ORDER BY 2,3;

-- Using CTE
WITH PopvsVac AS 
(SELECT continent, location, date, population, new_vaccinations,
SUM(new_vaccinations) 
OVER(PARTITION BY location
ORDER BY location, date) AS RollingPeopleVaccinated,
FROM `fluted-bot-365817.covid_data.covid_deaths_and_vaccinations`
WHERE continent IS NOT NULL)
SELECT continent, location, date, population,new_vaccinations, RollingPeopleVaccinated, (RollingPeopleVaccinated/population)*100
FROM PopvsVac;
