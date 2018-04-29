INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BankSubsidiaryCards',now(),null);
insert /*+ direct */ into out_BankSubsidiaryCards
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
b.TenantId as "TenantId",
	 GoodData_Attr(b.BankSubsidiaryCardsId) as BankSubsidiaryCardsId
	,GoodData_Attr(b.CardHolder)  as CardHolder
	,GoodData_Attr(b.Number)  as Number
	,GoodData_Attr(b.BanksId) as BanksId
from stg_csv_BankSubsidiaryCards_merge b
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BankSubsidiaryCards',null,now());
select analyze_statistics('out_BankSubsidiaryCards')
;