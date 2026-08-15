CREATE FUNCTION [dbo].[udf_parse_last_name]
(
    @v_combined_name AS VARCHAR(500)
)
RETURNS VARCHAR(100)
AS
/***************************************************************************************************
NAME:    dbo.udf_parse_last_name
PURPOSE: Parse Last Name from combined name

MODIFICATION LOG:
Ver      Date        Author      Description
-----    ----------  ----------  ------------------------------------------------------------------
1.0      08/16/2026  RM          1. Built this script for EC IT143

RUNTIME:
1s

NOTES:
Adapted from the following...
https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name
***************************************************************************************************/
BEGIN

    DECLARE @v_last_name AS VARCHAR(100);

    SET @v_last_name = RIGHT(@v_combined_name, LEN(@v_combined_name) - CHARINDEX(' ', @v_combined_name));

    RETURN @v_last_name;

END;
GO