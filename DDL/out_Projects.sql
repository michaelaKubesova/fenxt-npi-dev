drop table if exists out_Projects;
CREATE TABLE out_Projects
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    ProjectId varchar(255),
    UserId varchar(255),
    Description varchar(255),
    Division varchar(255),
    Location varchar(255),
    Department varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ProjectType varchar(255),
    ProjectDateId varchar(255),
    ProjectStatus varchar(255),
    Dummy varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);