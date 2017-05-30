 create or replace view dm_AccountBudgets_fact as select 
_sys_transform_id,
TenantId,
AccountBudgetAmount,
AccountId,
FiscalPeriodId,
AccountBudgetFactId,
AccountBudgetAttrId,
ScenarioId
from out_AccountBudgets_fact 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_AccountBudgets_fact');
