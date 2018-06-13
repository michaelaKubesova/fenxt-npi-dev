create or replace view dm_FiscalPeriods as select 
_sys_transform_id,
TenantId,
FiscalPeriodId,
Sequence,
Gooddata_Date(FiscalPeriodStart::date)::varchar(255) AS FiscalPeriodStart,
FiscalPeriodStart_sort,
Gooddata_Date(FiscalPeriodEnd::date)::varchar(255) as FiscalPeriodEnd,
FiscalYearId,
FiscalYearName,
NumberOfPeriods,
Gooddata_Date(FiscalYearStart::date)::varchar(255) as FiscalYearStart,
FiscalYearStart_sort,
Gooddata_Date(FiscalYearEnd::date)::varchar(255) as FiscalYearEnd,
Gooddata_Date(FiscalDate::date)::varchar(255) as FiscalDate,
Gooddata_Date(FiscalYearStartDate::date)::varchar(255) as FiscalYearStartDate,
Gooddata_Date(FiscalYearEndDate::date)::varchar(255) as FiscalYearEndDate,
FiscalYearStatus
from out_FiscalPeriods 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_FiscalPeriods');