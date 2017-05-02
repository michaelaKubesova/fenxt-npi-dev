INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ARCharges',now(),null);
insert /*+ direct */ into dm_ARCharges
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
TenantId as "TenantId",
ARChargeId,
ARChargeType,
ARChargeInvoiceId,
ARChargeLineItemSequence,
ARChargePostStatus,
ARChargePaymentStatus,
ARChargeItemDescription,
ARChargeAmount,
ARChargeBalance, 
ARClientId,
datechanged,
dateadded,
postdate,
duedate
from stg_csv_ARCharge_merge
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ARCharges',null,now());
select analyze_statistics('dm_ARCharges')
;