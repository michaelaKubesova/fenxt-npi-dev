
select
 "PostStatusTranslation",
 "PostDate",
 "TransactionTypeTranslation",
 "EncumbranceStatusTranslation",
 "TransactionCode1",
 "TransactionCode1IsActive",
 "TransactionCode2",
 "TransactionCode2IsActive",
 "TransactionCode3",
 "TransactionCode3IsActive",
 "TransactionCode4",
 "TransactionCode4IsActive",
 "TransactionCode5",
 "TransactionCode5IsActive",
 "DateAdded",
 "DateChanged",
 "TransactionAttrDistributionId",
 "TransactionId",
 "AddedByUserNameId",
 "AddedByUserName",
 "LastChangedByUserName",
 "Class",
 "TransactionAttributeId",
 "IsBeginningBalance"
from dm_Transactions_attr
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_TRANSACTIONS_ATTR_TRANSFORM_ID}