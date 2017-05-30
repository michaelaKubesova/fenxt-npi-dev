 create or replace view dm_Ratios as select 
_sys_transform_id,
TenantId,
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
from out_Ratios 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Ratios');
