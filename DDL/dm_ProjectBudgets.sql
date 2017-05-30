 create or replace view dm_ProjectBudgets as select 
_sys_transform_id,
TenantId,
PeriodAmount,
ProjectBudgetId,
AccountBudgetAttrId,
ProjectId,
AccountId,
ProjectBudgetAmount,
FiscalPeriodId,
ScenarioId
from out_ProjectBudgets 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ProjectBudgets');
