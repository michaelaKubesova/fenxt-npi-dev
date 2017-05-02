select
 "DateAdded",
 "DateChanged",
 "VendorId",
 "VendorName",
 "VendorUserID",
 "CustomerNumber",
 "StatusTranslation",
 "AddedByUserName",
 "AddedByUserNameLabel",
 "VendorDateId",
 "Dummy",
 GoodData_Attr('{"state":"payables.vendor.detail","id":'||VendorId||'}') "VendorNameHyperlink"
from dm_Vendors
where TenantId = '${TenantId}'
and _sys_transform_id = '${DM_VENDORS_TRANSFORM_ID}'
