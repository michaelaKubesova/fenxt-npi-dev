
select
 "VendorHistoryId",
 "VendorId",
 "FieldChanged",
 "FieldChangedTranslation",
 "OldValue",
 "NewValue",
 "DateChanged",
 "ChangedByUserName"
from dm_VendorHistory
where TenantId = '${TenantId}'
