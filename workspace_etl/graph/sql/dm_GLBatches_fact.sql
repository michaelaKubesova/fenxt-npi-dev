
select
 "BatchFactId",
 "BatchId",
 "DebitAmount",
 "CreditAmount",
 "DateAdded",
 "DateChanged",
 "DateApproved",
 "DateDeleted"
from dm_GLBatches_fact
where TenantId = '${TenantId}'
