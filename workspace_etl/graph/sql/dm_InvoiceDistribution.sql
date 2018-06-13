select
 "InvoiceDistributionId",
 "AccountId",
 "InvoiceId",
 "ProjectId"
from dm_InvoiceDistribution
where TenantId = '${TenantId}'