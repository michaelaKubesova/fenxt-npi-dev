
select
 "CreditMemoFactId",
 "CreditMemoAttrId",
 "VendorId",
 "FiscalPeriodId",
 "CreditMemoAmount",
 "CreditMemoBalance",
 "PostDate",
 "DateAdded",
 "DateChanged",
 "Date",
 "PostStatusId"
from dm_CreditMemos_fact
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_CREDITMEMOS_FACT_TRANSFORM_ID}