
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
and _sys_transform_id = ${DM_VENDORHISTORY_TRANSFORM_ID}