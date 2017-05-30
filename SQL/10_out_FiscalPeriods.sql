INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_FiscalPeriods',now(),null);
insert /*+ direct */ into out_FiscalPeriods
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
fp.TenantId as "TenantId",
	 GoodData_Attr(fp.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(fp.Sequence) as "Sequence"
	,GoodData_Date(fp.StartDate) as "FiscalPeriodStart"
	,GoodData_Attr(fp.Sequence) as "FiscalPeriodStart_sort"
	,GoodData_Date(fp.EndDate) as "FiscalPeriodEnd"
	,GoodData_Attr(fy.FiscalYearId) as "FiscalYearId"
	,GoodData_Attr(fy.YearId) as "FiscalYearName"
	,GoodData_Attr(fy.FiscalPeriods) as "NumberOfPeriods"
	,GoodData_Attr(to_char(summary.StartDate,'yyyy-mm-dd')) as "FiscalYearStart"
	,GoodData_Attr(fy.YearId) as "FiscalYearStart_sort"
	,GoodData_Attr(to_char(summary.EndDate,'yyyy-mm-dd')) as "FiscalYearEnd"
	,GoodData_date(fp.StartDate)  as "FiscalDate"
	,GoodData_date(summary.StartDate) as "FiscalYearStartDate"
	,GoodData_date(summary.EndDate) as "FiscalYearEndDate"
from stg_csv_fiscalperiod_merge fp
join (select 
		 FiscalYearId
		,TenantId
		,MIN(StartDate) as "StartDate"
		,MAX(EndDate) as "EndDate"
	 from stg_csv_fiscalperiod_merge
	 group by FiscalYearId, TenantId) summary on summary.FiscalYearId = fp.FiscalYearId and summary.TenantId = fp.TenantId
join stg_csv_fiscalyear_merge fy
	on fp.FiscalYearId = fy.FiscalYearId and fp.TenantId = fy.TenantId
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_FiscalPeriods',null,now());
select analyze_statistics('out_FiscalPeriods')
;