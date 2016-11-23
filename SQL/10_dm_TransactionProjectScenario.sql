INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionProjectScenario',now(),null);
insert /*+ direct */ into dm_TransactionProjectScenario
	select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr(td.TranDistributionId||'#'||pb.ScenarioId) as "TransactionScenarioId"
	,GoodData_Attr(pb.ProjectId) as "ProjectId"
	,GoodData_Attr(td.TranDistributionId) as "TransactionAttrDistributionId"
	,GoodData_Attr(pb.scenarioid) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_transaction_merge t
join stg_csv_TransactionDistribution_merge td
	on td.TransactionId = t.TransactionId and td.TenantId = t.TenantId
join (
	select pb.TenantId, pb.projectid, ab.AccountId, te.Description as "scenarioid", abd.FiscalPeriodId
	from stg_csv_AccountBudget_merge ab
	join stg_csv_AccountBudgetDetail_merge abd
		on abd.AccountBudgetId = ab.AccountBudgetId and abd.TenantId = ab.TenantId
	join stg_csv_budgetscenario_merge bs
		on bs.BudgetScenarioId = ab.BudgetScenarioId and bs.TenantId = ab.TenantId
	join stg_csv_tableentry_merge te
		on bs.ScenarioId = te.TableEntryId and te.CodeTableId = 124 and te.TenantId = ab.TenantId
	join stg_csv_ProjectBudget_merge pb
		on pb.AccountBudgetId = ab.AccountBudgetId and pb.TenantId = ab.TenantId
	join stg_csv_ProjectBudgetDetail_merge pbd
		on pbd.ProjectBudgetId = pb.ProjectBudgetId and pbd.TenantId = ab.TenantId
	where pbd.FiscalPeriodId = abd.FiscalPeriodId
	group by pb.projectid, ab.AccountId, te.Description, abd.FiscalPeriodId, pb.TenantId) pb on pb.projectid = td.projectid and pb.AccountId = t.AccountId and pb.TenantId = t.TenantId
where t.FiscalPeriodId = pb.FiscalPeriodId

union all

select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr((1000000000000 + t.SummaryId)||'#'||pb.ScenarioId) as "TransactionScenarioId"
	,GoodData_Attr(pb.ProjectId) as "ProjectId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionAttrDistributionId"
	,GoodData_Attr(pb.scenarioid) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from  stg_csv_SummarizedTransaction_merge t
join (
	select pb.TenantId, pb.projectid, ab.AccountId, te.Description as "scenarioid", abd.FiscalPeriodId
	from stg_csv_AccountBudget_merge ab
	join stg_csv_AccountBudgetDetail_merge abd
		on abd.AccountBudgetId = ab.AccountBudgetId and abd.TenantId = ab.TenantId 
	join stg_csv_budgetscenario_merge bs
		on bs.BudgetScenarioId = ab.BudgetScenarioId and bs.TenantId = ab.TenantId 
	join stg_csv_tableentry_merge te
		on bs.ScenarioId = te.TableEntryId and te.CodeTableId = 124 and te.TenantId = ab.TenantId 
	join stg_csv_ProjectBudget_merge pb
		on pb.AccountBudgetId = ab.AccountBudgetId and pb.TenantId = ab.TenantId
	join stg_csv_ProjectBudgetDetail_merge pbd
		on pbd.ProjectBudgetId = pb.ProjectBudgetId and pbd.TenantId = ab.TenantId
	where  pbd.FiscalPeriodId = abd.FiscalPeriodId
	group by pb.projectid, ab.AccountId, te.Description, abd.FiscalPeriodId, pb.TenantId) pb on pb.projectid = t.projectid and pb.AccountId = t.AccountId and pb.TenantId = t.TenantId


union all

select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr((1000000000000 + t.SummaryId)||'#<No budget>') as "TransactionScenarioId"
	,GoodData_Attr(NVL(t.ProjectId,-1)) as "ProjectId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionAttrDistributionId"
	,GoodData_Attr('<No budget>') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from  stg_csv_SummarizedTransaction_merge t

union all

select 
     ${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
     t.TenantId as "TenantId",
	 GoodData_Attr(td.TranDistributionId||'#<No budget>') as "TransactionScenarioId"
	,GoodData_Attr(NVL(td.ProjectId,-1)) as "ProjectId"
	,GoodData_Attr(td.TranDistributionId) as "TransactionAttrDistributionId"
	,GoodData_Attr('<No budget>') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_Transaction_merge t
join stg_csv_TransactionDistribution_merge td
	on td.TransactionId = t.TransactionId and td.TenantId = t.TenantId

;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionProjectScenario',null,now());
select analyze_statistics('dm_TransactionProjectScenario')
;