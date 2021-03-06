 create or replace view dm_TransactionScenario as select 
_sys_transform_id,
TenantId,
TransactionDistributionId || '#' || ScenarioId AS TransactionScenarioId,
TransactionDistributionId,
ScenarioId,
FiscalPeriodId,
AccountId
from out_TransactionScenario 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_TransactionScenario');
