INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectBudgets',now(),null);
insert /*+ direct */ into dm_ProjectBudgets
select distinct 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
TenantId as "TenantId",
	 cast(PeriodAmount as decimal(15,2)) as "PeriodAmount"
	,GoodData_Attr(ProjectBudgetId||'-'||FiscalPeriodId) as "ProjectBudgetId"
	,GoodData_Attr(AccountBudgetAttrId) as "AccountBudgetAttrId"
	,GoodData_Attr(ProjectId)  as "ProjectId"
	,GoodData_Attr(AccountId)  as "AccountId"
	,cast(ProjectBudgetAmount as decimal(15,2)) as "ProjectBudgetAmount"
	,GoodData_Attr(FiscalPeriodId)  as "FiscalPeriodId"
	,GoodData_Attr(ScenarioId) as "ScenarioId"
from wk_PB_PBD_AB_ABD_BS_TE_join
union all
select
    ${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
    p.TenantId as "TenantId",
	cast(0 as decimal(15,2)) as "PeriodAmount",
	GoodData_Attr(p.ProjectId || '#' || FP.Id || '#<No budget>') as "ProjectBudgetId",
	GoodData_Attr(0) as "AccountBudgetAttrId",
	GoodData_Attr(p.ProjectId)  as "ProjectId",
	GoodData_Attr(null)  as "AccountId",
	cast(0 as decimal(15,2)) as "ProjectBudgetAmount",
	GoodData_Attr(FP.Id)  as "FiscalPeriodId",
	GoodData_Attr('<No Budget>') as "ScenarioId"
from stg_csv_project_merge p
join (select min(FiscalPeriodId) as "Id", TenantId from stg_csv_FiscalPeriod_merge group by TenantId) FP
on p.TenantId=fp.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectBudgets',null,now());
select analyze_statistics('dm_ProjectBudgets')
;
