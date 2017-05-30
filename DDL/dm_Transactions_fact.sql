 create or replace view dm_Transactions_fact as select 
_sys_transform_id,
TenantId,
TransactionDistributionId,
TransactionAttrDistributionId,
AccountId,
ProjectId,
GrantId,
FiscalPeriodId,
TransactionAmount,
BatchId,
DateAdded,
DateChanged
from out_Transactions_fact 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Transactions_fact');
