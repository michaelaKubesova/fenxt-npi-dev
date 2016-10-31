
select
 "AccountId",
 "AccountNumber",
 GoodData_Attr('{"state":"ledger.account.detail","id":'||AccountId||'}') "AccountNumberHyperlink",
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