
select
 "ProjectBalanceId",
 "FiscalPeriodId",
 "ProjectId",
 "Balance",
 "AddBalance",
 "EncumberanceType",
 "AccountId",
 "PostStatus"
from stg_csv_ProjectBalance_merge
where TenantId = '${TenantId}'-- and (Balance is not null or AddBalance is not null)