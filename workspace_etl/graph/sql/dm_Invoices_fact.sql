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