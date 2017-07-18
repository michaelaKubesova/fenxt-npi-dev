
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
WHERE TenantId = '${TenantId}'
  AND _sys_updated_at > to_timestamptz('${transaction_attr_TS_FROM}', 'yyyy-mm-dd hh24:mi:ss.us')
  AND _sys_updated_at <= to_timestamptz('${transaction_attr_TS_TO}', 'yyyy-mm-dd hh24:mi:ss.us')