INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_attr',now(),null);
insert /*+ direct */ into dm_Invoices_attr  
	select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	GoodData_Attr(InvoiceId) as "InvoiceId",
	GoodData_Attr(InvoiceNumber) as "InvoiceNumber",
	GoodData_Attr(t.Description) as "Description",
	GoodData_Attr(StatusTranslation) as "StatusTranslation",
	GoodData_Attr(AddedByUserId) as "AddedByUserName",
	GoodData_Attr(au.UserName) as "AddedByUserNameLabel",
	GoodData_Attr('payables/invoice/'||InvoiceId||'?tenantid='||t.TenantId) as "InvoiceHyperlink"
	from stg_csv_Invoices_merge t
	join stg_csv_Users_merge au
	  on t.AddedByUserId = au.UsersId and t.TenantId = au.TenantId
	join stg_csv_Users_merge eu
	  on t.LastChangedByUserId = eu.UsersId and t.TenantId = eu.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_attr',null,now());
select analyze_statistics('dm_Invoices_attr')
;