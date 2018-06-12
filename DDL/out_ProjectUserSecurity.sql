drop TABLE if exists out_ProjectUserSecurity;
CREATE TABLE out_ProjectUserSecurity
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    ProjectUserSecurityId varchar(255),
    UserId varchar(255),
    ProjectId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);