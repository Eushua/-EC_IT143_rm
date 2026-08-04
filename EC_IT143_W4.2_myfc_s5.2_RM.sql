-- Refine table architecture with explicit data types, primary key, NOT NULL rules, and default load timestamp

IF OBJECT_ID('dbo.t_player_salary', 'U') IS NOT NULL
    DROP TABLE dbo.t_player_salary;
GO

CREATE TABLE dbo.t_player_salary
(
    player_salary_id INT IDENTITY(1, 1) NOT NULL,
    as_of_date       DATE               NOT NULL,
    pl_id            INT                NOT NULL,
    pl_name          VARCHAR(100)       NOT NULL,
    position_name    VARCHAR(50)        NOT NULL,
    mtd_salary       DECIMAL(12, 2)     NOT NULL,
    load_date        DATETIME           NOT NULL CONSTRAINT DF_t_player_salary_load_date DEFAULT (GETDATE()),
    CONSTRAINT PK_t_player_salary PRIMARY KEY CLUSTERED (player_salary_id ASC)
);
GO

-- Verify table schema structure
EXEC sp_help 'dbo.t_player_salary';