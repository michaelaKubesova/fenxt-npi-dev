
select
 "AccountBudgetAttrId",
 "ScenarioId",
 "AccountBudgetId"
from dm_AccountBudgets_attr
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_ACCOUNTBUDGETS_ATTR_TRANSFORM_ID}
union
select
	GoodData_Attr(a.AccountId || '#' || FP.ID || '#<No budget>') as "AccountBudgetAttrId" ,
	GoodData_Attr('<No budget>') as "ScenarioId" ,
	GoodData_Attr(a.AccountId || '#' || FP.ID || '#<No budget>') as "AccountBudgetId"
from stg_csv_accounts_merge a
cross join (select min(FiscalPeriodId) as "Id" from stg_csv_FiscalPeriods_merge where TenantId = '${TenantId}') FP
where TenantId = '${TenantId}'
union
select   GoodData_Attr('0') as "AccountBudgetAttrId",
GoodData_Attr('<No budget>') as "ScenarioId",
GoodData_Attr('0') as "AccountBudgetId"
;	