drop table if exists out_Invoices_attr;
CREATE TABLE out_Invoices_attr
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    InvoiceId varchar(255),
    InvoiceNumber varchar(255),
    Description varchar(255),
    StatusTranslation varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    InvoiceHyperlink varchar(255),
	InvoicePaymentMethod varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);