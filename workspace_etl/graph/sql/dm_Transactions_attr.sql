
select
 "PostStatusTranslation",
 "PostDate",
 "TransactionTypeTranslation",
 "EncumbranceStatusTranslation",
 "TransactionCode1",
 "TransactionCode2",
 "TransactionCode3",
 "TransactionCode4",
 "TransactionCode5",
 "DateAdded",
 "DateChanged",
 "TransactionAttrDistributionId",
 "TransactionId",
 "AddedByUserNameId",
 "AddedByUserName",
 "LastChangedByUserName",
 "Class"
from dm_Transactions_attr
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TRANSACTIONS_ATTR_TRANSFORM_ID}