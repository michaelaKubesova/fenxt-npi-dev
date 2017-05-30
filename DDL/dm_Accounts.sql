 create or replace view dm_Accounts as select 
_sys_transform_id,
TenantId,
AccountId,
AccountNumber,
AccountDescription,
AccountCategory,
AccountCategoryTranslation,
FundDescription,
Class,
StatusTranslation,
AccountCodeDescription,
DateAdded,
DateChanged,
AddedByUserId,
AddedByUserName,
AddedByUserNameLabel,
ChangedByUserId,
ChangedByUserName,
ChangedByUserNameLabel,
AccountDateId,
Dummy
from out_Accounts 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Accounts');
