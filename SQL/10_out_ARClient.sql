INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_ARClients',now(),null);
insert /*+ direct */ into out_ARClients
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
C.TenantId,
ARClientId ,
ARClientType ,
ARClientDisplayName ,
ARClientCFDANumber ,
AddedByUserId,
dateadded,
datechanged,
A.Amount
from stg_csv_ARClient_merge C 
left join stg_csv_ARClientAmount_merge A
	on C.TenantId = A.TenantId and C.ARClientId = A.ClientId

;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_ARClients',null,now());
select analyze_statistics('out_ARClients')
;