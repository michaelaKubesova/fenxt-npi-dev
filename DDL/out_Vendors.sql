drop TABLE if exists out_Vendors;
CREATE TABLE out_Vendors
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    DateAdded varchar(255),
    DateChanged varchar(255),
    VendorId varchar(255),
    VendorName varchar(255),
    VendorUserID varchar(255),
    CustomerNumber varchar(255),
    StatusTranslation varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    VendorDateId varchar(255),
    Dummy varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);
