-- Querying transaction details combined with family member profile data

SELECT
    pe.[Date]        AS transaction_date,
    fd.Member_ID     AS member_id,
    fd.Name          AS member_name,
    fd.Job_Title     AS job_title,
    pe.Description   AS transaction_description,
    pe.Category      AS transaction_category,
    pe.Amount        AS transaction_amount
FROM dbo.Planet_Express AS pe
INNER JOIN dbo.Family_Data AS fd
    ON pe.Card_Member = fd.Name;