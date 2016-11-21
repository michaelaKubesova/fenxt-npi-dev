
select
 "PeriodAmount",
 "ProjectBudgetId",
 "AccountBudgetAttrId",
 "ProjectId",
 "AccountId",
 "ProjectBudgetAmount",
 "FiscalPeriodId"
 
from dm_ProjectBudgets
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_PROJECTBUDGETS_TRANSFORM_ID}
