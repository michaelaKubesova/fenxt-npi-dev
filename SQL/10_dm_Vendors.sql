INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Vendors',now(),null);
insert /*+ direct */ into dm_Vendors
	select   
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	GoodData_date(DateAdded)  as "DateAdded",
	GoodData_date(DateChanged)  as "DateChanged",
	GoodData_Attr(VendorId) as "VendorId",
	GoodData_Attr(VendorName) as "VendorName",
	GoodData_Attr(UserDefinedId) as "VendorUserID",
	GoodData_Attr(ifnull(CustomerNumber,' ')) as "CustomerNumber",
	GoodData_Attr(StatusTranslation) as "StatusTranslation",
	GoodData_Attr(AddedByUserId) as "AddedByUserName",
	GoodData_Attr(au.UserName) as "AddedByUserNameLabel",
	GoodData_Attr(VendorId) as "VendorDateId",
	GoodData_Attr(1) as "Dummy"
	from stg_csv_Vendors_merge t
	join stg_csv_Users_merge au
	  on t.AddedByUserId = au.UsersId and t.TenantId = au.TenantId
	join stg_csv_Users_merge eu
	  on t.LastChangedByUserId = eu.UsersId and t.TenantId = eu.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Vendors',null,now());
select analyze_statistics('dm_Vendors')
;