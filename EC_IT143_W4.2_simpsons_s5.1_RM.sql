-- Create target table using SELECT INTO from source view to determine target structure

IF OBJECT_ID('dbo.t_simpsons_expenses', 'U') IS NOT NULL
    DROP TABLE dbo.t_simpsons_expenses;
GO

SELECT
    v.transaction_date,
    v.member_id,
    v.member_name,
    v.job_title,
    v.transaction_description,
    v.transaction_category,
    v.transaction_amount
INTO dbo.t_simpsons_expenses
FROM dbo.v_simpsons_expenses_load AS v;
GO

-- Verify table creation
SELECT
    t.transaction_date,
    t.member_id,
    t.member_name,
    t.job_title,
    t.transaction_description,
    t.transaction_category,
    t.transaction_amount
FROM dbo.t_simpsons_expenses AS t;