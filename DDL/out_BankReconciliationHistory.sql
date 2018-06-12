drop table if exists out_BankReconciliationHistory;
CREATE TABLE out_BankReconciliationHistory
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    BankReconciliationId varchar(255),
    BankId varchar(255),
    ReconciliationDate varchar(255),
    ReconciliationBalance varchar(255),
    AddedByUserId varchar(255),
    AddedByUserName varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);