
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
and _sys_transform_id = ${DM_PROJECTS_TRANSFORM_ID}-- and (Balance is not null or AddBalance is not null)