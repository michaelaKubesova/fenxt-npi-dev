select
 "InvoiceId",
 "InvoiceNumber",
 InvoiceId as "DescriptionLabel",
 Description as "DescriptionLabel",
 "StatusTranslation",
 "AddedByUserName",
 "AddedByUserNameLabel",
 "InvoiceAttributeId"
from dm_Invoices_attr
where TenantId = '${TenantId}'
and _sys_transform_id = '${DM_INVOICES_ATTR_TRANSFORM_ID}'