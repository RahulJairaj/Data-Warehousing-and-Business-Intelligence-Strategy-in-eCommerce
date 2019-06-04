USE ist722_fudge_c5_dw
go


--------------****************------------------
/*
-- Create the schema if it does not exist
IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'northwind')) 
BEGIN
    EXEC ('CREATE SCHEMA [fudge_group5] AUTHORIZATION [dbo]')
	PRINT 'CREATE SCHEMA [fudge_group5] AUTHORIZATION [dbo]'
END
go */
-- delete all the fact tables in the schema
DECLARE @fact_table_name varchar(100)
DECLARE cursor_loop CURSOR FAST_FORWARD READ_ONLY FOR 
	select TABLE_NAME from INFORMATION_SCHEMA.TABLES 
		where TABLE_SCHEMA='fudge_group5' and TABLE_NAME like 'Fact%'
OPEN cursor_loop
FETCH NEXT FROM cursor_loop  INTO @fact_table_name
WHILE @@FETCH_STATUS= 0
BEGIN
	EXEC ('DROP TABLE [fudge_group5].[' + @fact_table_name + ']')
	PRINT 'DROP TABLE [fudge_group5].[' + @fact_table_name + ']'
	FETCH NEXT FROM cursor_loop  INTO @fact_table_name
END
CLOSE cursor_loop
DEALLOCATE cursor_loop
go
-- delete all the other tables in the schema
DECLARE @table_name varchar(100)
DECLARE cursor_loop CURSOR FAST_FORWARD READ_ONLY FOR 
	select TABLE_NAME from INFORMATION_SCHEMA.TABLES 
		where TABLE_SCHEMA='fudge_group5' and TABLE_TYPE = 'BASE TABLE'
OPEN cursor_loop
FETCH NEXT FROM cursor_loop INTO @table_name
WHILE @@FETCH_STATUS= 0
BEGIN
	EXEC ('DROP TABLE [fudge_group5].[' + @table_name + ']')
	PRINT 'DROP TABLE [fudge_group5].[' + @table_name + ']'
	FETCH NEXT FROM cursor_loop  INTO @table_name
END
CLOSE cursor_loop
DEALLOCATE cursor_loop
go

--------------********---------


/****** Object:  Database ist722_tmundodu_dw    Script Date: 4/2/2018 5:42:33 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_tmundodu_dw
GO
CREATE DATABASE ist722_tmundodu_dw
GO
ALTER DATABASE ist722_tmundodu_dw
SET RECOVERY SIMPLE
GO

USE ist722_tmundodu_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;
*/


/* Drop table fudge_group5.DimCustomer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge_group5.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge_group5.DimCustomer 
;

/* Create table fudge_group5.DimCustomer */
CREATE TABLE fudge_group5.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerLineage]  nvarchar(10)   NOT NULL
,  [CustomerID]  int   NOT NULL
,  [CustomerEmail]  nvarchar(200)  DEFAULT 'N/A' NOT NULL
,  [CustomerFirstName]  nvarchar(50)   NOT NULL
,  [CustomerLastName]  nvarchar(50)   NOT NULL
,  [CustomerName]  nvarchar(102)   NOT NULL
,  [CustomerCity]  nvarchar(50)   NOT NULL
,  [CustomerState]  nvarchar(2)   NOT NULL
,  [CustomerZip]  nvarchar(20)   NOT NULL
,  [AccountID]  int   NOT NULL
,  [AccountOpenedOn]  datetime   NOT NULL
,  [RowIsCurrent]  bit   NOT NULL
,  [RowStartDate]  datetime   DEFAULT '01/01/1900' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200) DEFAULT 'NA' NOT NULL
, CONSTRAINT [PK_fudge_group5.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimCustomer', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudge_group5', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimCustomer
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Customer Dimension', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimCustomer
;

SET IDENTITY_INSERT fudge_group5.DimCustomer ON
;
INSERT INTO fudge_group5.DimCustomer (CustomerKey, CustomerLineage, CustomerID, CustomerEmail, CustomerFirstName, CustomerLastName, CustomerName, CustomerCity, CustomerState, CustomerZip, AccountID, AccountOpenedOn, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, 'None', -1, 'Unk Email', 'Unk Name', 'Unk Name', 'Unk Name', 'Unk City', 'ZZ', 'Unk Zip', -1, '12/31/9999', 'True', '12/31/1899', '12/31/9999', 'NA')
;
SET IDENTITY_INSERT fudge_group5.DimCustomer OFF
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerLineage', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLineage'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerID', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerEmail', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerFirstName', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CUstomerLastName', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerName', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerCity', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerState', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerZip', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'AccountID', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'AccountOpenedOn', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountOpenedOn'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer ID', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLineage'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer ID', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Customer Email', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'First Name of Customer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Last Name of Customer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full Name of Customer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'City of Customer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'State of Customer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Zip of Customer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'FudgeFlix ID of Customer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date on which FudgeFlix Account was opened', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountOpenedOn'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLineage'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountOpenedOn'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLineage'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountOpenedOn'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLineage'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountOpenedOn'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLineage'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountOpenedOn'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_id', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLineage'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_id', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_email', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_firstname', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_lastname', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_firstname+'' ''+customer_lastname', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_city', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_state', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_zip', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_zip', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_zip', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountOpenedOn'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLineage'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(100)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerEmail'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(50)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerFirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(50)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerLastName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(50)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerCity'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'char(2)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerState'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(20)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'CustomerZip'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(20)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(20)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimCustomer', @level2type=N'COLUMN', @level2name=N'AccountOpenedOn'; 
;


select * from fudge_group5.DimCustomer;




-------------------------------------*************-----------------------------

/* Drop table fudge_group5.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge_group5.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge_group5.DimDate 
;

/* Create table fudge_group5.DimDate */
CREATE TABLE fudge_group5.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  datetime   NULL
,  [FullDateUSA]  nvarchar(10)   NOT NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nvarchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  int   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nvarchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [QuarterName]  nvarchar(10)   NOT NULL
,  [Year]  int   NOT NULL
,  [IsWeekday]  varchar(1)  DEFAULT 'N' NOT NULL
, CONSTRAINT [PK_fudge_group5.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudge_group5', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Date dimension contains one row for every day, may also be rows for "hasn''t happened yet."', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimDate
;

INSERT INTO fudge_group5.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)
VALUES (-1, '', '01/01/1900', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, 'N')
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FullDateUSA', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayName', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfYear', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WeekOfYear', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthOfYear', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'QuarterName', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsWeekday', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full date as a SQL date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'String expression of the full date, eg MM/DD/YYYY', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day of week; Sunday = 1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Day name of week, eg Monday', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the month', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the year', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Week of year, 1..53', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month name, eg January', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month of year, 1..12', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar quarter, 1..4', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quarter name eg. First', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar year, eg 2010', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is today a weekday', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20041123', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'38314', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'23-Nov-2004', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..7', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Sunday', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..31', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..365', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..52 or 53', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, …, 12', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3, 4', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2004', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y,N', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'In the form: yyyymmdd', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsWeekday'; 
;


SELECT * FROM IST722_tmundodu_dw.fudge_group5.DimDate;


------------------------*****************--------------------

--------------------- ***************** --------------------

/****** Object:  Database ist722_tmundodu_dw    Script Date: 4/6/2018 6:27:06 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_tmundodu_dw
GO
CREATE DATABASE ist722_tmundodu_dw
GO
ALTER DATABASE ist722_tmundodu_dw
SET RECOVERY SIMPLE
GO

USE ist722_tmundodu_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;
*/




/* Drop table fudge_group5.DimPlan */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge_group5.DimPlan') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge_group5.DimPlan 
;

/* Create table fudge_group5.DimPlan */
CREATE TABLE fudge_group5.DimPlan (
   [PlanKey]  int IDENTITY  NOT NULL
,  [PlanID]  int   NOT NULL
,  [PlanName]  varchar(50)   NOT NULL
,  [PlanPrice]  money   NOT NULL
,  [PlanCurrent]  nvarchar(1)  NOT NULL
,  [RowIsCurrent]  bit   NOT NULL
,  [RowStartDate]  datetime   DEFAULT '01/01/1900' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200) DEFAULT 'NA' NOT NULL
, CONSTRAINT [PK_fudge_group5.DimPlan] PRIMARY KEY CLUSTERED 
( [PlanKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimPlan
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimPlan', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimPlan
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudge_group5', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimPlan
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Plan Dimension', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimPlan
;

SET IDENTITY_INSERT fudge_group5.DimPlan ON
;
INSERT INTO fudge_group5.DimPlan (PlanKey, PlanID, PlanName, PlanPrice, PlanCurrent, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unk Name', 0, 'N', 'True', '12/31/1899', '12/31/9999', 'NA')
;
SET IDENTITY_INSERT fudge_group5.DimPlan OFF
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PlanKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PlanID', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PlanName', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PlanPrice', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanPrice'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PlanCurrent', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system ', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of plan', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Price of plan', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanPrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Current status of plan', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE, FALSE', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanPrice'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanPrice'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_plans', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_plans', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_plans', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_plans', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'plan_id', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'plan_name', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'plan_price', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'plan_current', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimPlan', @level2type=N'COLUMN', @level2name=N'PlanCurrent'; 
;



SELECT * FROM fudge_group5.DimPlan;

------------------ ******** ---------------


/****** Object:  Database ist722_tmundodu_dw    Script Date: 3/30/2018 8:25:52 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_tmundodu_dw
GO
CREATE DATABASE ist722_tmundodu_dw
GO
ALTER DATABASE ist722_tmundodu_dw
SET RECOVERY SIMPLE
GO

USE ist722_tmundodu_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;
*/




/* Drop table fudge_group5.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge_group5.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge_group5.DimProduct 
;

/* Create table fudge_group5.DimProduct */
CREATE TABLE fudge_group5.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  int   NOT NULL
,  [ProductName]  varchar(50)   NOT NULL
,  [ProductDepartment]  varchar(50)   NOT NULL
,  [ProductInception]  datetime   NOT NULL
,  [ProductRetailPrice]  money   NOT NULL
,  [ProductWholesalePrice]  money   NOT NULL
,  [ProductStatus]  nvarchar(1) NOT NULL
,  [ProductDescription]  varchar(1000)   NOT NULL
,  [RowIsCurrent]  bit   NOT NULL
,  [RowStartDate]  datetime   DEFAULT '01/01/1900' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200) DEFAULT 'NA' NOT NULL
, CONSTRAINT [PK_fudge_group5.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimProduct', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudge_group5', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Product Dimension', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimProduct
;

SET IDENTITY_INSERT fudge_group5.DimProduct ON
;
INSERT INTO fudge_group5.DimProduct (ProductKey, ProductID, ProductName, ProductDepartment, ProductInception, ProductRetailPrice, ProductWholesalePrice, ProductStatus, ProductDescription, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unk prod', 'Unk dept', '12/31/1899', -1, -1, 'N', 'Unk Description', 'True', '12/31/1899', '12/31/9999', 'NA')
;
SET IDENTITY_INSERT fudge_group5.DimProduct OFF
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductID', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductName', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductDepartment', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductInception', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductRetailPrice', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductWholesalePrice', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductWholesalePrice'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductStatus', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductStatus'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductDescription', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDescription'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ID of the Product', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the product', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Department to which the product belongs', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Product add date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Retail price of poduct', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Wholesale price of poduct', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductWholesalePrice'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Product is active or not', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductStatus'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Product description', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDescription'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductWholesalePrice'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductStatus'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDescription'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductWholesalePrice'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductStatus'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDescription'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductWholesalePrice'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductStatus'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDescription'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductWholesalePrice'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductStatus'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_products', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDescription'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_id', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_name', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_department', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_add_date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_retail_price', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_wholesale_price', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductWholesalePrice'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_is_active', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductStatus'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_description', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDescription'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(50)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(20)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDepartment'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'datetime', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductInception'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductRetailPrice'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductWholesalePrice'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductStatus'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(1000)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimProduct', @level2type=N'COLUMN', @level2name=N'ProductDescription'; 
;


SELECT * FROM fudge_group5.DimProduct;

------------- ********** ---------------

/****** Object:  Database ist722_tmundodu_dw    Script Date: 3/30/2018 8:27:09 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_tmundodu_dw
GO
CREATE DATABASE ist722_tmundodu_dw
GO
ALTER DATABASE ist722_tmundodu_dw
SET RECOVERY SIMPLE
GO

USE ist722_tmundodu_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;
*/




/* Drop table fudge_group5.DimTitle */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge_group5.DimTitle') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge_group5.DimTitle 
;

/* Create table fudge_group5.DimTitle */
CREATE TABLE fudge_group5.DimTitle (
   [TitleKey]  int IDENTITY  NOT NULL
,  [TitleID]  varchar(20)   NOT NULL
,  [TitleName]  varchar(200)   NOT NULL
,  [TitleType]  varchar(20)   NOT NULL
,  [TitleGenre]  varchar(200)   NOT NULL
,  [TitleAvgRating]  decimal(18,2)   NOT NULL
,  [TitleReleaseYear]  int   NOT NULL
,  [TitleRuntime]  int   NOT NULL
,  [TitleRating]  varchar(20)   NOT NULL
,  [TitleBlurayAvailable]  nvarchar(1)   NOT NULL
,  [TitleDvdAvailable]  nvarchar(1)   NOT NULL
,  [TitleInstantAvailable]  nvarchar(1)   NOT NULL
,  [TitleDateModified]  datetime   NOT NULL
,  [RowIsCurrent]  bit   NOT NULL
,  [RowStartDate]  datetime   DEFAULT '01/01/1900' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200) DEFAULT 'NA' NOT NULL
, CONSTRAINT [PK_fudge_group5.DimTitle] PRIMARY KEY CLUSTERED 
( [TitleKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimTitle
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimTitle', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimTitle
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudge_group5', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimTitle
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Title Dimension', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=DimTitle
;

SET IDENTITY_INSERT fudge_group5.DimTitle ON
;
INSERT INTO fudge_group5.DimTitle (TitleKey, TitleID, TitleName, TitleType, TitleGenre, TitleAvgRating, TitleReleaseYear, TitleRuntime, TitleRating, TitleBlurayAvailable, TitleDvdAvailable, TitleInstantAvailable, TitleDateModified, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '-1', 'Unk Name', 'Unk Type', 'Unk Genre', 0, 1970, 1, 'None','N', 'N', 'N', '12/31/1899', 'True', '12/31/1899', '12/31/9999', 'NA')
;
SET IDENTITY_INSERT fudge_group5.DimTitle OFF
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleID', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleName', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleType', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleType'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleGenre', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleGenre'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleAvgRating', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleAvgRating'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleReleaseYear', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleReleaseYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleRuntime', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRuntime'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleRating', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRating'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleBlurayAvailable', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleBlurayAvailable'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleDvdAvailable', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDvdAvailable'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleInstantAvailable', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleInstantAvailable'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleDateModified', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Title ID', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Title Name', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Type of title', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleType'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Average rating of title', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleAvgRating'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The release year of title', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleReleaseYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The runtime of title by seconds', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRuntime'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The rating of title', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRating'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'If Bluray of title available', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleBlurayAvailable'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'If Dvd of title available', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDvdAvailable'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'If  title available instantly', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleInstantAvailable'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The modified date of title', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleID'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE,FALSE', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleID'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleType'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleGenre'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleAvgRating'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleReleaseYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRuntime'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRating'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleBlurayAvailable'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDvdAvailable'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleInstantAvailable'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD Type 2 Metadata', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleID'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleType'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleGenre'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleAvgRating'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleReleaseYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRuntime'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRating'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleBlurayAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDvdAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleInstantAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleID'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleType'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleGenre'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleAvgRating'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleReleaseYear'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRuntime'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRating'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleBlurayAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDvdAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleInstantAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleID'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleType'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_genres', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleGenre'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleAvgRating'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleReleaseYear'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRuntime'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRating'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleBlurayAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDvdAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleInstantAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_id', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleID'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_name', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_type', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleType'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'genre_name', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleGenre'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_avg_rating', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleAvgRating'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_release_year', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleReleaseYear'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_runtime', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRuntime'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_rating', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRating'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_bluray_available', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleBlurayAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_dvd_available', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDvdAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_instant_available', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleInstantAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_date_modified', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleID'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleType'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleGenre'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleAvgRating'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleReleaseYear'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRuntime'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleRating'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleBlurayAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDvdAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleInstantAvailable'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'datetime', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'DimTitle', @level2type=N'COLUMN', @level2name=N'TitleDateModified'; 
;

SELECT * FROM fudge_group5.DimTitle;

----------------- **************** ---------------

---- FACT ROLAP --------

---------------------- *********** ----------
USE ist722_fudge_c5_dw
go

/****** Object:  Database ist722_tmundodu_dw    Script Date: 3/30/2018 9:01:46 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_tmundodu_dw
GO
CREATE DATABASE ist722_tmundodu_dw
GO
ALTER DATABASE ist722_tmundodu_dw
SET RECOVERY SIMPLE
GO

USE ist722_tmundodu_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;
*/




/* Drop table fudge_group5.FactCustReview */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge_group5.FactCustReview') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge_group5.FactCustReview 
;

/* Create table fudge_group5.FactCustReview */
CREATE TABLE fudge_group5.FactCustReview (
   [CustomerKey]  int   NOT NULL
,  [ProductKey]  int   NOT NULL
,  [TitleKey]  int   NOT NULL
,  [Rating]  int  DEFAULT 0 NULL
,  [StarCount]  smallint  DEFAULT 0 NULL
,  [OrderDateKey]  int   NOT NULL
,  [ShippedDateKey]  int   NOT NULL
,  [ReviewDateKey] int NOT NULL
,  [DayDifference]  int  DEFAULT 0 NULL
,  [BoughtOrNot]  smallint  DEFAULT 0 NULL
,  [ShippedOrNot]  smallint  DEFAULT 0 NULL
,  [Fudgemart] smallint DEFAULT 0 NULL
,  [Fudgeflix] smallint DEFAULT 0 NULL  
, CONSTRAINT [PK_fudge_group5.FactCustReview] PRIMARY KEY NONCLUSTERED 
( [CustomerKey], [ProductKey], [TitleKey], [OrderDateKey], [ShippedDateKey], [ReviewDateKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=FactCustReview
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FactCustReview', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=FactCustReview
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudge_group5', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=FactCustReview
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=FactCustReview
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Rating', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'Rating'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'StarCount', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'StarCount'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'OrderDateKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ShippedDateKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayDifference', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'DayDifference'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BoughtOrNot', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'BoughtOrNot'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ShippedOrNot', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedOrNot'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Customer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Product', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Product', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Stars rated for product', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'Rating'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Star Count', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'StarCount'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Ordered Date Key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Shipped Date Key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Lag in days', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'DayDifference'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Whether bought or not', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'BoughtOrNot'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Whether shipped or not', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedOrNot'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'amount', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'Rating'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Counts & rates', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'StarCount'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Counts & rates', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'DayDifference'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Counts & rates', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'BoughtOrNot'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Counts & rates', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedOrNot'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'ist722_tmundodu_dw', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'ist722_tmundodu_dw', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'ist722_tmundodu_dw', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'Rating'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'StarCount'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'ist722_tmundodu_dw', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'ist722_tmundodu_dw', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'DayDifference'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'BoughtOrNot'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedOrNot'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimCustomer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimProduct', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimTitle', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimDate', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimDate', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ProductKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'TitleKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ProductKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'Rating'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'StarCount'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'OrderDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedDateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'DayDifference'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'BoughtOrNot'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'bit', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactCustReview', @level2type=N'COLUMN', @level2name=N'ShippedOrNot'; 
;
ALTER TABLE fudge_group5.FactCustReview ADD CONSTRAINT
   FK_fudge_group5_FactCustReview_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES fudge_group5.DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge_group5.FactCustReview ADD CONSTRAINT
   FK_fudge_group5_FactCustReview_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES fudge_group5.DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge_group5.FactCustReview ADD CONSTRAINT
   FK_fudge_group5_FactCustReview_TitleKey FOREIGN KEY
   (
   TitleKey
   ) REFERENCES fudge_group5.DimTitle
   ( TitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge_group5.FactCustReview ADD CONSTRAINT
   FK_fudge_group5_FactCustReview_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES fudge_group5.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge_group5.FactCustReview ADD CONSTRAINT
   FK_fudge_group5_FactCustReview_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES fudge_group5.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 

 
 select * from fudge_group5.FactCustReview;

 -----------------************
 ------------------*********

 /****** Object:  Database ist722_tmundodu_dw    Script Date: 4/2/2018 2:58:26 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_tmundodu_dw
GO
CREATE DATABASE ist722_tmundodu_dw
GO
ALTER DATABASE ist722_tmundodu_dw
SET RECOVERY SIMPLE
GO

USE ist722_tmundodu_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;
*/

/****** Object:  Database ist722_tmundodu_dw    Script Date: 4/18/2018 5:44:20 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_tmundodu_dw
GO
CREATE DATABASE ist722_tmundodu_dw
GO
ALTER DATABASE ist722_tmundodu_dw
SET RECOVERY SIMPLE
GO



USE ist722_tmundodu_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;

*/

/* Drop table fudge_group5.FactPlanAnalysis */


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge_group5.FactPlanAnalysis') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge_group5.FactPlanAnalysis 
;

/* Create table fudge_group5.FactPlanAnalysis */
CREATE TABLE fudge_group5.FactPlanAnalysis (
   [CustomerKey]  int   NOT NULL
,  [PlanKey]  int   NOT NULL
,  [DateKey]  int   NOT NULL
,  [BilledAmount]  money DEFAULT 0 NULL
, CONSTRAINT [PK_fudge_group5.FactPlanAnalysis] PRIMARY KEY NONCLUSTERED 
( [CustomerKey], [PlanKey], [DateKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=FactPlanAnalysis
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FactPlanAnalysis', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=FactPlanAnalysis
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudge_group5', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=FactPlanAnalysis
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Always create a table description, which becomes a table extended property.', @level0type=N'SCHEMA', @level0name=fudge_group5, @level1type=N'TABLE', @level1name=FactPlanAnalysis
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PlanKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BilledAmount', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'BilledAmount'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Customer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Plan', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Date', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Amount payed for that period', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'BilledAmount'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'amount', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'BilledAmount'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'ist722_tmundodu_dw', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'ist722_tmundodu_dw', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'ist722_tmundodu_dw', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'BilledAmount'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'BilledAmount'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimCustomer', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimPlan', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimDate', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_account_billing', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'BilledAmount'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'CustomerKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'PlanKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'ab_billed_amount', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'BilledAmount'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'CustomerKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'PlanKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'money', @level0type=N'SCHEMA', @level0name=N'fudge_group5', @level1type=N'TABLE', @level1name=N'FactPlanAnalysis', @level2type=N'COLUMN', @level2name=N'BilledAmount'; 
;


ALTER TABLE fudge_group5.FactPlanAnalysis ADD CONSTRAINT
   FK_fudge_group5_FactPlanAnalysis_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES fudge_group5.DimCustomer 
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge_group5.FactPlanAnalysis ADD CONSTRAINT
   FK_fudge_group5_FactPlanAnalysis_PlanKey FOREIGN KEY
   (
   PlanKey
   ) REFERENCES fudge_group5.DimPlan
   ( PlanKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge_group5.FactPlanAnalysis ADD CONSTRAINT
   FK_fudge_group5_FactPlanAnalysis_DateKey FOREIGN KEY
   (
   DateKey
   ) REFERENCES fudge_group5.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 


------------------xxxxxxxxxxxxxxxxxx------------------

---DISPLAY DW Tables

select * from ist722_fudge_c5_dw.fudge_group5.DimTitle;
select * from ist722_fudge_c5_dw.fudge_group5.DimCustomer;
select * from ist722_fudge_c5_dw.fudge_group5.DimDate;
select * from ist722_fudge_c5_dw.fudge_group5.DimPlan;
select * from ist722_fudge_c5_dw.fudge_group5.DimProduct;
select * from ist722_fudge_c5_dw.fudge_group5.FactCustReview;
select * from ist722_fudge_c5_dw.fudge_group5.FactPlanAnalysis;


select ProductName,SUM(ProductRetailPrice) as 'Total'
from ist722_fudge_c5_dw.fudge_group5.DimProduct
group by ProductName
order by Total DESC;
