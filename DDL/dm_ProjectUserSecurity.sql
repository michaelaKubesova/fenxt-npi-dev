 create or replace view dm_ProjectUserSecurity as select 
_sys_transform_id,
TenantId,
ProjectUserSecurityId,
UserId,
ProjectId
from out_ProjectUserSecurity 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ProjectUserSecurity');
