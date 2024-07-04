SELECT * FROM
[Portfolio Project SQL]..CovidDeaths$
WHERE continent is not null 

SELECT * FROM
[Portfolio Project SQL]..Covidvaccination$

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM [Portfolio Project SQL]..CovidDeaths$

SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
FROM [Portfolio Project SQL]..CovidDeaths$
WHERE continent is not null 
WHERE location like 'india'
ORDER BY 1,2

SELECT location,date,total_cases,population,(total_cases/population)*100 as Casespercentage
FROM [Portfolio Project SQL]..CovidDeaths$
WHERE continent is not null 
WHERE location like 'india'
ORDER BY 1,2

SELECT location,population,MAX(total_cases) as Highestinfectioncount,MAX(total_cases/population)*100 AS Percentpopoulationinfected
FROM [Portfolio Project SQL]..CovidDeaths$
WHERE continent is null 
GROUP BY location,population
ORDER BY Highestinfectioncount DESC

SELECT continent,MAX(cast(total_deaths as int)) as Highestdeathcount
FROM [Portfolio Project SQL]..CovidDeaths$
WHERE continent is not null 
GROUP BY continent
ORDER BY Highestdeathcount desc

SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
FROM [Portfolio Project SQL]..CovidDeaths$
WHERE continent is not null 
WHERE location like 'india'
ORDER BY 1,2


SELECT location,MAX(cast(Total_deaths as int))as TotalDEathCount
FROM CovidDeaths$
WHERE continent is null
GROUP BY location
ORDER BY TotalDEathCount


SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
FROM [Portfolio Project SQL]..CovidDeaths$
WHERE continent is not null 
WHERE location like 'india'
ORDER BY 1,2

 SELECT *
 FROM CovidDeaths$ dea
 JOIN Covidvaccination$ vac
	ON dea.location=vac.location
	AND dea.date=vac.date


 SELECT dea.continent,dea.location,dea.date,vac.new_vaccinations
 FROM CovidDeaths$ dea
 JOIN Covidvaccination$ vac
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent is not NULL
ORDER BY 2,3

SELECT dea.continent,dea.location,dea.date,vac.new_vaccinations
 FROM CovidDeaths$ dea
 JOIN Covidvaccination$ vac
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent is not NULL
ORDER BY 2,3

SELECT dea.continent,dea.location,dea.date,vac.new_vaccinations,
 SUM(CONVERT(int,vac.new_vaccinations))OVER(PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS RollingPeopleVaccinated,
FROM CovidDeaths$ dea
 JOIN Covidvaccination$ vac
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent is not NULL
ORDER BY 2,3

 
With popvsvac(continent,location,date,population,new_vaccinations,RollingPeopleVaccinated)
as
(
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 SUM(CONVERT(int,vac.new_vaccinations))OVER(PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS RollingPeopleVaccinated
FROM CovidDeaths$ dea
 JOIN Covidvaccination$ vac
	ON dea.location=vac.location
	AND dea.date=vac.date
WHERE dea.continent is not NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeoplevaccinated/population)*100
FROM popvsvac

DROP TABLE IF exists #PercentpeopleVaccinated
CREATE TABLE #PercentpeopleVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric,
)

INSERT INTO #PercentpeopleVaccinated
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations))OVER(PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS RollingPeopleVaccinated
FROM CovidDeaths$ dea
 JOIN Covidvaccination$ vac
	ON dea.location=vac.location
	AND dea.date=vac.date
	WHERE dea.continent is not NULL


SELECT *,(RollingPeopleVaccinated/population)*100 
FROM #PercentpeopleVaccinated

--ORDER BY 2,3

CREATE View #PercentpeopleVaccinated as
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations))OVER(PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS RollingPeopleVaccinated
FROM CovidDeaths$ dea
 JOIN Covidvaccination$ vac
	ON dea.location=vac.location
	AND dea.date=vac.date
	WHERE dea.continent is not NULL

