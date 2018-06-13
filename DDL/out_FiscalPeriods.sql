drop table if exists out_FiscalPeriods;
CREATE TABLE out_FiscalPeriods
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    FiscalPeriodId varchar(255),
    Sequence varchar(255),
    FiscalPeriodStart varchar(255),
    FiscalPeriodStart_sort varchar(255),
    FiscalPeriodEnd varchar(255),
    FiscalYearId varchar(255),
    FiscalYearName varchar(255),
    NumberOfPeriods varchar(255),
    FiscalYearStart varchar(255),
    FiscalYearStart_sort varchar(255),
    FiscalYearEnd varchar(255),
    FiscalDate varchar(255),
    FiscalYearStartDate varchar(255),
    FiscalYearEndDate varchar(255),
	FiscalYearStatus varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);