select
 "BankSubsidiaryCardsId",
 "CardHolder",
 "Number",
 "BanksId"
from dm_BankSubsidiaryCards
where TenantId = '${TenantId}'
;