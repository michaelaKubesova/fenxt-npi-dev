select
 "TransactionDistributionId",
 "TransactionAttrDistributionId",
 "AccountId",
 "ProjectId",
 "GrantId",
 "FiscalPeriodId",
 "TransactionAmount",
 "BatchId",
 "DateAdded",
 "DateChanged"
from dm_Transactions_fact
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TRANSACTIONS_FACT_TRANSFORM_ID}