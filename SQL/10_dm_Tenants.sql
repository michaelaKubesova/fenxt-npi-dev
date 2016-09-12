INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Tenants',now(),null);
insert /*+ direct */ into dm_Tenants
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
TenantId as "TenantId",
nvl(TransactionCode1Name,'TransactionCode1') TransactionCode1Name,
nvl(TransactionCode2Name,'TransactionCode2') TransactionCode2Name,
nvl(TransactionCode3Name,'TransactionCode3') TransactionCode3Name,
nvl(TransactionCode4Name,'TransactionCode4') TransactionCode4Name,
nvl(TransactionCode5Name,'TransactionCode5') TransactionCode5Name,
nvl(AccountSegment1Name,'AccountSegment1') AccountSegment1Name,
nvl(ProjectName,'Project') ProjectName,
nvl(FundName,'Fund') FundName,
nvl(GrantName,'Grant') GrantName,
DataUpdated DataUpdated
from stg_csv_Tenants_merge
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Tenants',null,now());
select analyze_statistics('dm_Tenants')
;