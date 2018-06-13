drop table if exists out_AccountBudgets_attr;
CREATE TABLE out_AccountBudgets_attr
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    AccountBudgetAttrId varchar(255),
    IncorrectScenarioId varchar(255),
    ScenarioId varchar(255),
    AccountBudgetId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);