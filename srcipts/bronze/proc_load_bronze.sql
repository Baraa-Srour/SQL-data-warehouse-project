/*
========================================================
Stored Procedure: Load Bronze Layer (Soure -> Bronze)
========================================================
Script Purpose:
	This stored proucedure loads data into the 'bronze' schema from external CSV files.
	It preforms the following actions:
	- Truncate the bronze tables before loading data.
	- Uses the 'BULK INSERT' command to load data csv Files to bronze tables.
	  
Parameters:
		None.
	 This stored procedure dose not accept any Parameters or return any values.
	 
Usage Example:
	EXEC bronze.load_bronze

========================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	BEGIN TRY
		DECLARE @start_time DATETIME , @end_time DATETIME
		
		SET @start_time = GETDATE();
		
		PRINT'=========================================';
		PRINT 'Loading Bronze Layer';
		PRINT'=========================================';
	
		PRINT'-----------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT'-----------------------------------------';
		PRINT'                                         ';
		--#1 bronze.crm_cust_info

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.crm_cust_info' ;
		TRUNCATE TABLE bronze.crm_cust_info; 

		PRINT '>> Inserting Data Into: bronze.crm_cust_info' ;
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\DATA SORCES\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds' ;
		PRINT'                                         ';
		PRINT '>>--------------------------------------' ;
		PRINT'                                         ';

		--#2 bronze.crm_prd_info

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.crm_prd_info' ;
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\DATA SORCES\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds' ;
	PRINT'                                         ';
	PRINT '>>--------------------------------------' ;
	PRINT'                                         ';

		--#3 bronze.crm_sales_details

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.crm_sales_details' ;
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\DATA SORCES\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds' ;
		PRINT'                                         ';
		PRINT '>>--------------------------------------' ;

		PRINT'                                         ';
		PRINT'=========================================';
		PRINT 'Loading ERP Tables';
		PRINT'=========================================';
		PRINT'                                         ';
		--#4 bronze.erp_cust_AZ12
		
		SET @start_time = GETDATE();

		
		PRINT '>> Truncating Table: bronze.erp_cust_AZ12'; 
		TRUNCATE TABLE bronze.erp_cust_AZ12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_AZ12';
		BULK INSERT bronze.erp_cust_AZ12
		FROM 'D:\DATA SORCES\datasets\source_erp\cust_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds' ;
		PRINT'                                         ';
		PRINT '>>--------------------------------------' ;
		PRINT'                                         ';

		--#5 bronze.erp_loc_A101

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.erp_loc_A101' ;
		TRUNCATE TABLE bronze.erp_loc_A101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_A101';
		BULK INSERT bronze.erp_loc_A101
		FROM 'D:\DATA SORCES\datasets\source_erp\loc_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds' ;
		PRINT'                                         ';
		PRINT '>>--------------------------------------' ;
		PRINT'                                         ';

		--#6 bronze.erp_px_cat_g1v2

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table:bronze.erp_px_cat_g1v2' ;
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\DATA SORCES\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds' ;
		PRINT'                                         ';
		PRINT '>>--------------------------------------' ;
		PRINT'                                         ';
		
		SET @end_time = GETDATE();
		
		PRINT'                                         ';
		PRINT '>>--------------------------------------' ;
		PRINT'                                         ';
		PRINT'Loding Bronze Layer is Cometed';
		PRINT'                                         ';
		PRINT '>>>>> Total Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds' ;
		PRINT'                                         ';
		PRINT '>>--------------------------------------' ;
		PRINT'                                         ';
	END TRY
	BEGIN CATCH 
		PRINT'-----------------------------------------'
		PRINT '========================================'
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message'+ ERROR_MESSAGE();
		PRINT 'Error Message'+ CAST (ERROR_MESSAGE() AS VARCHAR);
		PRINT 'Error Message'+ CAST (ERROR_STATE() AS VARCHAR);
		PRINT '========================================'
	END CATCH
END  

EXEC bronze.load_bronze ;
