CREATE TABLE tmp_ProjectBudgetDetail
(
    TenantId varchar(255) encoding rle,
    ProjectBudgetId int encoding rle,
    FiscalPeriodId int,
    Amount numeric(19,4)
) ORDER BY TenantId,
          ProjectBudgetId
SEGMENTED BY hash(TenantId) ALL NODES;