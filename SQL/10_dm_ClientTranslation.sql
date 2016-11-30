INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ClientTranslation',now(),null);
insert /*+ direct */ into dm_ClientTranslation
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
TenantId as "TenantId",
	 case when length(TransactionCode1Name) = 0 then 'TransactionCode1' else nvl(TransactionCode1Name,'TransactionCode1') end TransactionCode1Name
	,case when length(TransactionCode2Name) = 0 then 'TransactionCode2' else nvl(TransactionCode2Name,'TransactionCode2') end TransactionCode2Name
	,case when length(TransactionCode3Name) = 0 then 'TransactionCode3' else nvl(TransactionCode3Name,'TransactionCode3') end TransactionCode3Name
	,case when length(TransactionCode4Name) = 0 then 'TransactionCode4' else nvl(TransactionCode4Name,'TransactionCode4') end TransactionCode4Name
	,case when length(TransactionCode5Name) = 0 then 'TransactionCode5' else nvl(TransactionCode5Name,'TransactionCode5') end TransactionCode5Name
	,case when length(AccountSegment1Name) = 0 then 'AccountSegment1' else nvl(AccountSegment1Name,'AccountSegment1') end AccountSegment1Name
	,case when length(AccountSegment2Name) = 0 then 'AccountSegment2' else nvl(AccountSegment2Name,'AccountSegment2') end AccountSegment2Name
	,case when length(AccountSegment3Name) = 0 then 'AccountSegment3' else nvl(AccountSegment3Name,'AccountSegment3') end AccountSegment3Name
	,case when length(AccountSegment4Name) = 0 then 'AccountSegment4' else nvl(AccountSegment4Name,'AccountSegment4') end AccountSegment4Name
	,case when length(AccountSegment5Name) = 0 then 'AccountSegment5' else nvl(AccountSegment5Name,'AccountSegment5') end AccountSegment5Name
	,case when length(AccountSegment6Name) = 0 then 'AccountSegment6' else nvl(AccountSegment6Name,'AccountSegment6') end AccountSegment6Name
	,case when length(AccountSegment7Name) = 0 then 'AccountSegment7' else nvl(AccountSegment7Name,'AccountSegment7') end AccountSegment7Name
	,case when length(AccountSegment8Name) = 0 then 'AccountSegment8' else nvl(AccountSegment8Name,'AccountSegment8') end AccountSegment8Name
	,case when length(ProjectName) = 0 then 'Project' else nvl(ProjectName,'Project') end ProjectName
	,case when length(FundName) = 0 then 'Fund' else nvl(FundName,'Fund') end FundName
	,case when length(GrantName) = 0 then 'Grant' else nvl(GrantName,'Grant') end GrantName
from stg_csv_Tenant_merge   
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ClientTranslation',null,now());
select analyze_statistics('dm_ClientTranslation')
;