drop table if exists out_Ratios;
CREATE TABLE out_Ratios
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    CurrentAssets varchar(255),
    CurrentLiability varchar(255),
    CashCoverageCurrentAssets varchar(255),
    CashCoverageExpense varchar(255),
    QuickRatio varchar(255),
    PostStatus varchar(255),
    PostStatusTranslation varchar(255),
    EncumbranceStatus varchar(255),
    EncumbranceStatusTranslation varchar(255),
    FiscalPeriodId varchar(255)
) ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);