 create or replace view dm_CCTransaction as select 
_sys_transform_id,
TenantId,
CreditCardTransactionId,
YodleeAccountId,
TranType,
Status,
MerchantName,
CategoryName,
Comment,
Amount,
PostDate,
BankSubsidiaryCardsId,
InvoiceId
from out_CCTransaction 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_CCTransaction');