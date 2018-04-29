select
 "InvoiceId",
 "InvoiceNumber",
 InvoiceId as "DescriptionLabel",
 Description as "DescriptionLabel",
 "StatusTranslation",
 "AddedByUserName",
 "AddedByUserNameLabel",
 "InvoiceHyperlink",
 "InvoicePaymentMethod"
from dm_Invoices_attr
where TenantId = '${TenantId}'