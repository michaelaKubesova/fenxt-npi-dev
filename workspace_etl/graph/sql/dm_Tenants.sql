
select
 "TransactionCode1Name",
 "TransactionCode2Name",
 "TransactionCode3Name",
 "TransactionCode4Name",
 "TransactionCode5Name",
 "AccountSegment1Name",
 "ProjectName",
 "FundName",
 "GrantName",
 "DataUpdated"
from dm_Tenants
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TENANTS_TRANSFORM_ID}