-- ============================================================
-- Silver Layer: Bike Share Tables (Cleaned & Transformed)
-- ============================================================

IF OBJECT_ID('silver.bike_share_yr_0', 'U') IS NOT NULL
    DROP TABLE silver.bike_share_yr_0;
GO
CREATE TABLE silver.bike_share_yr_0 (
    ride_date            DATE,           -- was: dteday (NVARCHAR ? DATE)
    season          NVARCHAR(50),   -- was: INT ? 'Spring','Summer','Fall','Winter'
    year            INT,            -- was: yr 0/1 ? 2021/2022
    month           INT,            -- was: mnth
    hour            INT,            -- was: hr
    is_holiday      INT,            -- was: holiday
    day_of_week     NVARCHAR(50),   -- was: weekday INT ? 'Monday'...'Sunday'
    is_working_day  INT,            -- was: workingday
    weather         NVARCHAR(50),   -- was: weathersit INT ? readable string
    temperature     FLOAT,          -- was: temp
    felt_temperature FLOAT,         -- was: atemp
    humidity        FLOAT,          -- was: hum
    wind_speed      FLOAT,          -- was: windspeed
    rider_type      NVARCHAR(50),   -- unchanged
    riders          INT             -- unchanged
);
GO

IF OBJECT_ID('silver.bike_share_yr_1', 'U') IS NOT NULL
    DROP TABLE silver.bike_share_yr_1;
GO
CREATE TABLE silver.bike_share_yr_1 (
    date            DATE,
    season          NVARCHAR(50),
    year            INT,
    month           INT,
    hour            INT,
    is_holiday      INT,
    day_of_week     NVARCHAR(50),
    is_working_day  INT,
    weather         NVARCHAR(50),
    temperature     FLOAT,
    felt_temperature FLOAT,
    humidity        FLOAT,
    wind_speed      FLOAT,
    rider_type      NVARCHAR(50),
    riders          INT
);
GO

-- cost_table: no transformations needed, just clean copy
IF OBJECT_ID('silver.cost_table', 'U') IS NOT NULL
    DROP TABLE silver.cost_table;
GO
CREATE TABLE silver.cost_table (
    year      INT,
    price   DECIMAL(10, 2),   -- promoted from FLOAT for monetary precision
    COGS    DECIMAL(10, 2)
);
GO