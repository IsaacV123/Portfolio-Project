SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [Portfolio Project]..[covid-deaths]
Where location like '%states%' and continent is not null
ORDER BY 1,2



SELECT Location, date, Population, total_cases,  (total_cases/Population)*100 as PercentagePopulationInfected
FROM [Portfolio Project]..[covid-deaths]
Where continent is not null
ORDER BY 1,2



SELECT Location, Population, MAX(total_cases) as HighesInfectionCount,  MAX((total_cases/Population))*100 as PercentagePopulationInfected
FROM [Portfolio Project]..[covid-deaths]
Where continent is not null
GROUP BY Location, Population
ORDER BY PercentagePopulationInfected desc



SELECT Location,  MAX(Total_deaths ) as TotalDeathCount
FROM [Portfolio Project]..[covid-deaths]
Where continent is not null
GROUP BY Location
ORDER BY TotalDeathCount desc


SELECT continent,  MAX(Total_deaths ) as TotalDeathCount
FROM [Portfolio Project]..[covid-deaths]
Where continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc



SELECT Location,  MAX(Total_deaths ) as TotalDeathCount
FROM [Portfolio Project]..[covid-deaths]
Where continent is  null
GROUP BY Location
ORDER BY TotalDeathCount desc



SELECT  date, SUM(new_cases) as Total_Cases, SUM(new_deaths) as Total_Deaths, SUM(new_deaths) /  Nullif(SUM(new_cases),0)*100 as DeathPercentage
FROM [Portfolio Project]..[covid-deaths]
Where continent is not null
GROUP BY date
ORDER BY 1,2


SELECT  SUM(new_cases) as Total_Cases, SUM(new_deaths) as Total_Deaths, SUM(new_deaths) /  Nullif(SUM(new_cases),0)*100 as DeathPercentage
FROM [Portfolio Project]..[covid-deaths]
Where continent is not null
ORDER BY 1,2



SELECT date, SUM(new_cases), SUM(new_deaths)*100
FROM [Portfolio Project]..[covid-deaths]
Where continent is not null
GROUP BY date
ORDER BY 1,2



Select *
FROM [Portfolio Project]..[covid-deaths] dea
Join [Portfolio Project]..[covid-vaccinations] vac
	ON dea.location = vac.location
	and dea.date = vac.date



Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (Partition BY dea.location ORDER BY dea.location, dea.date) as Rollingpeoplevaccinated, (Rollingpeoplevaccinated/population)*100
FROM [Portfolio Project]..[covid-deaths] dea
Join [Portfolio Project]..[covid-vaccinations] vac  
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
ORDER BY 2,3


with PopvsVac (continent, location, date, population, new_vaccinations, Rollingpeoplevaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (Partition BY dea.location ORDER BY dea.location, dea.date) as Rollingpeoplevaccinated
--(Rollingpeoplevaccinated /population)*100
FROM [Portfolio Project]..[covid-deaths] dea
Join [Portfolio Project]..[covid-vaccinations] vac  
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--ORDER BY 2,3
)
select *, (Rollingpeoplevaccinated /population)*100
From PopvsVac





DROP Table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric,
new_vaccinations numeric,
Rollingpeoplevaccinated numeric
) 

Insert Into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (Partition BY dea.location ORDER BY dea.location, dea.date) as Rollingpeoplevaccinated
--(Rollingpeoplevaccinated /population)*100
FROM [Portfolio Project]..[covid-deaths] dea
Join [Portfolio Project]..[covid-vaccinations] vac  
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--ORDER BY 2,3

select *, (Rollingpeoplevaccinated /population)*100
From #PercentPopulationVaccinated
  



Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (Partition BY dea.location ORDER BY dea.location, dea.date) as Rollingpeoplevaccinated
--(Rollingpeoplevaccinated /population)*100
FROM [Portfolio Project]..[covid-deaths] dea
Join [Portfolio Project]..[covid-vaccinations] vac  
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--ORDER BY 2,3