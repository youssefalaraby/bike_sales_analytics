-- ============================================================
-- Bronze Layer: Bike Share Tables
-- ============================================================

-- 1. Hourly ride data - Year 0 (2021)
IF OBJECT_ID('bronze.bike_share_yr_0', 'U') IS NOT NULL
    DROP TABLE bronze.bike_share_yr_0;
GO
CREATE TABLE bronze.bike_share_yr_0 (
    dteday      NVARCHAR(50),   -- raw date string, will be cast in silver
    season      INT,            -- 1=Spring, 2=Summer, 3=Fall, 4=Winter
    yr          INT,            -- 0 = 2021
    mnth        INT,            -- 1-12
    hr          INT,            -- 0-23
    holiday     INT,            -- 1 = holiday
    weekday     INT,            -- 0=Sun ... 6=Sat
    workingday  INT,            -- 1 = working day
    weathersit  INT,            -- 1=Clear, 2=Mist, 3=Light Snow/Rain, 4=Heavy Rain
    temp        FLOAT,          -- normalized temperature
    atemp       FLOAT,          -- normalized feeling temperature
    hum         FLOAT,          -- normalized humidity
    windspeed   FLOAT,          -- normalized wind speed
    rider_type  NVARCHAR(50),   -- 'casual' or 'registered'
    riders      INT             -- number of rides in that hour
);
GO

-- 2. Hourly ride data - Year 1 (2022)
IF OBJECT_ID('bronze.bike_share_yr_1', 'U') IS NOT NULL
    DROP TABLE bronze.bike_share_yr_1;
GO
CREATE TABLE bronze.bike_share_yr_1 (
    dteday      NVARCHAR(50),
    season      INT,
    yr          INT,            -- 1 = 2022
    mnth        INT,
    hr          INT,
    holiday     INT,
    weekday     INT,
    workingday  INT,
    weathersit  INT,
    temp        FLOAT,
    atemp       FLOAT,
    hum         FLOAT,
    windspeed   FLOAT,
    rider_type  NVARCHAR(50),
    riders      INT
);
GO

-- 3. Pricing and cost per year
IF OBJECT_ID('bronze.cost_table', 'U') IS NOT NULL
    DROP TABLE bronze.cost_table;
GO
CREATE TABLE bronze.cost_table (
    yr      INT,            -- 0 = 2021, 1 = 2022
    price   FLOAT,          -- revenue per ride (3.99 / 4.99)
    COGS    FLOAT           -- cost per ride (1.24 / 1.56)
);
GO