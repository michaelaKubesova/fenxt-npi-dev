select
 "ScenarioId"
from dm_BudgetScenario
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_BUDGETSCENARIO_TRANSFORM_ID}
union all
select
	GoodData_Attr('<No budget>') as "ScenarioId"
;