 create or replace view dm_Tenants as select 
_sys_transform_id,
TenantId,
Tenant,
TransactionCode1Name,
TransactionCode2Name,
TransactionCode3Name,
TransactionCode4Name,
TransactionCode5Name,
ProjectName,
FundName,
GrantName,
DataUpdated,
AccountSegment1Name,
AccountSegment2Name,
AccountSegment3Name,
AccountSegment4Name,
AccountSegment5Name,
AccountSegment6Name,
AccountSegment7Name,
AccountSegment8Name
from out_Tenants 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants');
