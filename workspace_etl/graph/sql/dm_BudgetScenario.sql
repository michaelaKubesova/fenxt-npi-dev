select
 "ScenarioId",
 "ScenarioDesc"
from dm_BudgetScenario
where TenantId = '${TenantId}'
union all
select
	GoodData_Attr('<No budget>') as "ScenarioId",
	GoodData_Attr('<No budget>') as "ScenarioDesc"	                      
;