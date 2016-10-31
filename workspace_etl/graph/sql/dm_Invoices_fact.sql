select
 "InvoiceFactId",
 "VendorId",
 "FiscalPeriodId",
 "InvoiceAttrId",
 "InvoiceAmount",
 "InvoiceBalance",
 "InvoiceTaxAmount",
 "InvoiceDiscountAmount",
 "DateAdded",
 "DateChanged",
 "DueDate",
 "PostDate",
 "PostStatusId",
 "Date"
from dm_Invoices_fact
where TenantId = '${TenantId}'
and _sys_transform_id = '${DM_INVOICES_FACT_TRANSFORM_ID}'