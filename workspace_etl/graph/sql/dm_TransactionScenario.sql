
select
 "TransactionScenarioId",
 "TransactionDistributionId",
 "ScenarioId",
 "FiscalPeriodId",
 "AccountId"
from dm_TransactionScenario
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TRANSACTIONSCENARIO_TRANSFORM_ID}
;