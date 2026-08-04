/*****************************************************************************************************************
NAME:    EC_IT143_W4.2_hello_world_s7_xx.sql
PURPOSE: Turn the TRUNCATE and INSERT script into a stored procedure for repeatable ETL loads.

MODIFICATION LOG:
Ver      Date        Author           Description
-----    ----------  ---------------  -------------------------------------------------------------------------------
1.0      08/04/2026  Your Name        1. Created stored procedure p_hello_world_load for EC_IT143 W4.2

RUNTIME:
1s

NOTES:
Encapsulates data load logic directly into SQL Server for enhanced security and pipeline integration.
*****************************************************************************************************************/

IF OBJECT_ID('dbo.p_hello_world_load', 'P') IS NOT NULL
    DROP PROCEDURE dbo.p_hello_world_load;
GO

CREATE PROCEDURE dbo.p_hello_world_load
AS
/*****************************************************************************************************************
NAME:    dbo.p_hello_world_load
PURPOSE: Load data into dbo.t_hello_world from dbo.v_hello_world_load view.
*****************************************************************************************************************/
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Truncate existing data from target table
    TRUNCATE TABLE dbo.t_hello_world;

    -- Step 2: Insert fresh dataset from source view
    INSERT INTO dbo.t_hello_world
    (
        my_message,
        current_date_time
    )
    SELECT
        v.my_message,
        v.current_date_time
    FROM dbo.v_hello_world_load AS v;

    SET NOCOUNT OFF;
END;
GO