
select
 "TransactionScenarioId",
 "ProjectId",
 "TransactionAttrDistributionId",
 "ScenarioId",
 "FiscalPeriodId",
 "AccountId"
from dm_TransactionProjectScenario
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TRANSACTIONPROJECTSCENARIO_TRANSFORM_ID}

union all

select 
	 GoodData_Attr(td.TranDistributionId||'#<No budget>') as "TransactionScenarioId"
	,GoodData_Attr(NVL(td.ProjectId,-1)) as "ProjectId"
	,GoodData_Attr(td.TranDistributionId) as "TransactionAttrDistributionId"
	,GoodData_Attr('<No budget>') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_Transaction_merge t
join stg_csv_TransactionDistribution_merge td
	on td.TransactionId = t.TransactionId and td.TenantId = t.TenantId  and td._sys_is_deleted = false and td.Deleted = false
where t.Deleted = false
	and t._sys_is_deleted = false
	and t.TenantId = '${TenantId}'
