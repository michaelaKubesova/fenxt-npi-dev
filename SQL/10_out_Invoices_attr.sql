INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_attr',now(),null);
insert /*+ direct */ into out_Invoices_attr  
	select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	i.TenantId as "TenantId",
	 GoodData_Attr(i.InvoiceId) as "InvoiceId"
	,GoodData_Attr(i.InvoiceNumber) as "InvoiceNumber"
	,GoodData_Attr(i.Description) as "Description"
	,GoodData_Attr(case when ((i.Status = 1 OR i.Status = 2) AND (v.Status = 3 OR i.HoldPayment = true)) then 'On hold'
					else i.StatusTranslation end) as "StatusTranslation"
	,GoodData_Attr(i.AddedById) as "AddedByUserName"
	,GoodData_Attr(au.Name) as "AddedByUserNameLabel"
	,GoodData_Attr('{"state":"payables.invoice.detail","id":'||InvoiceId||'}') "InvoiceNumberHyperlink"
	,GoodData_Attr(case when i.PaymentMethod= 1 then 'Check'
		            when i.PaymentMethod= 2 then 'EFT'
		            when i.PaymentMethod= 3 then 'Bank Draft'
					when i.PaymentMethod= 4 then 'Credit Card'
	             end) as "InvoicePaymentMethod"
from stg_csv_invoice_merge i
join stg_csv_user_merge au
	on i.AddedById = au.UserId and i.TenantId = au.TenantId and au._sys_is_deleted = false
join stg_csv_vendor_merge v
	on i.VendorId = v.VendorId and i.TenantId = v.TenantId and v._sys_is_deleted = false
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_attr',null,now());
select analyze_statistics('out_Invoices_attr')
;