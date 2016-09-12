
select
 "AccountHistoryId",
 "AccountId",
 "FieldChanged",
 "FieldChangedTranslation",
 "OldValue",
 "NewValue",
 "DateChanged",
 "ChangedByUserName"
from dm_AccountHistory
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_ACCOUNTHISTORY_TRANSFORM_ID}