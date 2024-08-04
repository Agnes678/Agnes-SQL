DROP DATABASE IF EXISTS `llin_distribution_analysis`;
CREATE DATABASE `llin_distribution_analysis`;
USE `llin_distribution_analysis`;

-- Create a table named 'llin_distribution' to store the data
CREATE TABLE llin_distribution (
id INT PRIMARY KEY,             -- A unique identifier for each distribution
number INT,                     -- The number of llin distributed
location VARCHAR(50),           -- The specific location where the llins were distributed
country VARCHAR(15),            -- The country where the distribution took place
year INT,                       -- The period during which the distribution took place
whom VARCHAR(30),               -- The organization responsible for the distribution
countrycode CHAR(3)             -- The ISO code of the country
);

-- Select all records from the 'llin_distribution_analysis' table
SELECT * FROM llin_distribution_analysis.llin_distribution;

# Descriptive Stats
-- Calculate the total number of LLINs distributed in each country
SELECT
Country, SUM(number) AS total_number            -- Country where distribution took place
FROM llin_distribution
GROUP BY
COUNTRY, countrycode;                          -- Group results by countries

-- Calculate the average number of LLINs distributed per distribution event.
SELECT
whom,                               -- Group the same organization
AVG(number) AS avg_number           -- calculate the average per each organization
FROM llin_distribution
GROUP BY
whom;                               -- The organization

-- Calculate the average number of LLINs distributed per distribution event
SELECT
Country,
AVG(number) AS avg_number 
FROM llin_distribution
GROUP BY
Country;                               -- Group results by countries


# Trends and patterns
-- Calculate the total number of LLINs distributed by each organization
SELECT
whom,                              -- Group the same organization
SUM(number) AS total_number        -- calculate amount distributed by each organization
FROM llin_distribution
GROUP BY
whom;                              -- Group results by organization

-- Calculate the total number of LLINs distributed in each year
SELECT
year,                              
SUM(number) AS total_number        -- Calculate the total amount distributed in each year
FROM llin_distribution
GROUP BY                          
year;                              -- Group results by year


# Volume Insights
-- Find the locations with the highest number of LLINs distributed
SELECT
id, Country, location, (number) AS highest_number         -- highest number of llins distributed 
FROM llin_distribution
ORDER BY Location;

-- Find the locations with the Lowest number of LLINs distributed
SELECT
id, location, (number) AS lowest_number           -- lowest number of llin distributed
FROM llin_distribution
ORDER BY location;

-- Determine significant difference in the number of LLINs distributed by different organizations.
SELECT
whom,  
number,
LAG (number) OVER (PARTITION BY whom) - number AS Difference                                   
FROM llin_distribution;


# Identifying extremes
-- Calculate significant spikes in the number of LLINs distributed in specific locations or periods
SELECT
country, location,
number,  
LAG (number) OVER (PARTITION BY location) - number as Spike
FROM llin_distribution;
   




