select
 CurrentAssets,
 CurrentLiability,
 CashCoverageCurrentAssets,
 CashCoverageExpense,
 QuickRatio,
 PostStatus,
 PostStatusTranslation,
 EncumbranceStatus,
 EncumbranceStatusTranslation,
 FiscalPeriodId
from dm_Ratios
where TenantId = '${TenantId}'
and _sys_transform_id = '${DM_INVOICES_FACT_TRANSFORM_ID}'