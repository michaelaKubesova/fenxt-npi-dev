
select
 "AccountId",
 "AccountNumber",
 GoodData_Attr('{"state":"ledger.account.detail","id":'||AccountId||'}') "AccountNumberHyperlink",
 AccountDescription "AccountNumberDescriptionLabel",
 AccountId as "AccountDescriptionId",
 AccountDescription as "AccountDescriptionLabel",
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
 "Dummy",
 AccountDescription as "AccountDescriptionUniqueLabel"
from dm_Accounts
where TenantId = '${TenantId}'