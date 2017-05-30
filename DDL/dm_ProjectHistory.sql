 create or replace view dm_ProjectHistory as select 
_sys_transform_id,
TenantId,
ProjectHistoryId,
ProjectId,
FieldChanged,
FieldChangedTranslation,
OldValue,
NewValue,
DateChanged,
ChangedByUserName
from out_ProjectHistory 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ProjectHistory');
