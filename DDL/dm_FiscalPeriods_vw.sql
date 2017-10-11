 create or replace view dm_FiscalPeriods as select 
_sys_transform_id,
TenantId,
FiscalPeriodId,
Sequence,
FiscalPeriodStart,
FiscalPeriodStart_sort,
FiscalPeriodEnd,
FiscalYearId,
FiscalYearName,
NumberOfPeriods,
FiscalYearStart,
FiscalYearStart_sort,
FiscalYearEnd,
FiscalDate,
FiscalYearStartDate,
FiscalYearEndDate,
FiscalYearStatus
from out_FiscalPeriods 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_FiscalPeriods');
