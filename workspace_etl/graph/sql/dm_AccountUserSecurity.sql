select
 "AccountUserSecurityId",
 "UserId",
 "AccountId"
from dm_AccountUserSecurity
where TenantId = '${TenantId}'
