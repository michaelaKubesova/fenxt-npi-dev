CREATE TABLE wrk_tmp_user
(
    TenantId varchar(255) ENCODING RLE,
    userId int,
    name varchar(255),
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
) ORDER BY TenantId,
          userId,
          _sys_hash,
          _sys_is_deleted
SEGMENTED BY hash(TenantId, userId) ALL NODES;


CREATE TABLE wrk_tmp_user_diff
(
    TenantId varchar(255) ENCODING RLE,
    userId int,
    name varchar(255),
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
) ORDER BY TenantId,
          userId,
          _sys_hash,
          _sys_is_deleted
SEGMENTED BY hash(TenantId, userId) ALL NODES;


CREATE TABLE tmp_user
(
    TenantId varchar(255) ENCODING RLE,
    userId int,
    name varchar(255),
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
) ORDER BY TenantId,
          userId,
          _sys_hash,
          _sys_is_deleted
SEGMENTED BY hash(TenantId, userId) ALL NODES;

ALTER TABLE tmp_user ADD CONSTRAINT tmp_user_PK PRIMARY KEY (TenantId, UserId);