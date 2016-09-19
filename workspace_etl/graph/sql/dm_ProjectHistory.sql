
select
 "ProjectHistoryId",
 "ProjectId",
 "FieldChanged",
 "FieldChangedTranslation",
 "OldValue",
 "NewValue",
 "DateChanged",
 "ChangedByUserName"
from dm_ProjectHistory
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_PROJECTHISTORY_TRANSFORM_ID}