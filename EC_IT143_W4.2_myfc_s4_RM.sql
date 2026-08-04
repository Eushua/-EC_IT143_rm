/*****************************************************************************************************************
NAME:    EC_IT143_W4.2_myfc_s4_RM.sql
PURPOSE: Create a view encapsulating player salary details combined with position dimension data.

MODIFICATION LOG:
Ver      Date        Author           Description
-----    ----------  ---------------  -------------------------------------------------------------------------------
1.0      08/04/2026  Your Name        1. Created view v_player_salary_load for MyFC dataset.

RUNTIME:
1s

NOTES:
This view acts as the staging/source data layer for populating the t_player_salary destination table.
*****************************************************************************************************************/

IF OBJECT_ID('dbo.v_player_salary_load', 'V') IS NOT NULL
    DROP VIEW dbo.v_player_salary_load;
GO

CREATE VIEW dbo.v_player_salary_load
AS
/*****************************************************************************************************************
NAME:    dbo.v_player_salary_load
PURPOSE: Standardized view joining player fact records with player and position dimensions.
*****************************************************************************************************************/
SELECT
    f.as_of_date,
    p.pl_id,
    p.pl_name,
    pos.p_name AS position_name,
    f.mtd_salary
FROM dbo.tblPlayerFact AS f
INNER JOIN dbo.tblPlayerDim AS p
    ON f.pl_id = p.pl_id
INNER JOIN dbo.tblPositionDim AS pos
    ON p.p_id = pos.p_id;
GO

-- Test query to verify view output
SELECT
    v.as_of_date,
    v.pl_id,
    v.pl_name,
    v.position_name,
    v.mtd_salary
FROM dbo.v_player_salary_load AS v;