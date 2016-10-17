
select
 "TenantId",
 "Tenant",
 "TransactionCode1Name",
 "TransactionCode2Name",
 "TransactionCode3Name",
 "TransactionCode4Name",
 "TransactionCode5Name",
 "ProjectName",
 "FundName",
 "GrantName",
 "DataUpdated",
 ' ' as "AccountSegment1Name"
from dm_Tenants
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TENANTS_TRANSFORM_ID}