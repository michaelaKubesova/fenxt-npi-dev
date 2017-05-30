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
