
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
 case when cast(duedate as datetime) < '1900/01/01' then '1900-01-01 00:00:00'
 else duedate
 end
from dm_ARCharges
where TenantId = '${TenantId}'