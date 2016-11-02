INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_AccountBudgets_attr',now(),null);

insert /*+ direct */ into dm_AccountBudgets_attr
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
abd.TenantId as "TenantId",
	 GoodData_Attr(abd.AccountBudgetDetailId) as "AccountBudgetAttrId"
	,GoodData_Attr(te.Description) as "IncorrectScenarioId"
	,GoodData_Attr(te.Description) as "ScenarioId"
	,GoodData_Attr(ab.AccountBudgetId) as "AccountBudgetId" 
from stg_csv_accountbudgetdetail_merge abd
join stg_csv_accountbudget_merge ab
	on abd.AccountBudgetId = ab.AccountBudgetId and abd.TenantId = ab.TenantId
join stg_csv_budgetscenario_merge bs
	on bs.BudgetScenarioId = ab.BudgetScenarioId and bs.TenantId = abd.TenantId
join stg_csv_tableentry_merge te
	on bs.ScenarioId = te.TableEntryId and te.CodeTableId = 124 and te.TenantId = abd.TenantId
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_AccountBudgets_attr',null,now());
select analyze_statistics('dm_AccountBudgets_attr')
;
