INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionProjectScenario',now(),null);
insert /*+ direct */ into dm_TransactionProjectScenario
	select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	TenantId as "TenantId",
	GoodData_Attr(t.TransactionDistributionId||'#'||pb.ScenarioId) as "TransactionScenarioId",
	GoodData_Attr(pb.ProjectId) as "ProjectId",
	GoodData_Attr(t.TransactionDistributionId) as "TransactionAttrDistributionId",
	GoodData_Attr(pb.scenarioid) as "ScenarioId",
	GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId",
	GoodData_Attr(t.AccountId) as "AccountId"
from stg_csv_transactions_merge t
inner join (
	select pb.projectid, ab.AccountId, ab.scenarioid, ab.FiscalPeriodId
	from stg_csv_accountbudgets_merge ab
	inner join stg_csv_ProjectBudgets_merge pb on pb.accountbudgetid = ab.accountbudgetid
	where 
	 pb.FiscalPeriodId = ab.FiscalPeriodId
	group by pb.projectid, ab.AccountId, ab.scenarioid, ab.FiscalPeriodId) pb on pb.projectid = t.projectid and pb.AccountId = t.AccountId
	and t.FiscalPeriodId = pb.FiscalPeriodId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionProjectScenario',null,now());
select analyze_statistics('dm_TransactionProjectScenario')
;