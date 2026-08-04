-- Ad hoc SQL script to load refined table from view using TRUNCATE and INSERT

TRUNCATE TABLE dbo.t_player_salary;

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

-- Verify successful load
SELECT
    t.player_salary_id,
    t.as_of_date,
    t.pl_id,
    t.pl_name,
    t.position_name,
    t.mtd_salary,
    t.load_date
FROM dbo.t_player_salary AS t;