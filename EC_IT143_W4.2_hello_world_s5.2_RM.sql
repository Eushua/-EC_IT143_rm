-- Refine table architecture with explicit data types, a primary key, default constraints, and NOT NULL rules

IF OBJECT_ID('dbo.t_hello_world', 'U') IS NOT NULL
    DROP TABLE dbo.t_hello_world;
GO

CREATE TABLE dbo.t_hello_world
(
    my_id             INT IDENTITY(1, 1) NOT NULL,
    my_message        VARCHAR(50)        NOT NULL,
    current_date_time DATETIME           NOT NULL CONSTRAINT DF_t_hello_world_current_date_time DEFAULT (GETDATE()),
    CONSTRAINT PK_t_hello_world PRIMARY KEY CLUSTERED (my_id ASC)
);
GO

-- Verify table metadata structure
EXEC sp_help 'dbo.t_hello_world';