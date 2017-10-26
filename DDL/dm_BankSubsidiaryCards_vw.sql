 create or replace view dm_BankSubsidiaryCards as select 
_sys_transform_id,
TenantId,
BankSubsidiaryCardsId,
CardHolder,
Number,
BanksId
from out_BankSubsidiaryCards 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_BankSubsidiaryCards');