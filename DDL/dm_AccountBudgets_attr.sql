 create or replace view dm_AccountBudgets_attr as select 
_sys_transform_id,
TenantId,
AccountBudgetAttrId,
IncorrectScenarioId,
ScenarioId,
AccountBudgetId
from out_AccountBudgets_attr 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_AccountBudgets_attr');
