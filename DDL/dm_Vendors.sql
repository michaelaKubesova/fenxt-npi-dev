 create or replace view dm_Vendors as select 
_sys_transform_id,
TenantId,
DateAdded,
DateChanged,
VendorId,
VendorName,
VendorUserID,
CustomerNumber,
StatusTranslation,
AddedByUserName,
AddedByUserNameLabel,
VendorDateId,
Dummy
from out_Vendors 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Vendors');