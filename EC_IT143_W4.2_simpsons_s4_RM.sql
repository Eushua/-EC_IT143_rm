/*****************************************************************************************************************
NAME:    EC_IT143_W4.2_simpsons_s4_RM.sql
PURPOSE: Create a view encapsulating family member expense transactions from Planet Express.

MODIFICATION LOG:
Ver      Date        Author           Description
-----    ----------  ---------------  -------------------------------------------------------------------------------
1.0      08/04/2026  Your Name        1. Created view v_simpsons_expenses_load for SIMPSONS dataset.

RUNTIME:
1s

NOTES:
Serves as the source staging view for populating the t_simpsons_expenses target table.
*****************************************************************************************************************/

IF OBJECT_ID('dbo.v_simpsons_expenses_load', 'V') IS NOT NULL
    DROP VIEW dbo.v_simpsons_expenses_load;
GO

CREATE VIEW dbo.v_simpsons_expenses_load
AS
/*****************************************************************************************************************
NAME:    dbo.v_simpsons_expenses_load
PURPOSE: Standardized view joining credit card transactions with family member demographic records.
*****************************************************************************************************************/
SELECT
    pe.[Date]        AS transaction_date,
    fd.Member_ID     AS member_id,
    fd.Name          AS member_name,
    fd.Job_Title     AS job_title,
    pe.Description   AS transaction_description,
    pe.Category      AS transaction_category,
    pe.Amount        AS transaction_amount
FROM dbo.Planet_Express AS pe
INNER JOIN dbo.Family_Data AS fd
    ON pe.Card_Member = fd.Name;
GO

-- Test query to verify view output
SELECT
    v.transaction_date,
    v.member_id,
    v.member_name,
    v.job_title,
    v.transaction_description,
    v.transaction_category,
    v.transaction_amount
FROM dbo.v_simpsons_expenses_load AS v;