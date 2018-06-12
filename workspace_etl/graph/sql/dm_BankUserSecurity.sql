
select
 "BankUserSecurityId",
 "UserId",
 "BankId"
from dm_BankUserSecurity
where TenantId = '${TenantId}'