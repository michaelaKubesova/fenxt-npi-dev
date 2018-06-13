drop table if exists out_CCTransaction;
CREATE TABLE out_CCTransaction
(
   _sys_transform_id integer NOT NULL encoding rle,
   TenantId varchar(255) encoding rle,
   CreditCardTransactionId varchar(255),
   YodleeAccountId varchar(255),
   TranType varchar(255),
   Status varchar(255),
   SimpleDescription varchar(255),
   MerchantName varchar(255),
   CategoryName varchar(255),
   Comment varchar(255),
   Amount varchar(255),
   PostDate varchar(255),
   BankSubsidiaryCardsId varchar(255),
   InvoiceId varchar(255),
   DrillInId varchar(255)
) order by TenantId,
			_sys_transform_id
SEGMENTED BY hash(TenantId) ALL nodes
PARTITION BY (_sys_transform_id)
;
