SELECT
    "FiscalPeriodId",
    "Sequence",
    "FiscalPeriodStart",
    "FiscalPeriodStart_sort",
    "FiscalPeriodEnd",
    "FiscalYearId",
    "FiscalYearName",
    "NumberOfPeriods",
    "FiscalYearStart",
    "FiscalYearStart" AS FiscalYearStart_Datedim,
    "FiscalYearStart_sort",
    "FiscalYearEnd",
    "FiscalYearEnd" AS FiscalYearEnd_Datedim,
    "FiscalDate",
	'' as FiscalPeriodStartString,
	'' as FiscalPeriodEndString

FROM
    dm_FiscalPeriods
WHERE
    TenantId = '${TenantId}'

UNION ALL
SELECT
    GoodData_Attr('0') AS "FiscalPeriodId" ,
    GoodData_Attr('')  AS "Sequence" ,
    GoodData_Attr('')  AS "FiscalPeriodStart" ,
    GoodData_Attr('')  AS "FiscalPeriodStart_sort" ,
    GoodData_Attr('')  AS "FiscalPeriodEnd" ,
    GoodData_Attr('')  AS "FiscalYearId" ,
    GoodData_Attr('')  AS "FiscalYearName" ,
    GoodData_Attr('')  AS "NumberOfPeriods" ,
    GoodData_Attr('')  AS "FiscalYearStart" ,
    GoodData_Attr('')  AS "FiscalYearStart_Datedim" ,
    GoodData_Attr('')  AS "FiscalYearStart_sort" ,
    GoodData_Attr('')  AS "FiscalYearEnd" ,
    GoodData_Attr('')  AS "FiscalYearEnd_Datedim" ,
    NULL               AS "FiscalDate",
	GoodData_Attr('')  as FiscalPeriodStartString,
	GoodData_Attr('')  as FiscalPeriodEndString