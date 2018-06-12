 create or replace view dm_CreditMemos_attr as select 
_sys_transform_id,
TenantId,
DateAdded,
DateChanged,
CreditMemoAttrId,
Date,
PostDate,
AddedByUserId,
AddedByUserName,
AddedByUserNameLabel,
ChangedByUserId,
ChangedByUserName,
ChangedByUserNameLabel
from out_CreditMemos_attr 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_CreditMemos_attr');
