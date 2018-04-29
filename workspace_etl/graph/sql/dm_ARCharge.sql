
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
 Gooddata_Date(datechanged::date),
 Gooddata_Date(dateadded::date),
 Gooddata_Date(postdate::date),
 Gooddata_Date(duedate::date)
from dm_ARCharges
where TenantId = '${TenantId}'