INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Tenants',now(),null);
insert /*+ direct */ into dm_Tenants
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
TenantId as "TenantId",
	 TenantId as Tenant
	,case when length(TransactionCode1Name) = 0 then 'TransactionCode1' else nvl(TransactionCode1Name,'TransactionCode1') end TransactionCode1Name
	,case when length(TransactionCode2Name) = 0 then 'TransactionCode2' else nvl(TransactionCode2Name,'TransactionCode2') end TransactionCode2Name
	,case when length(TransactionCode3Name) = 0 then 'TransactionCode3' else nvl(TransactionCode3Name,'TransactionCode3') end TransactionCode3Name
	,case when length(TransactionCode4Name) = 0 then 'TransactionCode4' else nvl(TransactionCode4Name,'TransactionCode4') end TransactionCode4Name
	,case when length(TransactionCode5Name) = 0 then 'TransactionCode5' else nvl(TransactionCode5Name,'TransactionCode5') end TransactionCode5Name
	,case when length(ProjectName) = 0 then 'Project' else nvl(ProjectName,'Project') end ProjectName
	,case when length(FundName) = 0 then 'Fund' else nvl(FundName,'Fund') end FundName
	,case when length(GrantName) = 0 then 'Grant' else nvl(GrantName,'Grant') end GrantName
	,cast(DataUpdated as datetime) + Interval ' 1 second' * DATEDIFF(second, GETDATE(), GETUTCDATE()) DataUpdated
from stg_csv_Tenant_merge
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Tenants',null,now());
select analyze_statistics('dm_Tenants')
;