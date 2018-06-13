
select
 "TransactionScenarioId",
 "TransactionDistributionId",
 "ScenarioId",
 "FiscalPeriodId",
 "AccountId"
from dm_TransactionScenario
where TenantId = '${TenantId}'

;