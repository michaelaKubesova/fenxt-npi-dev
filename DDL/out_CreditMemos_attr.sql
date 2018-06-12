drop table if exists out_CreditMemos_attr;
CREATE TABLE out_CreditMemos_attr
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    DateAdded varchar(255),
    DateChanged varchar(255),
    CreditMemoAttrId varchar(255),
    Date varchar(255),
    PostDate varchar(255),
    AddedByUserId varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ChangedByUserId varchar(255),
    ChangedByUserName varchar(255),
    ChangedByUserNameLabel varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);