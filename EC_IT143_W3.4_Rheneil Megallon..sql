--/*****************************************************************************************************************
--NAME:    3.4 Adventure Works—Create Answers
--PURPOSE: Answer 8 questions Marginal complexity, Moderate complexity, Increased complexity
--Metadata questions using AdventureWorks sample Database

--MODIFICATION LOG:
--Ver      Date        Author        Description
-------   ----------   -----------   -------------------------------------------------------------------------------
--1.0     07/24/2026   Rheneil Eushua Megallon       1. Built this script for 3.4 Adventure Works IT143


--RUNTIME: 
--5-20 seconds depending on environment

--NOTES: 
--All questions, asnwers and queries are self-contained, by other authors (sighted) and original author included
 
--******************************************************************************************************************/

---Q1 MArginal question: author: Rheneil Eushua Megallon
--How many active employees do we have with the job title Design Engineer?
--SQLscript: 
SELECT COUNT(*) AS ActiveDesignEngineers
FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer'
  AND CurrentFlag = 1;

---Q2 Marginal question: author: Friday Ani
--Which product categories have the lowest average list price?
--SQLscript: 
SELECT pc.Name AS CategoryName, AVG(p.ListPrice) AS AvgListPrice
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory ps ON pc.ProductCategoryID = ps.ProductCategoryID
JOIN Production.Product p ON ps.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY pc.Name
ORDER BY AvgListPrice ASC;

---Q3 Moderate question: author: Mary Andrew Arikpo
--I want to know how our sales team is doing. Which five salespeople sold the most, and what area does each one cover?
--SQLscript: 
SELECT TOP 5 
    p.FirstName, 
    p.LastName, 
    st.Name AS TerritoryName,
    SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesPerson sp
JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
LEFT JOIN Sales.SalesTerritory st ON sp.TerritoryID = st.TerritoryID
GROUP BY p.FirstName, p.LastName, st.Name
ORDER BY TotalSales DESC;

---Q4 Moderate question: author: Mary Andrew Arikpo
--I am looking at our suppliers. Which suppliers give us the most products, and how long does each one take to deliver?
--SQLscript: 
SELECT 
    v.Name AS SupplierName, 
    COUNT(pv.ProductID) AS ProductCount,
    AVG(CAST(pv.AverageLeadTime AS FLOAT)) AS AvgLeadTimeDays
FROM Purchasing.Vendor v
JOIN Purchasing.ProductVendor pv ON v.BusinessEntityID = pv.BusinessEntityID
GROUP BY v.Name
ORDER BY ProductCount DESC;

---Q5 Increased complexity question: author: Venicius Del Frari
--The sales manager wants to review bicycle sales. Which five bicycle products generated the highest sales revenue? Show the product name, total quantity sold, and total revenue.
--SQLscript:
SELECT TOP 5
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold,
    SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Bikes'
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

---Q6 Increased complexity question: author: Venicius Del Frari
--Management wants to review sales by month for 2013. Which month had the highest sales total? Show the month, number of orders, and total sales amount.
--SQLscript:
SELECT TOP 1
    MONTH(OrderDate) AS OrderMonth,
    COUNT(SalesOrderID) AS NumberOfOrders,
    SUM(TotalDue) AS TotalSalesAmount
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2013
GROUP BY MONTH(OrderDate)
ORDER BY TotalSalesAmount DESC;

---Q7 Metadata questions: author: Renz Lendyl Palpal-latoc
--Can you identify every column across AdventureWorks that allows NULL values but is still part of a primary key usage list?
--SQLscript:
SELECT 
    tc.TABLE_SCHEMA,
    tc.TABLE_NAME,
    kcu.COLUMN_NAME,
    c.IS_NULLABLE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu 
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
    AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA
JOIN INFORMATION_SCHEMA.COLUMNS AS c 
    ON kcu.TABLE_SCHEMA = c.TABLE_SCHEMA
    AND kcu.TABLE_NAME = c.TABLE_NAME
    AND kcu.COLUMN_NAME = c.COLUMN_NAME
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
  AND c.IS_NULLABLE = 'YES';

---Q8 Metadata question: author: Rheneil Eushua Megallon
--For our database inventory task, use INFORMATION_SCHEMA.COLUMNS to find out how many columns across our database currently use the nvarchar data type.
--SQLscript:
SQL
SELECT COUNT(*) AS NvarcharColumnCount
FROM INFORMATION_SCHEMA.COLUMNS
WHERE DATA_TYPE = 'nvarchar';















