-- Ad hoc SQL script to load refined table from view using TRUNCATE and INSERT

TRUNCATE TABLE dbo.t_simpsons_expenses;

INSERT INTO dbo.t_simpsons_expenses
(
    transaction_date,
    member_id,
    member_name,
    job_title,
    transaction_description,
    transaction_category,
    transaction_amount
)
SELECT
    v.transaction_date,
    v.member_id,
    v.member_name,
    v.job_title,
    v.transaction_description,
    v.transaction_category,
    v.transaction_amount
FROM dbo.v_simpsons_expenses_load AS v;

-- Verify successful load
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