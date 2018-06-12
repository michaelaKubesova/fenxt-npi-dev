drop table if exists out_InvoiceDistribution;
CREATE TABLE out_InvoiceDistribution
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    InvoiceDistributionId varchar(255),
    InvoiceId varchar(255),
    AccountId varchar(255),
    ProjectId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);