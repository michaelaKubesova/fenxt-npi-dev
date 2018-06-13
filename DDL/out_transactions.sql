
CREATE TABLE wrk_Transactions
(
    TenantId varchar(255) encoding rle,
    TransactionTypeTranslation varchar(255),
    EncumbranceStatusTranslation varchar(255),
    AddedById int,
    DateAdded date,
    LastChangedById int,
    DateChanged date,
    BatchId int,
    PostStatusTranslation varchar(255),
    AccountId int,
    PostDate date,
    FiscalPeriodId int,
    GrantId int,
    TranDistributionId int,
    TransactionId int,
    Projectid int,
    ClassId int,
    TDAmount numeric(37,15),
    TransactionCode1Id int,
    TransactionCode2Id int,
    TransactionCode3Id int,
    TransactionCode4Id int,
    TransactionCode5Id int,
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
)  ORDER BY TenantId,
          TranDistributionId,
          _sys_hash,
          _sys_is_deleted
SEGMENTED BY hash(TenantId, TranDistributionId) ALL NODES;


CREATE TABLE wrk_Transactions_diff
(
    TenantId varchar(255),
    TransactionTypeTranslation varchar(255),
    EncumbranceStatusTranslation varchar(255),
    AddedById int,
    DateAdded date,
    LastChangedById int,
    DateChanged date,
    BatchId int,
    PostStatusTranslation varchar(255),
    AccountId int,
    PostDate date,
    FiscalPeriodId int,
    GrantId int,
    TranDistributionId int,
    TransactionId int,
    Projectid int,
    ClassId int,
    TDAmount numeric(37,15),
    TransactionCode1Id int,
    TransactionCode2Id int,
    TransactionCode3Id int,
    TransactionCode4Id int,
    TransactionCode5Id int,
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
) ORDER BY TenantId,
          TranDistributionId,
          _sys_hash,
          _sys_is_deleted
SEGMENTED BY hash(TenantId, TranDistributionId) ALL NODES;


CREATE TABLE out_transactions
(
    TenantId varchar(255) NOT NULL encoding rle,
    TransactionTypeTranslation varchar(255),
    EncumbranceStatusTranslation varchar(255),
    AddedById int,
    DateAdded date,
    LastChangedById int,
    DateChanged date,
    BatchId int,
    PostStatusTranslation varchar(255),
    AccountId int,
    PostDate date,
    FiscalPeriodId int,
    GrantId int,
    TranDistributionId int NOT NULL,
    TransactionId int,
    Projectid int,
    ClassId int,
    TDAmount numeric(37,15),
    TransactionCode1Id int,
    TransactionCode2Id int,
    TransactionCode3Id int,
    TransactionCode4Id int,
    TransactionCode5Id int,
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
)  ORDER BY TenantId,
          TranDistributionId,
          _sys_hash,
          _sys_is_deleted
SEGMENTED BY hash(TenantId, TranDistributionId) ALL NODES;

ALTER TABLE out_transactions ADD CONSTRAINT out_transactions_PK PRIMARY KEY (TenantId, TranDistributionId);

CREATE PROJECTION out_transactions_etl
(
 TenantId ENCODING RLE,
 AccountId ENCODING RLE,
 FiscalPeriodId ENCODING RLE,
 TranDistributionId,
 Projectid ENCODING RLE,
 _sys_is_deleted
)
AS
 SELECT TenantId,
        AccountId,
        FiscalPeriodId,
        TranDistributionId,
        Projectid,
        _sys_is_deleted
 FROM out_transactions
 ORDER BY TenantId,
          AccountId,
          FiscalPeriodId,
          Projectid,
          TranDistributionId,
          _sys_is_deleted
SEGMENTED BY hash(TenantId) ALL NODES;