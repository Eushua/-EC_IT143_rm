/*****************************************************************************************************************
NAME:    EC_IT143_W4.2_simpsons_s7_xx.sql
PURPOSE: Package the TRUNCATE and INSERT logic into a stored procedure for production ETL.

MODIFICATION LOG:
Ver      Date        Author           Description
-----    ----------  ---------------  -------------------------------------------------------------------------------
1.0      08/04/2026  Your Name        1. Created procedure p_simpsons_expenses_load for SIMPSONS dataset.

RUNTIME:
1s

NOTES:
Encapsulates ETL load logic into SQL Server for security, reuse, and maintainability.
*****************************************************************************************************************/

IF OBJECT_ID('dbo.p_simpsons_expenses_load', 'P') IS NOT NULL
    DROP PROCEDURE dbo.p_simpsons_expenses_load;
GO

CREATE PROCEDURE dbo.p_simpsons_expenses_load
AS
/*****************************************************************************************************************
NAME:    dbo.p_simpsons_expenses_load
PURPOSE: Reloads dbo.t_simpsons_expenses from dbo.v_simpsons_expenses_load.
*****************************************************************************************************************/
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Truncate target table
    TRUNCATE TABLE dbo.t_simpsons_expenses;

    -- Step 2: Insert data from view
    INSERT INTO dbo.t_simpsons_expenses
    (
        transaction_date,
        member_id,
        member_name,
        job_title,
        transaction_description,
        transaction_category,
        transaction_amount
    )
    SELECT
        v.transaction_date,
        v.member_id,
        v.member_name,
        v.job_title,
        v.transaction_description,
        v.transaction_category,
        v.transaction_amount
    FROM dbo.v_simpsons_expenses_load AS v;

    SET NOCOUNT OFF;
END;
GO