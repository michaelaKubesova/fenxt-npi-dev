INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionScenario',now(),null);
insert /*+ direct */ into out_TransactionScenario
select 
     ${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id
    ,t.TenantId as "TenantId"
	,GoodData_Attr(t.TranDistributionId||'#'||abs.ScenarioId) as "TransactionScenarioId"
	,GoodData_Attr(t.TranDistributionId) as "TransactionDistributionId"
	,GoodData_Attr(abs.ScenarioId) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from (select ScenarioId,TenantId,AccountId from wk_AccountBudgetScenario where CodeTableId = 124 group by ScenarioId,TenantId,AccountId) abs
join out_transactions t
	on t.AccountId = abs.AccountId and t.TenantId = abs.TenantId --and abs.CodeTableId = 124
where t._sys_is_deleted = false
--group by abs.ScenarioId, t.TranDistributionId, t.FiscalPeriodId, t.AccountId, t.TenantId
;
insert /*+ direct */ into out_TransactionScenario
select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id
	,t.TenantId as "TenantId"
	,GoodData_Attr((1000000000000 + t.SummaryId)||'#'||abs.ScenarioId) as "TransactionScenarioId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionDistributionId"
	,GoodData_Attr(abs.ScenarioId) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from (select ScenarioId,TenantId,AccountId from wk_AccountBudgetScenario where CodeTableId = 124 group by ScenarioId,TenantId,AccountId) abs
join stg_csv_SummarizedTransaction_merge t
	on t.AccountId = abs.AccountId and t.TenantId = abs.TenantId --and  abs.CodeTableId = 124
--group by abs.ScenarioId, t.SummaryId, t.FiscalPeriodId, t.AccountId, t.TenantId
;
insert /*+ direct */ into out_TransactionScenario
select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id
	,t.TenantId as "TenantId"
	,GoodData_Attr((1000000000000 + t.SummaryId)||'#<No budget>') as "TransactionScenarioId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionDistributionId"
	,GoodData_Attr('<No budget>') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_SummarizedTransaction_merge t
--group by t.SummaryId, t.FiscalPeriodId, t.AccountId, t.TenantId
;
insert /*+ direct */ into out_TransactionScenario
select 
     ${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
     t.TenantId as "TenantId",
	 GoodData_Attr(t.TranDistributionId||'#<No budget>') as "TransactionScenarioId"
	,GoodData_Attr(t.TranDistributionId) as "TransactionDistributionId"
	,GoodData_Attr('<No budget>') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from out_transactions t
where t._sys_is_deleted = false
--group by t.TranDistributionId, t.FiscalPeriodId, t.AccountId, t.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionScenario',null,now());
select analyze_statistics('out_TransactionScenario')
;