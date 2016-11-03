
select
 "AccountBudgetAmount",
 "AccountId",
 "FiscalPeriodId",
 "AccountBudgetFactId",
 "AccountBudgetAttrId"
from dm_AccountBudgets_fact
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_ACCOUNTBUDGETS_FACT_TRANSFORM_ID}
;