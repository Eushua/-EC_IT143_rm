-- Querying a literal string 'Hello World' and the current system date/time

SELECT
    'Hello World' AS my_message,
    GETDATE()     AS current_date_time;