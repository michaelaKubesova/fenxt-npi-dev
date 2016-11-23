select
 "AccountBudgetAttrId",
 "ScenarioId",
 "AccountBudgetId"
from dm_AccountBudgets_attr
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_ACCOUNTBUDGETS_ATTR_TRANSFORM_ID}
union all
select   GoodData_Attr('0') as "AccountBudgetAttrId",
GoodData_Attr('<No budget>') as "ScenarioId",
GoodData_Attr('0') as "AccountBudgetId"
;	