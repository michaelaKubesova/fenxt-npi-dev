drop table if exists out_TransactionScenario;
CREATE TABLE out_TransactionScenario
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    TransactionScenarioId varchar(255),
    TransactionDistributionId varchar(255),
    ScenarioId varchar(255),
    FiscalPeriodId varchar(255),
    AccountId varchar(255)
)
 ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);