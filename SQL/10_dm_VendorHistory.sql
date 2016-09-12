INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_VendorHistory',now(),null);
insert /*+ direct */ into dm_VendorHistory
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
vh.TenantId as "TenantId",
GoodData_Attr(vh.VendorHistoryId) as VendorHistoryId,
GoodData_Attr(vh.VendorId) as VendorId,
GoodData_Attr(vh.FieldChanged) as FieldChanged,
GoodData_Attr(vh.FieldChangedTranslation) as FieldChangedTranslation,
GoodData_Attr(vh.OldValue) as OldValue,
GoodData_Attr(vh.NewValue) as NewValue,
GoodData_Date(vh.DateChanged) as DateChanged,
GoodData_Attr(au.UserName) as ChangedByUserName
from stg_csv_VendorHistory_merge vh
join stg_csv_Users_merge au
on vh.ChangedByUserId = au.UsersId and vh.TenantId = au.TenantId  and vh._sys_is_deleted = au._sys_is_deleted
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_VendorHistory',null,now());
select analyze_statistics('dm_VendorHistory')
;