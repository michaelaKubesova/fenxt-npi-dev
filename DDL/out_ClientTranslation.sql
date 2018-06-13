drop TABLE if exists out_ClientTranslation;
CREATE TABLE out_ClientTranslation
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    TransactionCode1Name varchar(255),
    TransactionCode2Name varchar(255),
    TransactionCode3Name varchar(255),
    TransactionCode4Name varchar(255),
    TransactionCode5Name varchar(255),
    ProjectName varchar(255),
    FundName varchar(255),
    GrantName varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);