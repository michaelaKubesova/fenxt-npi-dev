CREATE TABLE wrk_tmp_tableentry
(
    TenantId varchar(255) encoding rle,
    TableEntryId int,
    IsActive boolean,
    Description varchar(255),
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
) ORDER BY TenantId,TableEntryId,_sys_hash,_sys_is_deleted
SEGMENTED BY hash(TenantId,TableEntryId) ALL NODES;


CREATE TABLE wrk_tmp_tableentry_diff
(   TenantId varchar(255) encoding rle,
    TableEntryId int,
    IsActive boolean,
    Description varchar(255),
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
) ORDER BY TenantId,TableEntryId,_sys_hash,_sys_is_deleted
SEGMENTED BY hash(TenantId,TableEntryId) ALL NODES;


CREATE TABLE tmp_tableentry
(   TenantId varchar(255) encoding rle,
    TableEntryId int,
    IsActive boolean,
    Description varchar(255),
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
) ORDER BY TenantId,TableEntryId,_sys_hash,_sys_is_deleted
SEGMENTED BY hash(TenantId,TableEntryId) ALL NODES;