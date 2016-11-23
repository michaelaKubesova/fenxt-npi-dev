INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_InvoiceDistribution',now(),null);
insert /*+ direct */ into dm_InvoiceDistribution
	select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	D.TenantId as "TenantId",
	 GoodData_attr(TD.TransactionDistributionId) as "InvoiceDistributionId"
	,GoodData_attr(D.ParentId) as "InvoiceId"
	,GoodData_attr(D.AccountsId) as "AccountId"
	,GoodData_attr(nvl(TD.ProjectId, -2)) as "ProjectId"
from stg_csv_BBDistribution_merge D
join stg_csv_BBTransactionDistribution_merge TD
	on D.DistributionId = TD.DistributionId and D.TenantId = TD.TenantId
where D.ParentObjectType = 268
	and D.SystemMask = 4

union all
select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	D.TenantId as "TenantId",
	 GoodData_attr(TD.TransactionDistributionId||0) as "InvoiceDistributionId"
	,GoodData_attr(D.ParentId) as "InvoiceId"
	,GoodData_attr(D.AccountsId) as "AccountId"
	,GoodData_attr(nvl(TD.ProjectId, -1)) as "ProjectId"
from stg_csv_BBDistribution_merge D
join stg_csv_BBTransactionDistribution_merge TD
	on D.DistributionId = TD.DistributionId and D.TenantId = TD.TenantId
where D.ParentObjectType = 268
	and D.SystemMask = 4
	and TD.ProjectId is NULL
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_InvoiceDistribution',null,now());
select analyze_statistics('dm_InvoiceDistribution')
;