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
WHERE TenantId = '${TenantId}'
  AND _sys_updated_at > to_timestamptz('${transaction_attr_TS_FROM}', 'yyyy-mm-dd hh24:mi:ss.us')
  AND _sys_updated_at <= to_timestamptz('${transaction_attr_TS_TO}', 'yyyy-mm-dd hh24:mi:ss.us')
