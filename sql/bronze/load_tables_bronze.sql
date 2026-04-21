CREATE OR ALTER PROCEDURE bronze.load_bike_bronze AS
BEGIN
    BEGIN TRY
        PRINT '================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '================================================';

        PRINT '------------------------------------------------';
        PRINT 'Loading Bike Share Tables';
        PRINT '------------------------------------------------';

        -- -----------------------------------------------
        -- Table 1: bike_share_yr_0
        -- -----------------------------------------------
        PRINT '>> Truncating Table: bronze.bike_share_yr_0';
        TRUNCATE TABLE bronze.bike_share_yr_0;
        PRINT '>> Inserting Data Into: bronze.bike_share_yr_0';
        BULK INSERT bronze.bike_share_yr_0
        FROM 'C:\Users\Microsoft\Downloads\YT_bike_share-main\YT_bike_share-main\bike_share_yr_0.csv'
        WITH (
            FIRSTROW = 2,           -- Skip header row
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        PRINT '>> Done: bronze.bike_share_yr_0';

        -- -----------------------------------------------
        -- Table 2: bike_share_yr_1
        -- -----------------------------------------------
        PRINT '>> Truncating Table: bronze.bike_share_yr_1';
        TRUNCATE TABLE bronze.bike_share_yr_1;
        PRINT '>> Inserting Data Into: bronze.bike_share_yr_1';
        BULK INSERT bronze.bike_share_yr_1
        FROM 'C:\Users\Microsoft\Downloads\YT_bike_share-main\YT_bike_share-main\bike_share_yr_1.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        PRINT '>> Done: bronze.bike_share_yr_1';

        -- -----------------------------------------------
        -- Table 3: cost_table
        -- -----------------------------------------------
        PRINT '>> Truncating Table: bronze.cost_table';
        TRUNCATE TABLE bronze.cost_table;
        PRINT '>> Inserting Data Into: bronze.cost_table';
        BULK INSERT bronze.cost_table
        FROM 'C:\Users\Microsoft\Downloads\YT_bike_share-main\YT_bike_share-main\cost_table.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        PRINT '>> Done: bronze.cost_table';

        PRINT '------------------------------------------------';
        PRINT 'Bronze Layer Loaded Successfully';
        PRINT '------------------------------------------------';

    END TRY
    BEGIN CATCH
        PRINT '================================================';
        PRINT 'ERROR OCCURRED WHILE LOADING BRONZE LAYER';
        PRINT '------------------------------------------------';
        PRINT 'Error Message : ' + ERROR_MESSAGE();
        PRINT 'Error Number  : ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error Line    : ' + CAST(ERROR_LINE()   AS NVARCHAR(10));
        PRINT '================================================';
    END CATCH
END
GO