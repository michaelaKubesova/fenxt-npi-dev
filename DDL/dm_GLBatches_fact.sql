 create or replace view dm_GLBatches_fact as select 
_sys_transform_id,
TenantId,
BatchFactId,
BatchId,
DebitAmount,
CreditAmount,
DateAdded,
DateChanged,
DateApproved,
DateDeleted
from out_GLBatches_fact 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_GLBatches_fact');
