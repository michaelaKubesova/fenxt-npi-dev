INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_attr',now(),null);
insert /*+ direct */ into dm_Invoices_attr  
	select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	i.TenantId as "TenantId",
	 GoodData_Attr(i.InvoiceId) as "InvoiceId"
	,GoodData_Attr(i.InvoiceNumber) as "InvoiceNumber"
	,GoodData_Attr(i.Description) as "Description"
	,GoodData_Attr(i.StatusTranslation) as "StatusTranslation"
	,GoodData_Attr(i.AddedById) as "AddedByUserName"
	,GoodData_Attr(au.Name) as "AddedByUserNameLabel"
	,GoodData_Attr(i.InvoiceId) as "InvoiceAttributeId"
from stg_csv_invoice_merge i
join stg_csv_user_merge au
	on i.AddedById = au.UserId and i.TenantId = au.TenantId
where i.Deleted = false
	and i._sys_is_deleted = false
	and au._sys_is_deleted = false
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_attr',null,now());
select analyze_statistics('dm_Invoices_attr')
;