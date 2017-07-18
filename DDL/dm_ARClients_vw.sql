 create or replace view dm_ARClients as select 
_sys_transform_id,
TenantId,
ARClientId,
ARClientType,
ARClientDisplayName,
ARClientCFDANumber,
AddedByUserId,
GoodData_Date(dateadded) as dateadded,
GoodData_Date(datechanged) as datechanged,
Amount
from out_ARClients 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ARClients');
