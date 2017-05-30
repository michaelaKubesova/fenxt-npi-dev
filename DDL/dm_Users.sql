 create or replace view dm_Users as select 
_sys_transform_id,
TenantId,
UserId,
IsSupervisor,
Name,
Description,
Inactive,
HasSupervisorRights,
ViewOnly
from out_Users 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Users');
