
select
 "BankReconciliationId",
 "BankId",
 "ReconciliationDate",
 "ReconciliationBalance",
 "AddedByUserId",
 "AddedByUserName"
from dm_BankReconciliationHistory
where TenantId = '${TenantId}'