-- Create table using SELECT INTO from the view to establish destination structure

IF OBJECT_ID('dbo.t_hello_world', 'U') IS NOT NULL
    DROP TABLE dbo.t_hello_world;
GO

SELECT
    v.my_message,
    v.current_date_time
INTO dbo.t_hello_world
FROM dbo.v_hello_world_load AS v;
GO

-- Verify table creation
SELECT
    t.my_message,
    t.current_date_time
FROM dbo.t_hello_world AS t;