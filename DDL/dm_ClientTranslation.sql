 create or replace view dm_ClientTranslation as select 
_sys_transform_id,
TenantId,
TransactionCode1Name,
TransactionCode2Name,
TransactionCode3Name,
TransactionCode4Name,
TransactionCode5Name,
ProjectName,
FundName,
GrantName
from out_ClientTranslation 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ClientTranslation');
