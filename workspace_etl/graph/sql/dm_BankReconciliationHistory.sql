
select
 "BankReconciliationId",
 "BankId",
 "ReconciliationDate",
 "ReconciliationBalance",
 "AddedByUserId",
 "AddedByUserName"
from dm_BankReconciliationHistory
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_BANKRECONCILIATIONHISTORY_TRANSFORM_ID}