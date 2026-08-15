-- =====================================================================
-- SQL SERVER PERFORMANCE ANALYSIS DEMONSTRATION
-- Database: AdventureWorks2022
-- Target Table: Person.Address 
-- Filter Column: City (Unindexed Character Column)
-- =====================================================================

USE [AdventureWorks2022];
GO

-- ---------------------------------------------------------------------
-- STEP 1 & 2: BASELINE QUERY
-- Action: Press Ctrl + M in SSMS to enable "Include Actual Execution Plan"
-- Execute this query (F5)
-- ---------------------------------------------------------------------
SELECT AddressID, AddressLine1, City, StateProvinceID, PostalCode
FROM Person.Address
WHERE City = 'Bothell';
GO

-- ---------------------------------------------------------------------
-- STEP 4 & 5: BASELINE OBSERVATIONS (Check Execution Plan Tab)
--   - Primary Operator: Clustered Index Scan (100% Query Cost)
--   - Estimated Subtree Cost: ~0.024
--   - Green Text: "Missing Index (Impact ~93%): CREATE NONCLUSTERED INDEX..."
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- STEP 6 & 7: CREATE RECOMMENDED INDEX
-- Right-click green recommendation text -> "Missing Index Details..."
-- Replace placeholder name with IX_Address_City and execute
-- ---------------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Address_City
ON [Person].[Address] ([City])
INCLUDE ([AddressLine1], [StateProvinceID], [PostalCode]);
GO

-- ---------------------------------------------------------------------
-- STEP 8: RE-RUN QUERY TO VERIFY PERFORMANCE GAIN
-- Execute with Ctrl + M enabled to verify operator change and cost reduction
-- ---------------------------------------------------------------------
SELECT AddressID, AddressLine1, City, StateProvinceID, PostalCode
FROM Person.Address
WHERE City = 'Bothell';
GO

-- ---------------------------------------------------------------------
-- CLEANUP SCRIPT (Optional: Run after recording to reset database state)
-- ---------------------------------------------------------------------
-- DROP INDEX IX_Address_City ON Person.Address;
-- GO
