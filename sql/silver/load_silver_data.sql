
CREATE OR ALTER PROCEDURE silver.load_bike_silver AS
BEGIN
    BEGIN TRY
        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';

        PRINT '------------------------------------------------';
        PRINT 'Loading Bike Share Tables';
        PRINT '------------------------------------------------';

        -- -----------------------------------------------
        -- Table 1: bike_share_yr_0
        -- -----------------------------------------------
        PRINT '>> Truncating Table: silver.bike_share_yr_0';
        TRUNCATE TABLE silver.bike_share_yr_0;

        PRINT '>> Inserting Data Into: silver.bike_share_yr_0';
        INSERT INTO silver.bike_share_yr_0 (
            date, season, year, month, hour,
            is_holiday, day_of_week, is_working_day,
            weather, temperature, felt_temperature,
            humidity, wind_speed, rider_type, riders
        )
        SELECT
            -- Date: cast raw string to DATE
            CONVERT(DATE, dteday, 103),

            -- Season: replace codes with names
            CASE season
                WHEN 1 THEN 'Winter'
                WHEN 2 THEN 'Spring'
                WHEN 3 THEN 'Summer'
                WHEN 4 THEN 'Fall'
            END,

            -- Year: 0 ? 2021, 1 ? 2022
            CASE yr
                WHEN 0 THEN 2021
                WHEN 1 THEN 2022
            END ,

            mnth,
            hr,
            holiday,

            -- Weekday: replace codes with day names
            CASE weekday
                WHEN 0 THEN 'Sunday'
                WHEN 1 THEN 'Monday'
                WHEN 2 THEN 'Tuesday'
                WHEN 3 THEN 'Wednesday'
                WHEN 4 THEN 'Thursday'
                WHEN 5 THEN 'Friday'
                WHEN 6 THEN 'Saturday'
            END,

            workingday,

            -- Weather: replace codes with descriptions
            CASE weathersit
                WHEN 1 THEN 'Clear'
                WHEN 2 THEN 'Mist'
                WHEN 3 THEN 'Light Snow or Rain'
                WHEN 4 THEN 'Heavy Rain or Storm'
            END,

            temp,
            atemp,
            hum,
            windspeed,
            rider_type,
            riders

        FROM bronze.bike_share_yr_0;
        PRINT '>> Done: silver.bike_share_yr_0';

        -- -----------------------------------------------
        -- Table 2: bike_share_yr_1
        -- -----------------------------------------------
        PRINT '>> Truncating Table: silver.bike_share_yr_1';
        TRUNCATE TABLE silver.bike_share_yr_1;

        PRINT '>> Inserting Data Into: silver.bike_share_yr_1';
        INSERT INTO silver.bike_share_yr_1 (
            date, season, year, month, hour,
            is_holiday, day_of_week, is_working_day,
            weather, temperature, felt_temperature,
            humidity, wind_speed, rider_type, riders
        )
        SELECT
            CONVERT(DATE, dteday, 103),

            CASE season
                WHEN 1 THEN 'Winter'
                WHEN 2 THEN 'Spring'
                WHEN 3 THEN 'Summer'
                WHEN 4 THEN 'Fall'
            END,

            CASE yr
                WHEN 0 THEN 2021
                WHEN 1 THEN 2022
            END,

            mnth,
            hr,
            holiday,

            CASE weekday
                WHEN 0 THEN 'Sunday'
                WHEN 1 THEN 'Monday'
                WHEN 2 THEN 'Tuesday'
                WHEN 3 THEN 'Wednesday'
                WHEN 4 THEN 'Thursday'
                WHEN 5 THEN 'Friday'
                WHEN 6 THEN 'Saturday'
            END,

            workingday,

            CASE weathersit
                WHEN 1 THEN 'Clear'
                WHEN 2 THEN 'Mist'
                WHEN 3 THEN 'Light Snow or Rain'
                WHEN 4 THEN 'Heavy Rain or Storm'
            END,

            temp,
            atemp,
            hum,
            windspeed,
            rider_type,
            riders

        FROM bronze.bike_share_yr_1;
        PRINT '>> Done: silver.bike_share_yr_1';

        -- -----------------------------------------------
        -- Table 3: cost_table (straight copy, no transforms)
        -- -----------------------------------------------
        PRINT '>> Truncating Table: silver.cost_table';
        TRUNCATE TABLE silver.cost_table;

        PRINT '>> Inserting Data Into: silver.cost_table';
        INSERT INTO silver.cost_table (year, price, COGS)
        SELECT 
        CASE yr
                WHEN 0 THEN 2021
                WHEN 1 THEN 2022
            END,
        price, COGS
        FROM bronze.cost_table;
        PRINT '>> Done: silver.cost_table';

        PRINT '------------------------------------------------';
        PRINT 'Silver Layer Loaded Successfully';
        PRINT '------------------------------------------------';

    END TRY
    BEGIN CATCH
        PRINT '================================================';
        PRINT 'ERROR OCCURRED WHILE LOADING SILVER LAYER';
        PRINT '------------------------------------------------';
        PRINT 'Error Message : ' + ERROR_MESSAGE();
        PRINT 'Error Number  : ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error Line    : ' + CAST(ERROR_LINE()   AS NVARCHAR(10));
        PRINT '================================================';
    END CATCH
END
GO