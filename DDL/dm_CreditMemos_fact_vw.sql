 create or replace view dm_CreditMemos_fact as select 
_sys_transform_id,
TenantId,
CreditMemoFactId,
CreditMemoAttrId,
VendorId,
FiscalPeriodId,
CreditMemoAmount,
CreditMemoBalance,
PostDate,
DateAdded,
DateChanged,
Date,
PostStatusId
from out_CreditMemos_fact 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_CreditMemos_fact');
