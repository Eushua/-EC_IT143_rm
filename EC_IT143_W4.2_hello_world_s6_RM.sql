-- Ad hoc SQL script to load the table from the view using TRUNCATE and INSERT

TRUNCATE TABLE dbo.t_hello_world;

INSERT INTO dbo.t_hello_world
(
    my_message,
    current_date_time
)
SELECT
    v.my_message,
    v.current_date_time
FROM dbo.v_hello_world_load AS v;

-- Verify successful load
SELECT
    thw.my_id,
    thw.my_message,
    thw.current_date_time
FROM dbo.t_hello_world AS thw;