
select
 "TransactionScenarioId",
 "TransactionDistributionId",
 "ScenarioId",
 "FiscalPeriodId",
 "AccountId"
from dm_TransactionScenario
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TRANSACTIONSCENARIO_TRANSFORM_ID}
union
select
GoodData_Attr(t.TransactionDistributionId||'#<No budget>') as "TransactionScenarioId",
GoodData_Attr(t.TransactionDistributionId) as "TransactionDistributionId",
GoodData_Attr('<No budget>') as "ScenarioId",
GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId",
GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_Transactions_merge t
where TenantId = '${TenantId}'
group by TransactionDistributionId, t.FiscalPeriodId, t.AccountId
;