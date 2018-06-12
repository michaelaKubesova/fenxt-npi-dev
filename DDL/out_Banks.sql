drop table if exists out_Banks;
CREATE TABLE out_Banks
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    BankId varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    AddedByUserName varchar(255),
    AddedByUserNameLabel varchar(255),
    ChangedByUserNameLabel varchar(255),
    BankDateId varchar(255),
    Dummy varchar(255),
    IsReconciled varchar(255),
    DateLastReconciled varchar(255),
    LastReconciledByUserName varchar(255),
    LastReconciledByUserNameLabel varchar(255),
    ReconciledBalance varchar(255),
    Name varchar(255),
    AccountId varchar(255),
    Description varchar(255),
    AccountNumber varchar(255),
    RoutingNumber varchar(255),
    AccountType varchar(255),
    AccountTypeTranslation varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);