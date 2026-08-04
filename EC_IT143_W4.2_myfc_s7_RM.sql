/*****************************************************************************************************************
NAME:    EC_IT143_W4.2_myfc_s7_xx.sql
PURPOSE: Package the TRUNCATE and INSERT logic into a stored procedure for production ETL.

MODIFICATION LOG:
Ver      Date        Author           Description
-----    ----------  ---------------  -------------------------------------------------------------------------------
1.0      08/04/2026  Your Name        1. Created procedure p_player_salary_load for MyFC dataset.

RUNTIME:
1s

NOTES:
Encapsulates ETL load logic into SQL Server for maintainability and automated execution.
*****************************************************************************************************************/

IF OBJECT_ID('dbo.p_player_salary_load', 'P') IS NOT NULL
    DROP PROCEDURE dbo.p_player_salary_load;
GO

CREATE PROCEDURE dbo.p_player_salary_load
AS
/*****************************************************************************************************************
NAME:    dbo.p_player_salary_load
PURPOSE: Reloads dbo.t_player_salary from dbo.v_player_salary_load.
*****************************************************************************************************************/
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Truncate target table
    TRUNCATE TABLE dbo.t_player_salary;

    -- Step 2: Insert data from view
    INSERT INTO dbo.t_player_salary
    (
        as_of_date,
        pl_id,
        pl_name,
        position_name,
        mtd_salary
    )
    SELECT
        v.as_of_date,
        v.pl_id,
        v.pl_name,
        v.position_name,
        v.mtd_salary
    FROM dbo.v_player_salary_load AS v;

    SET NOCOUNT OFF;
END;
GO