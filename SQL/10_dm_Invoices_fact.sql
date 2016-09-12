INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_fact',now(),null);
insert /*+ direct */ into dm_Invoices_fact
	select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	TenantId as "TenantId",
	GoodData_Attr(InvoiceId) as "InvoiceFactId",
	 Gooddata_Attr(VendorId)  as "VendorId",
	 Gooddata_Attr(FiscalPeriodId)  as "FiscalPeriodId",
	 Gooddata_Attr(InvoiceId)  as "InvoiceAttrId",
	cast(Amount as decimal(15,2)) as "InvoiceAmount",
	cast(Balance as decimal(15,2)) as "InvoiceBalance",
	cast(TaxAmount as decimal(15,2)) as "InvoiceTaxAmount",
	cast(DiscountAmount as decimal(15,2)) as "InvoiceDiscountAmount",
	Gooddata_date(DateAdded) as "DateAdded",
	Gooddata_date(DateChanged) as "DateChanged",
	Gooddata_date(DueDate) as "DueDate",
	Gooddata_date(PostDate) as "PostDate",
	GoodData_Attr('inv-'||InvoiceId) as "PostStatusId",
	GoodData_date(Date) as "Date"
	from stg_csv_Invoices_merge
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_fact',null,now());
select analyze_statistics('dm_Invoices_fact')
;