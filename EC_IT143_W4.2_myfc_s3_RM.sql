-- Querying player details, position names, and MTD salaries from MyFC tables

SELECT
    f.as_of_date,
    p.pl_id,
    p.pl_name,
    pos.p_name AS position_name,
    f.mtd_salary
FROM dbo.tblPlayerFact AS f
INNER JOIN dbo.tblPlayerDim AS p
    ON f.pl_id = p.pl_id
INNER JOIN dbo.tblPositionDim AS pos
    ON p.p_id = pos.p_id;