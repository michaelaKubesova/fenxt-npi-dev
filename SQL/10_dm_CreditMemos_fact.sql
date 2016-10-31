INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CreditMemos_fact',now(),null);
insert /*+ direct */ into dm_CreditMemos_fact
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
TenantId as "TenantId",
GoodData_Attr(CreditMemoId) as "CreditMemoFactId",
 GoodData_Attr(CreditMemoId)  as "CreditMemoAttrId",
 GoodData_Attr(VendorId)  as "VendorId",
 GoodData_Attr(FiscalPeriodId)  as "FiscalPeriodId",
cast(Amount as decimal(15,2)) as "CreditMemoAmount",
cast(Balance as decimal(15,2)) as "CreditMemoBalance",
GoodData_Date(PostDate) as "PostDate",
GoodData_Date(DateAdded) as "DateAdded",
GoodData_Date(DateChanged) as "DateChanged",
GoodData_Date(Date) as "Date",
GoodData_Attr('cm-'||CreditMemoId) as "PostStatusId"
from stg_csv_CreditMemos_merge
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CreditMemos_fact',null,now());
select analyze_statistics('dm_CreditMemos_fact')
;
