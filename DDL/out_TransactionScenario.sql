drop table if exists wrk_out_TransactionScenario;
CREATE TABLE wrk_out_TransactionScenario
(
    TenantId varchar(255) encoding rle,
    TransactionDistributionId int,
    ScenarioId varchar(255),
    FiscalPeriodId int,
    AccountId int,
    _sys_is_deleted boolean
)  ORDER BY TenantId,
    TransactionDistributionId,
    ScenarioId,
    FiscalPeriodId,
    AccountId,
    _sys_is_deleted
SEGMENTED BY hash(TenantId) ALL NODES;

drop table if exists wrk_out_TransactionScenario_diff;
CREATE TABLE wrk_out_TransactionScenario_diff
(
    TenantId varchar(255) encoding rle,
    TransactionDistributionId int,
    ScenarioId varchar(255),
    FiscalPeriodId int,
    AccountId int,
    _sys_is_deleted boolean
)  ORDER BY TenantId,
    TransactionDistributionId,
    ScenarioId,
    FiscalPeriodId,
    AccountId,
    _sys_is_deleted
SEGMENTED BY hash(TenantId) ALL NODES;

drop table if exists out_TransactionScenario;
CREATE TABLE out_TransactionScenario
(
    TenantId varchar(255) encoding rle,
    TransactionDistributionId int,
    ScenarioId varchar(255),
    FiscalPeriodId int,
    AccountId int,
    _sys_is_deleted boolean,
    _sys_updated_at timestamp
)  ORDER BY TenantId,
    TransactionDistributionId,
    ScenarioId,
    FiscalPeriodId,
    AccountId,
    _sys_is_deleted
SEGMENTED BY hash(TenantId) ALL NODES
;

ALTER TABLE out_TransactionScenario ADD CONSTRAINT out_TransactionScenario_MK_PK PRIMARY KEY (tenantid, TransactionDistributionId, ScenarioId);