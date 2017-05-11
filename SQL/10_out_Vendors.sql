INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_Vendors',now(),null);
insert /*+ direct */ into out_Vendors
	select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	v.TenantId as "TenantId",
	 GoodData_date(v.DateAdded)  as "DateAdded"
	,GoodData_date(v.DateChanged)  as "DateChanged"
	,GoodData_Attr(v.VendorId) "VendorId"
	,GoodData_Attr(v.VendorNameForDisplay) "VendorName"
	,GoodData_Attr(v.UserDefinedId) as "VendorUserID"
	,GoodData_Attr(ifnull(v.CustomerNumber,' ')) as "CustomerNumber"
	,GoodData_Attr(v.StatusTranslation) as "StatusTranslation"
	,GoodData_Attr(v.AddedById) as "AddedByUserName"
	,GoodData_Attr(au.Name) as "AddedByUserNameLabel"
	,GoodData_Attr(v.VendorId) as "VendorDateId"
	,GoodData_Attr(1) as "Dummy"
from stg_csv_vendor_merge v
join stg_csv_User_merge au
	on v.AddedById = au.UserId and v.TenantId = au.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_Vendors',null,now());
select analyze_statistics('out_Vendors')
;