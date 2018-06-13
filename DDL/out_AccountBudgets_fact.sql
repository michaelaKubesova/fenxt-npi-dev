drop table if exists out_AccountBudgets_fact;
CREATE TABLE out_AccountBudgets_fact
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    AccountBudgetAmount varchar(255),
    AccountId varchar(255),
    FiscalPeriodId varchar(255),
    AccountBudgetFactId varchar(255),
    AccountBudgetAttrId varchar(255),
    ScenarioId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);