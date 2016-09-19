
select
 "TransactionScenarioId",
 "ProjectId",
 "TransactionAttrDistributionId",
 "ScenarioId",
 "FiscalPeriodId",
 "AccountId"
from dm_TransactionProjectScenario
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TRANSACTIONPROJECTSCENARIO_TRANSFORM_ID}
