INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionScenario',now(),null);
insert /*+ direct */ into dm_TransactionScenario
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
ab.TenantId as "TenantId",
	 GoodData_Attr(td.TranDistributionId||'#'||te.Description) as "TransactionScenarioId"
	,GoodData_Attr(td.TranDistributionId) as "TransactionDistributionId"
	,GoodData_Attr(te.Description) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_AccountBudget_merge ab
join stg_csv_AccountBudgetDetail_merge abd
	on ab.AccountBudgetId = abd.AccountBudgetId
join stg_csv_budgetscenario_merge bs
	on bs.BudgetScenarioId = ab.BudgetScenarioId and bs.TenantId = ab.TenantId
join stg_csv_tableentry_merge te
	on bs.ScenarioId = te.TableEntryId and te.CodeTableId = 124 and te.TenantId = ab.TenantId
join stg_csv_Transaction_merge t
	on t.AccountId = ab.AccountId and t.FiscalPeriodId = abd.FiscalPeriodId and t.TenantId = ab.TenantId
join stg_csv_TransactionDistribution_merge td
	on td.TransactionId = t.TransactionId and td.TenantId = ab.TenantId
group by te.Description, td.TranDistributionId, t.FiscalPeriodId, t.AccountId, ab.TenantId

union all

select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	ab.TenantId as "TenantId",
	 GoodData_Attr((1000000000000 + t.SummaryId)||'#'||te.Description) as "TransactionScenarioId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionDistributionId"
	,GoodData_Attr(te.Description) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_AccountBudget_merge ab
join stg_csv_AccountBudgetDetail_merge abd
	on ab.AccountBudgetId = abd.AccountBudgetId
join stg_csv_budgetscenario_merge bs
	on bs.BudgetScenarioId = ab.BudgetScenarioId and bs.TenantId = ab.TenantId
join stg_csv_tableentry_merge te
	on bs.ScenarioId = te.TableEntryId and te.CodeTableId = 124 and te.TenantId = ab.TenantId
join stg_csv_SummarizedTransaction_merge t
	on t.AccountId = ab.AccountId and t.FiscalPeriodId = abd.FiscalPeriodId and t.TenantId = ab.TenantId
group by te.Description, t.SummaryId, t.FiscalPeriodId, t.AccountId, ab.TenantId

union all

select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr((1000000000000 + t.SummaryId)||'#<No budget>') as "TransactionScenarioId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionDistributionId"
	,GoodData_Attr('<No budget>') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_SummarizedTransaction_merge t
group by t.SummaryId, t.FiscalPeriodId, t.AccountId, t.TenantId

union all

select 
     ${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
     t.TenantId as "TenantId",
	 GoodData_Attr(td.TranDistributionId||'#<No budget>') as "TransactionScenarioId"
	,GoodData_Attr(td.TranDistributionId) as "TransactionDistributionId"
	,GoodData_Attr('<No budget>') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_Transaction_merge t
join stg_csv_TransactionDistribution_merge td
	on td.TransactionId = t.TransactionId and td.TenantId = t.TenantId
group by td.TranDistributionId, t.FiscalPeriodId, t.AccountId, t.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionScenario',null,now());
select analyze_statistics('dm_TransactionScenario')
;