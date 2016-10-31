select
 "AccountUserSecurityId",
 "UserId",
 "AccountId"
from dm_AccountUserSecurity
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_ACCOUNTUSERSECURITY_TRANSFORM_ID}