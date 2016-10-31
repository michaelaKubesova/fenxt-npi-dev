
select
 "PostStatusId",
 "PostStatus"
from dm_PostStatus
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_POSTSTATUS_TRANSFORM_ID}