INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionScenario',now(),null);
insert /*+ direct */ into out_TransactionScenario
select 
     ${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id
    ,t.TenantId as "TenantId"
	,null--GoodData_Attr(t.TranDistributionId||'#'||isnull(abs.ScenarioId, '<No budget>')) as "TransactionScenarioId"
	,GoodData_Attr(t.TranDistributionId) as "TransactionDistributionId"
	,GoodData_Attr(isnull(abs.ScenarioId, '<No budget>')) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
 from out_transactions T 
left join tmp_transaction_scenario abs
on  T.AccountId = abs.AccountId 
   and abs.FiscalPeriodId = T.FiscalPeriodId
   and abs.tenantid = t.tenantid
   and abs._sys_is_deleted = false
where t._sys_is_deleted = false
;

insert /*+ direct */ into out_TransactionScenario
select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id
	,t.TenantId as "TenantId"
	,null--GoodData_Attr(1000000000000 + t.SummaryId||'#'||isnull(abs.ScenarioId, '<No budget>')) as "TransactionScenarioId"
	,GoodData_Attr(1000000000000 + t.SummaryId) as "TransactionDistributionId"
	,GoodData_Attr(isnull(abs.ScenarioId, '<No budget>')) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_SummarizedTransaction_merge t	
left join tmp_transaction_scenario abs
on  T.AccountId = abs.AccountId 
   and abs.FiscalPeriodId = T.FiscalPeriodId
   and abs.tenantid = t.tenantid
   and abs._sys_is_deleted = false
where t._sys_is_deleted = false
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionScenario',null,now());
select analyze_statistics('out_TransactionScenario')
;