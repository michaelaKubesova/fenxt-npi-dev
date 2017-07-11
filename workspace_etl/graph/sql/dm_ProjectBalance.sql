
select
 "ProjectBalanceId",
 "FiscalPeriodId",
 "ProjectId",
 "Balance",
 "AddBalance",
 "EncumberanceType",
 "AccountId",
 "PostStatus"
from dm_ProjectBalance
where TenantId = '${TenantId}'
-- and (Balance is not null or AddBalance is not null)