select
 "CreditCardTransactionId",
 "YodleeAccountId",
 "TranType",
 "Status",
 "MerchantName",
 "CategoryName",
 "Comment",
 "Amount",
 "PostDate",
 "BankSubsidiaryCardsId",
 "InvoiceId"
from dm_CCTransaction
where TenantId = '${TenantId}'
;