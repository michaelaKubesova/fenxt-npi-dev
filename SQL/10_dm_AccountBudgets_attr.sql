INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_AccountBudgets_attr',now(),null);
insert /*+ direct */ into dm_AccountBudgets_attr
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
TenantId as "TenantId",
GoodData_Attr(AccountBudgetDetailId) as "AccountBudgetAttrId",
GoodData_Attr(ScenarioId) as "IncorrectScenarioId",
GoodData_Attr(ScenarioId) as "ScenarioId",
GoodData_Attr(AccountBudgetId) as "AccountBudgetId" 
from stg_csv_AccountBudgets_merge
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_AccountBudgets_attr',null,now());
select analyze_statistics('dm_AccountBudgets_attr')
;
