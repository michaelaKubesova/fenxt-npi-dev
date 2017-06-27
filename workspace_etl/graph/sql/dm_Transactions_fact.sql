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
 "DateChanged",
 0 as "NaturalBalance",
 0 as "BalanceSheet"
from dm_Transactions_fact
where TenantId = '${TenantId}'
