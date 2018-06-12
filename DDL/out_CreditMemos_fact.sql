drop table if exists out_CreditMemos_fact;
CREATE TABLE out_CreditMemos_fact
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    CreditMemoFactId varchar(255),
    CreditMemoAttrId varchar(255),
    VendorId varchar(255),
    FiscalPeriodId varchar(255),
    CreditMemoAmount varchar(255),
    CreditMemoBalance varchar(255),
    PostDate varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    Date varchar(255),
    PostStatusId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);