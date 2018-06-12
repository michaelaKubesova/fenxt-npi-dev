drop TABLE if exists out_BankUserSecurity;
CREATE TABLE out_BankUserSecurity
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    BankUserSecurityId varchar(255),
    UserId varchar(255),
    BankId varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);