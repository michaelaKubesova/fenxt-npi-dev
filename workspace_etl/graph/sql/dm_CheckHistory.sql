select
 "CheckHistoryId",
 "CheckId",
 "FieldChanged",
 "FieldChangedTranslation",
 "OldValue",
 "NewValue",
 "DateChanged",
 "ChangedByUserName"
from dm_CheckHistory
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_CHECKHISTORY_TRANSFORM_ID}