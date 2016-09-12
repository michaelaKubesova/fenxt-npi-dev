INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BudgetScenario',now(),null);
insert /*+ direct */ into dm_BudgetScenario
select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	TenantId as "TenantId",
	GoodData_Attr(ScenarioId) as "ScenarioId"
from stg_csv_AccountBudgets_merge ab
group by scenarioId, TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BudgetScenario',null,now());
select analyze_statistics('dm_BudgetScenario')
;