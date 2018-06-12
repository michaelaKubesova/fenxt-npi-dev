 create or replace view dm_VendorHistory as select 
_sys_transform_id,
TenantId,
VendorHistoryId,
VendorId,
FieldChanged,
FieldChangedTranslation,
OldValue,
NewValue,
DateChanged,
ChangedByUserName
from out_VendorHistory 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_VendorHistory');
