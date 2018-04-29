INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CCTransaction',now(),null);
insert /*+ direct */ into out_CCTransaction
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
b.TenantId as "TenantId",
	 GoodData_Attr(b.CreditCardTransactionId) as "CreditCardTransactionId"
	,GoodData_Attr(b.YodleeAccountId)  as "YodleeAccountId"
	,GoodData_Attr(b.TranType)  as "TranType"
	,GoodData_Attr(b.Status) as "Status"
	,GoodData_Attr(b.SimpleDescription) as "SimpleDescription"
	,GoodData_Attr(b.MerchantName) as "MerchantName"
	,GoodData_Attr(b.CategoryName) as "CategoryName"
	,GoodData_Attr(b.Comment) as "Comment"
	,cast(b.Amount as decimal(15,2)) as "Amount"
	,GoodData_Date(b.PostDate) as "PostDate"
	,GoodData_Attr(bs.BankSubsidiaryCardsId) as "BankSubsidiaryCardsId"
	,GoodData_Attr(b.InvoiceId) as "InvoiceId"
from stg_csv_CCTransaction_merge b
join stg_csv_CCAccount_merge cca
	on b.YodleeAccountId = cca.YodleeAccountIdId and b.TenantId = cca.TenantId and cca._sys_is_deleted = false
join stg_csv_BankSubsidiaryCards_merge bs
	on cca.BankSubsidiaryCardsId = bs.BankSubsidiaryCardsId and cca.TenantId = bs.TenantId and bs._sys_is_deleted = false
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CCTransaction',null,now());
select analyze_statistics('out_CCTransaction')
;

