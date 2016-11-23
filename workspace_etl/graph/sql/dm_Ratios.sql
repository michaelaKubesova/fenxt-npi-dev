select
 "CurrentAssets",
  "CurrentLiability",
  "CashCoverageCurrentAssets",
  "CashCoverageExpense",
  "QuickRatio",
  "PostStatus",
  "PostStatusTranslation",
  "EncumbranceStatus",
  "EncumbranceStatusTranslation",
  "FiscalPeriodId"
from dm_ratios
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_RATIOS_TRANSFORM_ID}
