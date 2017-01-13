
select
 "AccountId",
 "AccountNumber",
 GoodData_Attr('{"state":"ledger.account.detail","id":'||AccountId||'}') "AccountNumberHyperlink",
 AccountDescription "AccountNumberDescriptionLabel",
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
 "AccountSegment1",
 "AccountSegment2",
 "AccountSegment3",
 "AccountSegment4",
 "AccountSegment5",
 "AccountSegment6",
 "AccountSegment7",
 "AccountSegment8",
 "Dummy"
from dm_Accounts
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_ACCOUNTS_TRANSFORM_ID}