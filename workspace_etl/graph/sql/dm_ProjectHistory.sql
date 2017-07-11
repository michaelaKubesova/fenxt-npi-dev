
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
