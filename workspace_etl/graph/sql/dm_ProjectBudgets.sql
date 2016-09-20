
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
union
select
	'0' as "PeriodAmount",
	GoodData_Attr(p.ProjectId || '#' || FP.Id || '#<No budget>') as "ProjectBudgetId",
	GoodData_Attr(null) as "AccountBudgetAttrId",
	GoodData_Attr(p.ProjectId)  as "ProjectId",
	GoodData_Attr(null)  as "AccountId",
	'0' as "ProjectBudgetAmount",
	GoodData_Attr(FP.Id)  as "FiscalPeriodId"
from stg_csv_project_merge p
cross join (select min(FiscalPeriodId) as "Id" from stg_csv_FiscalPeriod_merge  where TenantId = '${TenantId}') FP
where TenantId = '${TenantId}'