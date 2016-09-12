select
 "InvoiceDistributionId",
 "AccountId",
 "InvoiceId",
 "ProjectId"
from dm_InvoiceDistribution
where TenantId = '${TenantId}'
and _sys_transform_id = '${DM_INVOICES_FACT_TRANSFORM_ID}'