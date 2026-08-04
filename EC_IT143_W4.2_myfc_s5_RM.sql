-- Create target table using SELECT INTO from source view to determine baseline data structure

IF OBJECT_ID('dbo.t_player_salary', 'U') IS NOT NULL
    DROP TABLE dbo.t_player_salary;
GO

SELECT
    v.as_of_date,
    v.pl_id,
    v.pl_name,
    v.position_name,
    v.mtd_salary
INTO dbo.t_player_salary
FROM dbo.v_player_salary_load AS v;
GO

-- Verify table creation
SELECT
    t.as_of_date,
    t.pl_id,
    t.pl_name,
    t.position_name,
    t.mtd_salary
FROM dbo.t_player_salary AS t;