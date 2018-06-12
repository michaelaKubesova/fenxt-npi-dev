drop TABLE if exists out_PostStatus;
CREATE TABLE out_PostStatus
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    PostStatusId varchar(255),
    PostStatus varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);