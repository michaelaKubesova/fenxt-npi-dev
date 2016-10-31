
select
 "AccountBudgetAmount",
 "AccountId",
 "FiscalPeriodId",
 "AccountBudgetFactId",
 "AccountBudgetAttrId"
from dm_AccountBudgets_fact
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_ACCOUNTBUDGETS_FACT_TRANSFORM_ID}
union
select
	'0' as "AccountBudgetAmount",
	GoodData_Attr(a.AccountId)  as "AccountId",
	GoodData_Attr(FP.Id) as "FiscalPeriodId",
	GoodData_Attr(a.AccountId || '#' || FP.ID || '#<No budget>') as "AccountBudgetFactId",
	GoodData_Attr(a.AccountId || '#' || FP.ID || '#<No budget>') as "AccountBudgetAttrId" 
from stg_csv_account_merge a
cross join (select min(FiscalPeriodId) as "Id" from stg_csv_FiscalPeriod_merge  where TenantId = '${TenantId}') FP
where TenantId = '${TenantId}'
;