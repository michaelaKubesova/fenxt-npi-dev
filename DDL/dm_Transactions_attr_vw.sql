create or replace view  dm_Transactions_attr 
as 
select 
TenantId,
PostStatusTranslation,
PostDate,
TransactionTypeTranslation,
EncumbranceStatusTranslation,
TransactionCode1,
TransactionCode1IsActive,
TransactionCode2,
TransactionCode2IsActive,
TransactionCode3,
TransactionCode3IsActive,
TransactionCode4,
TransactionCode4IsActive,
TransactionCode5,
TransactionCode5IsActive,
DateAdded,
DateChanged,
TransactionAttrDistributionId,
TransactionId,
AddedByUserNameId,
AddedByUserName,
LastChangedByUserName,
Class,
TransactionAttributeId,
IsBeginningBalance,
_sys_updated_at
from out_transactions_attr 
where _sys_is_deleted=false;