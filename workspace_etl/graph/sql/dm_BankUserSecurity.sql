
select
 "BankUserSecurityId",
 "UserId",
 "BankId"
from dm_BankUserSecurity
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_BANKUSERSECURITY_TRANSFORM_ID}