INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectHistory',now(),null);
insert /*+ direct */ into dm_ProjectHistory
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
ph.TenantId as "TenantId",
	 GoodData_Attr(ProjectHistoryId) as ProjectHistoryId
	,GoodData_Attr(ph.ProjectId) as ProjectId
	,GoodData_Attr(ph.FieldChanged) as FieldChanged
	,GoodData_Attr(ph.FieldChangedTranslation) as FieldChangedTranslation
	,GoodData_Attr(ph.OldValue) as OldValue
	,GoodData_Attr(ph.NewValue) as NewValue
	,GoodData_Date(ph.DateChanged) as DateChanged
	,GoodData_Attr(au.Name) as ChangedByUserName
from stg_csv_ProjectHistory_merge ph
join stg_csv_User_merge au
	on ph.ChangedByUserId = au.UserId and ph.TenantId = au.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectHistory',null,now());
select analyze_statistics('dm_ProjectHistory')
;