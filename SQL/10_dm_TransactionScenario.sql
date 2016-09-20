INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionScenario',now(),null);
insert /*+ direct */ into dm_TransactionScenario
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
ab.TenantId as "TenantId",
GoodData_Attr(t.TransactionDistributionId||'#'||ab.ScenarioId) as "TransactionScenarioId",
GoodData_Attr(t.TransactionDistributionId) as "TransactionDistributionId",
GoodData_Attr(ab.ScenarioId) as "ScenarioId",
GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId",
GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_AccountBudgets_merge ab
join stg_csv_Transactions_merge t
on 		t.AccountId = ab.AccountId
and t.TenantId = ab.TenantId
group by ab.scenarioId, ab.TenantId, t.TransactionDistributionId, t.FiscalPeriodId, t.AccountId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionScenario',null,now());
select analyze_statistics('dm_TransactionScenario')
;