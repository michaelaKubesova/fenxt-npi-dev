 create or replace view dm_Projects as select 
_sys_transform_id,
TenantId,
ProjectId,
UserId,
Description,
Division,
Location,
Department,
DateAdded,
DateChanged,
AddedByUserName,
AddedByUserNameLabel,
ProjectType,
ProjectDateId,
ProjectStatus,
Dummy
from out_Projects 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Projects');
