INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectBudgets',now(),null);
insert /*+ direct */ into dm_ProjectBudgets
select distinct 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
pb.TenantId as "TenantId",
cast(pb.PeriodAmount as decimal(15,2)) as "PeriodAmount",
GoodData_Attr(pb.ProjectBudgetId) as "ProjectBudgetId",
GoodData_Attr(AccountBudgetDetailId) as "AccountBudgetAttrId",
GoodData_Attr(pb.ProjectId)  as "ProjectId",
GoodData_Attr(pb.AccountId)  as "AccountId",
cast(pb.Amount as decimal(15,2)) as "ProjectBudgetAmount",
GoodData_Attr(pb.FiscalPeriodId)  as "FiscalPeriodId",
GoodData_Attr(ab.ScenarioId) as "ScenarioId"
from stg_csv_ProjectBudgets_merge pb
join stg_csv_AccountBudgets_merge ab
	on pb.AccountBudgetId = ab.AccountBudgetId and pb.TenantId = ab.TenantId 
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectBudgets',null,now());
select analyze_statistics('dm_ProjectBudgets')
;