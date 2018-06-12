drop TABLE if exists wk_FiscalPeriod_Scenario_Join;
CREATE TABLE wk_FiscalPeriod_Scenario_Join
(
    TenantId varchar(255) encoding rle,
    ProjectId int,
    AccountId int,
    ScenarioId varchar(255),
    FiscalPeriodId int
) order by TenantId,AccountId,ProjectId,FiscalPeriodId
SEGMENTED BY hash(TenantId) ALL NODES;