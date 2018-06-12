
select
 "AccountBudgetAmount",
 "AccountId",
 "FiscalPeriodId",
 "AccountBudgetFactId",
 "AccountBudgetAttrId"
from dm_AccountBudgets_fact
where TenantId = '${TenantId}'

;