drop table if exists out_Users;
CREATE TABLE out_Users
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    UserId varchar(255),
	IsSupervisor varchar(255),
	Name varchar(255),
	Description varchar(255),
	Inactive varchar(255),
	HasSupervisorRights varchar(255),
	ViewOnly varchar(255)
)
 ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);