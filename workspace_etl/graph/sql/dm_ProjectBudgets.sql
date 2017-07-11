
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

