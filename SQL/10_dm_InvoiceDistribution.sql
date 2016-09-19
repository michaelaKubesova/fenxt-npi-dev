INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_InvoiceDistribution',now(),null);
insert /*+ direct */ into dm_InvoiceDistribution
	select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	ID.TenantId as "TenantId",
	GoodData_attr(ID.InvoiceDistributionId) as "InvoiceDistributionId"
	,GoodData_attr(ID.InvoiceId) as "InvoiceId"
	,GoodData_attr(ID.AccountId) as "AccountId"
	,GoodData_attr(nvl(ID.ProjectId, -2)) as "ProjectId"
from stg_csv_InvoiceDistributions_merge ID	
where ID._sys_is_deleted = false
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_InvoiceDistribution',null,now());
select analyze_statistics('dm_InvoiceDistribution')
;