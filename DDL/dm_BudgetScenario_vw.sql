 create or replace view dm_BudgetScenario as select 
_sys_transform_id,
TenantId,
ScenarioId,
ScenarioDesc
from out_BudgetScenario 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_BudgetScenario');
