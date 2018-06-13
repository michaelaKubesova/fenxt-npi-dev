drop table if exists out_BankSubsidiaryCards;
CREATE TABLE out_BankSubsidiaryCards
(
   _sys_transform_id integer NOT NULL encoding rle,
   TenantId varchar(255) encoding rle,
   BankSubsidiaryCardsId varchar(255),
   CardHolder varchar(255),
   Number varchar(255),
   BanksId varchar(255),
   DrillInId varchar(255)
) order by TenantId,
			_sys_transform_id
SEGMENTED BY hash(TenantId) ALL nodes
PARTITION BY (_sys_transform_id)
;