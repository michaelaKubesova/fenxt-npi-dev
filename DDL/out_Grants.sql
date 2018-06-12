
drop TABLE if exists out_Grants;
CREATE TABLE out_Grants
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    GrantId varchar(255),
    UserId varchar(255),
	Description varchar(255),
	Type varchar(255),
	Status varchar(255),
	GrantAmount varchar(255),
    DateAdded varchar(255),
	StartDate varchar(255),
	EndDate varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);
