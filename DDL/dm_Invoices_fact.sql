 create or replace view dm_Invoices_fact as select 
_sys_transform_id,
TenantId,
InvoiceFactId,
VendorId,
FiscalPeriodId,
InvoiceAttrId,
InvoiceAmount,
InvoiceBalance,
InvoiceTaxAmount,
InvoiceDiscountAmount,
DateAdded,
DateChanged,
DueDate,
PostDate,
PostStatusId,
Date
from out_Invoices_fact 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Invoices_fact');
