 create or replace view dm_InvoiceDistribution as select 
_sys_transform_id,
TenantId,
InvoiceDistributionId,
InvoiceId,
AccountId,
ProjectId
from out_InvoiceDistribution 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_InvoiceDistribution');
