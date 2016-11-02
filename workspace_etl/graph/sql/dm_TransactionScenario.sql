
select
 "TransactionScenarioId",
 "TransactionDistributionId",
 "ScenarioId",
 "FiscalPeriodId",
 "AccountId"
from dm_TransactionScenario
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TRANSACTIONSCENARIO_TRANSFORM_ID}
union all
select 
	 GoodData_Attr(td.TranDistributionId||'#<No budget>') as "TransactionScenarioId"
	,GoodData_Attr(td.TranDistributionId) as "TransactionDistributionId"
	,GoodData_Attr('<No budget>') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_Transaction_merge t
join stg_csv_TransactionDistribution_merge td
	on td.TransactionId = t.TransactionId and td.TenantId = t.TenantId
where  t.TenantId = '${TenantId}'
group by td.TranDistributionId, t.FiscalPeriodId, t.AccountId
;