INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectBudgets',now(),null);
insert /*+ direct */ into dm_ProjectBudgets
select distinct 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
pb.TenantId as "TenantId",
	 cast(pbd.Amount as decimal(15,2)) as "PeriodAmount"
	,GoodData_Attr(pb.ProjectBudgetId||'-'||pbd.FiscalPeriodId) as "ProjectBudgetId"
	,GoodData_Attr(abd.AccountBudgetDetailId) as "AccountBudgetAttrId"
	,GoodData_Attr(pb.ProjectId)  as "ProjectId"
	,GoodData_Attr(pb.AccountId)  as "AccountId"
	,cast(pb.Amount as decimal(15,2)) as "ProjectBudgetAmount"
	,GoodData_Attr(pbd.FiscalPeriodId)  as "FiscalPeriodId"
	,GoodData_Attr(te.Description) as "ScenarioId"
from stg_csv_ProjectBudget_merge pb
join stg_csv_ProjectBudgetDetail_merge pbd
	on pb.ProjectBudgetId = pbd.ProjectBudgetId and pb.TenantId = pbd.TenantId
join stg_csv_AccountBudget_merge ab
	on pb.AccountBudgetId = ab.AccountBudgetId and pb.TenantId = ab.TenantId
join stg_csv_AccountBudgetDetail_merge abd
	on pb.AccountBudgetId = abd.AccountBudgetId and pb.TenantId = abd.TenantId
join stg_csv_BudgetScenario_merge bs
	on ab.BudgetScenarioId = bs.BudgetScenarioId and pb.TenantId = bs.TenantId
join stg_csv_TableEntry_merge te
	on bs.ScenarioId = te.TableEntryId and pb.TenantId = te.TenantId
union all
select
    ${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
    p.TenantId as "TenantId",
	'0' as "PeriodAmount",
	GoodData_Attr(p.ProjectId || '#' || FP.Id || '#<No budget>') as "ProjectBudgetId",
	GoodData_Attr(0) as "AccountBudgetAttrId",
	GoodData_Attr(p.ProjectId)  as "ProjectId",
	GoodData_Attr(null)  as "AccountId",
	'0' as "ProjectBudgetAmount",
	GoodData_Attr(FP.Id)  as "FiscalPeriodId",
	null as "ScenarioId"
from stg_csv_project_merge p
join (select min(FiscalPeriodId) as "Id", TenantId from stg_csv_FiscalPeriod_merge group by TenantId) FP
on p.TenantId=fp.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectBudgets',null,now());
select analyze_statistics('dm_ProjectBudgets')
;