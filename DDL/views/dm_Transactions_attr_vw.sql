create or replace view  dm_Transactions_attr 
as 
select 
TenantId,
PostStatusTranslation,
Gooddata_date(PostDate) PostDate,
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
Gooddata_date(DateAdded) DateAdded,
Gooddata_date(DateChanged) DateChanged,
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


CREATE or replace VIEW dm_Transactions_attr_delete 
AS
SELECT out_transactions_attr.TransactionAttrDistributionId,
        out_transactions_attr.TenantId,
		out_transactions_attr._sys_updated_at
 FROM out_transactions_attr WHERE (out_transactions_attr._sys_is_deleted = true);