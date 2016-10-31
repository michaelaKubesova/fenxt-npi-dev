
select
 "AccountId",
 "AccountNumber",
 "AccountDescription",
 "AccountCategory",
 "AccountCategoryTranslation",
 "FundDescription",
 "Class",
 "StatusTranslation",
 "AccountCodeDescription",
 "DateAdded",
 "DateChanged",
 "AddedByUserId",
 "AddedByUserName",
 "AddedByUserNameLabel",
 "ChangedByUserId",
 "ChangedByUserName",
 "ChangedByUserNameLabel",
 "AccountDateId",
 "Dummy"
from dm_Accounts
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_ACCOUNTS_TRANSFORM_ID}