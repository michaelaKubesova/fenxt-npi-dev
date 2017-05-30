select
 "ScenarioId"
from dm_BudgetScenario
where TenantId = '${TenantId}'
union all
select
	GoodData_Attr('<No budget>') as "ScenarioId"
;