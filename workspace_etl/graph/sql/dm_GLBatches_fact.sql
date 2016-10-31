
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
and _sys_transform_id = ${DM_GLBATCHES_FACT_TRANSFORM_ID}