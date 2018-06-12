 create or replace view dm_CheckHistory as select 
_sys_transform_id,
TenantId,
CheckHistoryId,
CheckNumber,
VendorName,
FieldChanged,
FieldChangedTranslation,
OldValue,
NewValue,
DateChanged,
PostStatus,
BankId,
ChangedByUserName,
DrillInId
from out_CheckHistory 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_CheckHistory');
