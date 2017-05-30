
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
 "DataUpdated"

from dm_Tenants
where TenantId = '${TenantId}'
