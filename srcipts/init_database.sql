/*
=========================================
Create Database and Schemas 
=========================================
Scripts Purpose:
	This scripts Creates a new database named 'DataWarehouse' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the databse: 'bronze', 'silver', and 'gold'.

WARNING
	Running this script will drop the entire 'DataWarehouse' database if it exists.
	All data in the databse will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script.
*/

--Create Database 'DataWarehouse'

USE master;
GO

--Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDATE;
	DROP DATABASE DataWarehouse ;
END;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--Create the 'DataWarehouse' database
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
