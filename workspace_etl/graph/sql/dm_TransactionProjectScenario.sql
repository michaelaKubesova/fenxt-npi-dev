
select
 "TransactionScenarioId",
 "ProjectId",
 "TransactionAttrDistributionId",
 "ScenarioId",
 "FiscalPeriodId",
 "AccountId"
from dm_TransactionProjectScenario
where TenantId = '${TenantId}'


