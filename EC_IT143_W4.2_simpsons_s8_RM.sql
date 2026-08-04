-- Execute stored procedure to initiate ETL process
EXEC dbo.p_simpsons_expenses_load;

-- Verify target table content post-execution
SELECT
    t.expense_id,
    t.transaction_date,
    t.member_id,
    t.member_name,
    t.job_title,
    t.transaction_description,
    t.transaction_category,
    t.transaction_amount,
    t.load_date
FROM dbo.t_simpsons_expenses AS t;