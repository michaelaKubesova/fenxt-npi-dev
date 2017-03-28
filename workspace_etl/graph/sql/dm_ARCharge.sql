
select
 "ARChargeId",
 "ARChargeType",
 "ARChargeInvoiceId",
 "ARChargeLineItemSequence",
 "ARChargePostStatus",
 "ARChargePaymentStatus",
 "ARChargeItemDescription",
 "ARChargeAmount",
 "ARChargeBalance",
 "ARClientId",
 "datechanged",
 "dateadded",
 "postdate",
 case when duedate < '1900/01/01' then '1900/01/01'
 else duedate
 end
from stg_csv_ARCharge_merge
where TenantId = '${TenantId}'