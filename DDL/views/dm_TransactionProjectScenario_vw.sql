 create or replace view dm_TransactionProjectScenario as select 
_sys_transform_id,
TenantId,
TransactionAttrDistributionId || '#' || ScenarioId AS TransactionScenarioId,
ProjectId,
TransactionAttrDistributionId,
ScenarioId,
FiscalPeriodId,
AccountId
from out_TransactionProjectScenario 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_TransactionProjectScenario');
