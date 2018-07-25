drop table if exists wrk_out_TransactionScenario;
drop table if exists wrk_out_TransactionScenario_diff;
drop table if exists out_TransactionScenario;

CREATE TABLE out_TransactionScenario
(
    TenantId varchar(255) encoding rle,
    TransactionDistributionId int,
    ScenarioId varchar(255) ENCODING RLE,
    FiscalPeriodId int ENCODING RLE,
    AccountId int ENCODING RLE,
    _sys_is_deleted boolean  ENCODING RLE,
    _sys_updated_at timestamp ENCODING RLE
)  ORDER BY TenantId,
    TransactionDistributionId,
    ScenarioId,
    FiscalPeriodId,
    AccountId,
    _sys_is_deleted
SEGMENTED BY hash(TenantId) ALL NODES
;

create table wrk_out_TransactionScenario like out_TransactionScenario including projections;
create table wrk_out_TransactionScenario_diff like out_TransactionScenario including projections;

ALTER TABLE out_TransactionScenario ADD CONSTRAINT out_TransactionScenario_MK_PK PRIMARY KEY (tenantid, TransactionDistributionId, ScenarioId);