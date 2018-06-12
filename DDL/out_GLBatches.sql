drop table if exists out_GLBatches;
CREATE TABLE out_GLBatches
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    DateAdded varchar(255),
    DateChanged varchar(255),
    DateDeleted varchar(255),
    DateApproved varchar(255),
    BatchId varchar(255),
    BatchNumber varchar(255),
    StatusTranslation varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ChangedByUserNameLabel varchar(255),
    DeletedByNameLabel varchar(255),
    ApprovedByUserNameLabel varchar(255),
    BatchDateId varchar(255),
    BatchHyperlink varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);