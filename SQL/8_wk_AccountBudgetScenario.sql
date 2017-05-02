truncate table wk_AccountBudgetScenario;
insert /*+ direct*/ into wk_AccountBudgetScenario
select 
   ab.TenantId
  ,ab.AccountId
  ,ab.AccountBudgetId
  ,te.CodeTableId
  ,te.Description as "ScenarioId"
from stg_csv_AccountBudget_merge ab
join stg_csv_BudgetScenario_merge bs
	on ab.BudgetScenarioId = bs.BudgetScenarioId and ab.TenantId = bs.TenantId
join stg_csv_TableEntry_merge te
	on bs.ScenarioId = te.TableEntryId and ab.TenantId = te.TenantId
;
select analyze_statistics('wk_AccountBudgetScenario');