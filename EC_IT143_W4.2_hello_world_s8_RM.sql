-- Execute stored procedure to run the load process
EXEC dbo.p_hello_world_load;

-- Verify that data was successfully loaded into destination table
SELECT
    thw.my_id,
    thw.my_message,
    thw.current_date_time
FROM dbo.t_hello_world AS thw;