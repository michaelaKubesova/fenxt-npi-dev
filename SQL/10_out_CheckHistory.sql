INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CheckHistory',now(),null);
insert /*+ direct */ into out_CheckHistory
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
	,GoodData_Attr(ch.DrillInID) as DrillInID
from stg_csv_CheckHistory_merge ch
join stg_csv_User_merge au
	on ch.ChangedByUserId = au.UserId and ch.TenantId = au.TenantId  and au._sys_is_deleted = false
where ch.CheckHistoryId < 1000000000
union all
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
cht.TenantId as "TenantId",
	 GoodData_Attr(cht.CheckHistoryId) as CheckHistoryId
	,GoodData_Attr(cht.CheckNumber) as CheckNumber
	,GoodData_Attr(cht.VendorName) as VendorName
	,GoodData_Attr(cht.FieldChanged) as FieldChanged
	,GoodData_Attr(cht.FieldChangedTranslation) as FieldChangedTranslation
	,GoodData_Attr(cht.OldValue) as OldValue
	,GoodData_Attr(cht.NewValue) as NewValue
	,GoodData_Date(cht.DateChanged) as DateChanged
	,GoodData_Attr(cht.PostStatus) as PostStatus
	,GoodData_Attr(cht.BankId) as BankId
	,GoodData_Attr(cht.ChangedByUserName) as ChangedByUserName
	,GoodData_Attr(cht.DrillInID) as DrillInID
from 
(select distinct ch.TenantId as "TenantId",
	 GoodData_Attr(ch.CheckHistoryId) as CheckHistoryId
	,GoodData_Attr(chd.CheckNumber) as CheckNumber
	,GoodData_Attr(chd.VendorName) as VendorName
	,GoodData_Attr(ch.FieldChanged) as FieldChanged
	,GoodData_Attr(ch.FieldChangedTranslation) as FieldChangedTranslation
	,GoodData_Attr(ch.OldValue) as OldValue
	,GoodData_Attr(ch.NewValue) as NewValue
	,GoodData_Date(ch.DateChanged) as DateChanged
	,GoodData_Attr(chd.PostStatus) as PostStatus
	,GoodData_Attr(chd.BankId) as BankId
	,GoodData_Attr('User unknown') as ChangedByUserName
	,GoodData_Attr(ch.DrillInID) as DrillInID
	from
stg_csv_CheckHistory_merge ch
join stg_csv_CheckHistory_merge chd on ch.CheckDbId = chd.CheckDbId and ch.TenantId = chd.TenantId
 where ch.CheckHistoryId >= 1000000000) cht where VendorName != 'null vendor'
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CheckHistory',null,now());
select analyze_statistics('out_CheckHistory')
;
