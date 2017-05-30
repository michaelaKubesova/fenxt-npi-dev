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

