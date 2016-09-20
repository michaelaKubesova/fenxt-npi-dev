INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_FiscalPeriods',now(),null);
insert /*+ direct */ into dm_FiscalPeriods
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
fp.TenantId as "TenantId",
GoodData_Attr(fp.FiscalPeriodId) as "FiscalPeriodId",
GoodData_Attr(fp.Sequence) as "Sequence",
GoodData_Attr(to_char(fp.StartDate,'yyyy-mm-dd')) as "FiscalPeriodStart",
GoodData_Attr(fp.Sequence) as "FiscalPeriodStart_sort",
GoodData_Attr(to_char(fp.EndDate,'yyyy-mm-dd')) as "FiscalPeriodEnd",
GoodData_Attr(fy.FiscalYearId) as "FiscalYearId",
GoodData_Attr(fy.Name) as "FiscalYearName",
GoodData_Attr(fy.NumberOfPeriods) as "NumberOfPeriods",
GoodData_Attr(to_char(fy.StartDate,'yyyy-mm-dd')) as "FiscalYearStart",
GoodData_Attr(fy.Name) as "FiscalYearStart_sort",
GoodData_Attr(to_char(fy.EndDate,'yyyy-mm-dd')) as "FiscalYearEnd",
GoodData_date(fp.StartDate)  as "FiscalDate" 
from stg_csv_FiscalPeriods_merge fp
join stg_csv_FiscalYears_merge fy
  on fp.FiscalYearId = fy.FiscalYearId and fp.TenantId = fy.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_FiscalPeriods',null,now());
select analyze_statistics('dm_FiscalPeriods')
;