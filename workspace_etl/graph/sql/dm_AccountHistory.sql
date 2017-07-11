
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