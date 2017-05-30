 create or replace view dm_PostStatus as select 
_sys_transform_id,
TenantId,
PostStatusId,
PostStatus
from out_PostStatus 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_PostStatus');
