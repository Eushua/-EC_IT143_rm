/*****************************************************************************************************************
NAME:    EC_IT143_W4.2_hello_world_s4_xx.sql
PURPOSE: Create a view that encapsulates the 'Hello World' message and current timestamp query.

MODIFICATION LOG:
Ver      Date        Author           Description
-----    ----------  ---------------  -------------------------------------------------------------------------------
1.0      08/04/2026  Your Name        1. Built view v_hello_world_load for EC_IT143 W4.2

RUNTIME:
1s

NOTES:
This view serves as the source data layer for downstream table loads in our ETL pipeline.
*****************************************************************************************************************/

IF OBJECT_ID('dbo.v_hello_world_load', 'V') IS NOT NULL
    DROP VIEW dbo.v_hello_world_load;
GO

CREATE VIEW dbo.v_hello_world_load
AS
/*****************************************************************************************************************
NAME:    dbo.v_hello_world_load
PURPOSE: Provide a standardized source dataset returning a Hello World message and timestamp.
*****************************************************************************************************************/
SELECT
    'Hello World' AS my_message,
    GETDATE()     AS current_date_time;
GO

-- Test query to verify view output
SELECT
    v.my_message,
    v.current_date_time
FROM dbo.v_hello_world_load AS v;