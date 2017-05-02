select
 "CheckHistoryId",
 "CheckNumber",
 "VendorName",
 "FieldChanged",
 "FieldChangedTranslation",
 "OldValue",
 "NewValue",
 "DateChanged",
 "PostStatus",
 "BankId",
 "ChangedByUserName",
 GoodData_Attr('{"state":"treasury.transaction","id":'||DrillInId||'}') "CheckNumberHyperlink"
from dm_CheckHistory
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_CHECKHISTORY_TRANSFORM_ID}