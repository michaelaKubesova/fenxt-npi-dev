drop table if exists wrk_tmp_transaction_scenario;
CREATE TABLE wrk_tmp_transaction_scenario
(
    AccountId int ENCODING RLE,
    ScenarioId varchar(255) ENCODING RLE,
    FiscalPeriodId int ENCODING RLE,
    tenantid varchar(255) ENCODING RLE,
    _sys_is_deleted boolean ENCODING RLE,
    _sys_updated_at timestamp
) ORDER BY tenantid,
          AccountId,
          FiscalPeriodId,
          ScenarioId,
          _sys_is_deleted
SEGMENTED BY hash(tenantid) ALL NODES;

drop table if exists wrk_tmp_transaction_scenario_diff;
CREATE TABLE wrk_tmp_transaction_scenario_diff
(
    AccountId int ENCODING RLE,
    ScenarioId varchar(255) ENCODING RLE,
    FiscalPeriodId int ENCODING RLE,
    tenantid varchar(255) ENCODING RLE,
    _sys_is_deleted boolean ENCODING RLE,
    _sys_updated_at timestamp
) ORDER BY tenantid,
          AccountId,
          FiscalPeriodId,
          ScenarioId,
          _sys_is_deleted
SEGMENTED BY hash(tenantid) ALL NODES;


drop table if exists tmp_transaction_scenario;
CREATE TABLE tmp_transaction_scenario
(
    AccountId int NOT NULL ENCODING RLE,
    ScenarioId varchar(255) NOT NULL ENCODING RLE,
    FiscalPeriodId int NOT NULL ENCODING RLE,
    tenantid varchar(255) NOT NULL ENCODING RLE,
    _sys_is_deleted boolean ENCODING RLE,
    _sys_updated_at timestamp
) ORDER BY tenantid,
          AccountId,
          FiscalPeriodId,
          ScenarioId,
          _sys_is_deleted
SEGMENTED BY hash(tenantid) ALL NODES;

ALTER TABLE tmp_transaction_scenario ADD CONSTRAINT tmp_transaction_scenario_PK PRIMARY KEY (tenantid, AccountId, FiscalPeriodId, ScenarioId);