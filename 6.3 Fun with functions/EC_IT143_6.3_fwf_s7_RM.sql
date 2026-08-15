-- Q: How to extract last name from Contact Name?

-- A: Well, here is your problem...
-- ContactName = Alejandra Camino -> Camino
-- Google search "How to extract last name from combined name tsql stack overflow"
-- https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name

WITH s1 -- Use a Common Table Expression and compare last_name to last_name2
AS (SELECT t.ContactName
         , RIGHT(t.ContactName, LEN(t.ContactName) - CHARINDEX(' ', t.ContactName)) AS last_name
         , dbo.udf_parse_last_name(t.ContactName) AS last_name2
      FROM dbo.t_w3_schools_customers AS t)
SELECT s1.*
  FROM s1
 WHERE s1.last_name <> s1.last_name2; -- Expected result is 0 rows