-- Execute stored procedure to initiate ETL process
EXEC dbo.p_player_salary_load;

-- Verify target table content post-execution
SELECT
    t.player_salary_id,
    t.as_of_date,
    t.pl_id,
    t.pl_name,
    t.position_name,
    t.mtd_salary,
    t.load_date
FROM dbo.t_player_salary AS t;