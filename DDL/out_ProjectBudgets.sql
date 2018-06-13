drop table if exists out_ProjectBudgets;
CREATE TABLE out_ProjectBudgets
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    PeriodAmount varchar(255),
    ProjectBudgetId varchar(255),
    AccountBudgetAttrId varchar(255),
    ProjectId varchar(255),
    AccountId varchar(255),
    ProjectBudgetAmount varchar(255),
    FiscalPeriodId varchar(255),
    ScenarioId varchar(255)
) ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);