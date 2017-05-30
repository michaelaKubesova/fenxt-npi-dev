 create or replace view dm_GLBatches as select 
_sys_transform_id,
TenantId,
DateAdded,
DateChanged,
DateDeleted,
DateApproved,
BatchId,
BatchNumber,
StatusTranslation,
AddedByUserName,
AddedByUserNameLabel,
ChangedByUserNameLabel,
DeletedByNameLabel,
ApprovedByUserNameLabel,
BatchDateId,
BatchHyperlink
from out_GLBatches 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_GLBatches');
