-- Q: How to extract last name from Contact Name?

-- A: Well, here is your problem...
-- ContactName = Alejandra Camino -> Camino

SELECT t.ContactName
  FROM dbo.t_w3_schools_customers AS t
 ORDER BY 1;