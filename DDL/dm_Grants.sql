 create or replace view dm_Grants as select 
_sys_transform_id,
TenantId,
GrantId,
UserId,
GrantAmount,
DateAdded,
DateChanged,
AddedByUserId,
AddedByUserName,
AddedByUserNameLabel,
ChangedByUserId,
ChangedByUserName,
ChangedByUserNameLabel,
GrantDateId,
Dummy
from out_Grants 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Grants');
