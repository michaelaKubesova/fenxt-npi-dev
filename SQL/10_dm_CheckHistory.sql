INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CheckHistory',now(),null);
insert /*+ direct */ into dm_CheckHistory
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
ch.TenantId as "TenantId",
	 GoodData_Attr(CheckHistoryId) as CheckHistoryId
	,GoodData_Attr(ch.CheckNumber) as CheckNumber
	,GoodData_Attr(ch.VendorName) as VendorName
	,GoodData_Attr(ch.FieldChanged) as FieldChanged
	,GoodData_Attr(ch.FieldChangedTranslation) as FieldChangedTranslation
	,GoodData_Attr(ch.OldValue) as OldValue
	,GoodData_Attr(ch.NewValue) as NewValue
	,GoodData_Date(ch.DateChanged) as DateChanged
	,GoodData_Attr(ch.PostStatus) as PostStatus
	,GoodData_Attr(ch.BankId) as BankId
	,GoodData_Attr(au.Name) as ChangedByUserName
from stg_csv_CheckHistory_merge ch
join stg_csv_User_merge au
	on ch.ChangedByUserId = au.UserId and ch.TenantId = au.TenantId
where  ch._sys_is_deleted = false
	and au._sys_is_deleted = false
	and ch.Deleted = false
	and au.Deleted = false
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CheckHistory',null,now());
select analyze_statistics('dm_CheckHistory')
;