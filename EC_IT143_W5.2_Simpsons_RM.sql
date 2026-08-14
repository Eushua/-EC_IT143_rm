/*******************************************************************************
NAME:    EC_IT143_W5.2_Simpsons_RM
PURPOSE: Answer four community questions about the Simpsons dataset.
MODIFICATION LOG:
Ver     Date        Author        Description
-----   ----------  ------------  ------------------------------------------------------------------
1.0     08/14/2026  Rheneil         1. Built this script for EC IT143 W5.2 deliverable.

RUNTIME: 
< 1s

NOTES:
Tables used: Planet_Express, Family_Data, FBS_Viza_Costmo
Database: SIMPSONS

*******************************************************************************/

-- Q1 (Author: Rheneil): What is the total credit card expenditure for Homer Simpson categorized by merchant description and job title? I need this breakdown for corporate budget compliance, requiring transaction amounts and descriptions from Planet_Express combined with employee job titles from Family_Data.
-- A1: Join Planet_Express with Family_Data on the card member name, filter for Homer Simpson, and calculate the sum of transaction amounts grouped by merchant description and job title.

SELECT 
    pe.Description,
    fd.Job_Title,
    SUM(pe.Amount) AS Total_Expenditure
FROM [SIMPSONS].[dbo].[Planet_Express] AS pe
JOIN [SIMPSONS].[dbo].[Family_Data] AS fd 
    ON pe.Card_Member = fd.Name
WHERE 
    fd.Name = 'Homer Simpson'
GROUP BY 
    pe.Description,
    fd.Job_Title
ORDER BY 
    Total_Expenditure DESC;

-- Q2 (Author: Me): What are all cleared debit transactions made by family members living at 742 Evergreen Terrace? I need to track household spending against home address, which requires pulling transaction debits and status from FBS_Viza_Costmo joined with home address details from Family_Data.
-- A2: Join FBS_Viza_Costmo with Family_Data on member name, filter for records where the home address is '742 Evergreen Terrace', the transaction status is 'Cleared', and the debit column is not null.

SELECT 
    fd.Name,
    fd.Home_Address,
    vc.Status,
    vc.Date,
    vc.Description,
    vc.Debit
FROM [SIMPSONS].[dbo].[FBS_Viza_Costmo] AS vc
JOIN [SIMPSONS].[dbo].[Family_Data] AS fd 
    ON vc.Member_Name = fd.Name
WHERE 
    fd.Home_Address = '742 Evergreen Terrace'
    AND vc.Status = 'Cleared'
    AND vc.Debit IS NOT NULL;

-- Q3 (Author: Me): Which expense categories had transactions charged across both the Planet Express card and the Viza Costmo card by Marge Simpson? I am reviewing total household card usage, needing expense categories and amounts from Planet_Express matched with transaction debits from FBS_Viza_Costmo.
-- A3: Join Planet_Express and FBS_Viza_Costmo on matching merchant descriptions for Marge Simpson to map Planet Express categories and amounts to Viza Costmo debit transactions.

SELECT 
    pe.Category,
    pe.Description,
    SUM(pe.Amount) AS Total_Planet_Express_Amount,
    SUM(vc.Debit) AS Total_Viza_Costmo_Debit
FROM [SIMPSONS].[dbo].[Planet_Express] AS pe
JOIN [SIMPSONS].[dbo].[FBS_Viza_Costmo] AS vc 
    ON pe.Description = vc.Description
WHERE 
    pe.Card_Member = 'MARGE SIMPSON'
    AND vc.Member_Name = 'Marge Simpson'
GROUP BY 
    pe.Category,
    pe.Description
ORDER BY 
    Total_Planet_Express_Amount DESC;

-- Q4 (Author: Renz Lendyl Palpal-latoc): Looking at all our credit card statements, who in the family is spending the most, and what are they spending it on?
-- A4: Union all debit and purchase transactions across both credit card tables (Planet_Express and FBS_Viza_Costmo), then group by family member and spending category/description to calculate total expenditures and rank highest spenders.

WITH Combined_Card_Transactions AS (
    SELECT 
        Card_Member AS Member_Name,
        Category,
        Description,
        Amount AS Expenditure
    FROM [SIMPSONS].[dbo].[Planet_Express]
    
    UNION ALL
    
    SELECT 
        Member_Name,
        'Viza Costmo Debit' AS Category,
        Description,
        Debit AS Expenditure
    FROM [SIMPSONS].[dbo].[FBS_Viza_Costmo]
    WHERE Debit IS NOT NULL
)
SELECT 
    Member_Name,
    Category,
    Description,
    SUM(Expenditure) AS Total_Amount_Spent
FROM Combined_Card_Transactions
GROUP BY 
    Member_Name,
    Category,
    Description
ORDER BY 
    Total_Amount_Spent DESC;