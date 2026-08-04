-- Refine table architecture with explicit data types, primary key, NOT NULL rules, and default load timestamp

IF OBJECT_ID('dbo.t_simpsons_expenses', 'U') IS NOT NULL
    DROP TABLE dbo.t_simpsons_expenses;
GO

CREATE TABLE dbo.t_simpsons_expenses
(
    expense_id              INT IDENTITY(1, 1) NOT NULL,
    transaction_date        DATETIME           NOT NULL,
    member_id               DECIMAL(5, 2)      NOT NULL,
    member_name             VARCHAR(100)       NOT NULL,
    job_title               VARCHAR(100)       NULL,
    transaction_description VARCHAR(255)       NOT NULL,
    transaction_category    VARCHAR(100)       NOT NULL,
    transaction_amount      DECIMAL(12, 2)     NOT NULL,
    load_date               DATETIME           NOT NULL CONSTRAINT DF_t_simpsons_expenses_load_date DEFAULT (GETDATE()),
    CONSTRAINT PK_t_simpsons_expenses PRIMARY KEY CLUSTERED (expense_id ASC)
);
GO

-- Verify table schema structure
EXEC sp_help 'dbo.t_simpsons_expenses';

