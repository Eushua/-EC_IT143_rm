DELETE FROM dbo.t_hello_world
 WHERE my_message IN('Hello World2', 'Hello World3', 'Hello World4');

-- Load test rows
INSERT INTO dbo.t_hello_world(my_message)
VALUES('Hello World2'), ('Hello World3');

-- See if the trigger worked
SELECT t.*
  FROM dbo.t_hello_world AS t;

-- Try it again
UPDATE dbo.t_hello_world 
   SET my_message = 'Hello World4'
 WHERE my_message = 'Hello World3';

-- See if the trigger worked
SELECT t.*
  FROM dbo.t_hello_world AS t;

-- Q4: How to keep track of who last modified a record?
-- A4: This works for server user and the initial INSERT...

ALTER TABLE dbo.t_hello_world
ADD last_modified_by VARCHAR(50) DEFAULT SUSER_NAME();