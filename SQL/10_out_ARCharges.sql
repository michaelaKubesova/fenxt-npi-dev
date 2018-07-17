INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ARCharges',now(),null);
insert /*+ direct */ into out_ARCharges
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
GoodData_Date(datechanged),
GoodData_Date(dateadded),
GoodData_Date(postdate),
GoodData_Date(duedate)
from stg_csv_ARCharge_merge
where _sys_is_deleted = false
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ARCharges',null,now());
select analyze_statistics('out_ARCharges')
;