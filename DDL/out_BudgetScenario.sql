drop table if exists out_BudgetScenario;
CREATE TABLE out_BudgetScenario
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    ScenarioId varchar(255),
    ScenarioDesc varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id,
          ScenarioId
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);