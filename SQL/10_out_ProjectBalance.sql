INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_ProjectBalance',now(),null);
insert /*+ direct */ into out_ProjectBalance
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
"TenantId",
"ProjectBalanceId",
 "FiscalPeriodId",
 "ProjectId",
 "Balance",
 "AddBalance",
 "EncumberanceType",
 "AccountId",
 "PostStatus"
from stg_csv_ProjectBalance_merge
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_ProjectBalance',null,now());
select analyze_statistics('out_ProjectBalance')
;