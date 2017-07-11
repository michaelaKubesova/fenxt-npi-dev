select
 "InvoiceId",
 "InvoiceNumber",
 InvoiceId as "DescriptionLabel",
 Description as "DescriptionLabel",
 "StatusTranslation",
 "AddedByUserName",
 "AddedByUserNameLabel",
 GoodData_Attr('{"state":"payables.invoice.detail","id":'||InvoiceId||'}') "InvoiceNumberHyperlink"
from dm_Invoices_attr
where TenantId = '${TenantId}'