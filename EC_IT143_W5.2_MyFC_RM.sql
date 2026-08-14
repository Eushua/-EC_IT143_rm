/*******************************************************************************
NAME:    EC_IT143_W5.2_MyFC_RM
PURPOSE: Answer four community questions about the MyFC dataset.
MODIFICATION LOG:
Ver     Date        Author        Description
-----   ----------  ------------  ------------------------------------------------------------------
1.0     08/14/2026  Rheneil          1. Built this script for EC IT143 W5.2 deliverable.

RUNTIME: 
< 1s

NOTES:
Tables used: tblPlayerFact, tblPlayerDim, tblPositionDim, tblTeamDim
Database: MyFC

*******************************************************************************/

-- Q1 (Author: Rheneil): What is the total MTD salary payout grouped by player position name across all active squad members? I am asking for this to review team positional payrolls, which requires combining the MTD salary from tblPlayerFact with the position name from tblPositionDim.
-- A1: Join the player fact table to the player dimension table to map each player to their position ID, then join the position dimension table to group by position name and calculate the sum of the MTD salary.

SELECT 
    p.p_name,
    SUM(f.mtd_salary) AS Total_MTD_Salary
FROM [MyFC].[dbo].[tblPlayerFact] AS f
JOIN [MyFC].[dbo].[tblPlayerDim] AS pd 
    ON f.pl_id = pd.pl_id
JOIN [MyFC].[dbo].[tblPositionDim] AS p 
    ON pd.p_id = p.p_id
GROUP BY 
    p.p_name
ORDER BY 
    Total_MTD_Salary DESC;


-- Q2 (Author: Rheneil): Which players are currently assigned to the Goalkeeper position along with their designated jersey numbers? I need this roster list for upcoming match selection, requiring the player full name and jersey number from tblPlayerDim paired with the position name from tblPositionDim.
-- A2: Join tblPlayerDim with tblPositionDim on p_id, filter the results where p_name equals 'Goalkeeper', and select the player full name (pl_name), jersey number (pl_num), and position name (p_name).

SELECT 
    pd.pl_name,
    pd.pl_num,
    p.p_name
FROM [MyFC].[dbo].[tblPlayerDim] AS pd
JOIN [MyFC].[dbo].[tblPositionDim] AS p 
    ON pd.p_id = p.p_id
WHERE 
    p.p_name = 'Goalkeeper';

-- Q3 (Author: Rheneil): How many players are allocated to each team tier code across the entire club organization? I am evaluating squad depth across divisions, which requires joining player records from tblPlayerDim with team code classifications from tblTeamDim.
-- A3: Join tblPlayerDim with tblTeamDim on t_id, group the results by team tier code (t_code), and count the total number of players assigned to each team.

SELECT 
    t.t_code,
    COUNT(pd.pl_id) AS Total_Players
FROM [MyFC].[dbo].[tblPlayerDim] AS pd
JOIN [MyFC].[dbo].[tblTeamDim] AS t 
    ON pd.t_id = t.t_id
GROUP BY 
    t.t_code
ORDER BY 
    Total_Players DESC;


-- Q4 (Author: Renz Lendyl Palpal-latoc): Which position group is costing us the most in salaries each month, and is that trend going up or down?
-- A4: Join tblPlayerFact with tblPlayerDim and tblPositionDim, then group by snapshot date (as_of_date) and position name (p_name) to sum MTD salary per month, allowing comparison of total position costs across monthly pay periods to evaluate trends.

SELECT 
    f.as_of_date,
    p.p_name,
    SUM(f.mtd_salary) AS Total_MTD_Salary
FROM [MyFC].[dbo].[tblPlayerFact] AS f
JOIN [MyFC].[dbo].[tblPlayerDim] AS pd 
    ON f.pl_id = pd.pl_id
JOIN [MyFC].[dbo].[tblPositionDim] AS p 
    ON pd.p_id = p.p_id
GROUP BY 
    f.as_of_date,
    p.p_name
ORDER BY 
    f.as_of_date ASC,
    Total_MTD_Salary DESC;