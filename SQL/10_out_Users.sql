INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Users',now(),null);
insert /*+ direct */ into out_Users
	select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	au.TenantId as "TenantId",
	 GoodData_Attr(au.UserId)  as "UserId"
	,au.IsSupervisor "IsSupervisor"
	,GoodData_Attr(au.Name) "Name"
	,GoodData_Attr(au.Description) as "Description"
	,au.Inactive as "Inactive"
	,au.HasSupervisorRights as "HasSupervisorRights"
	,au.ViewOnly as "ViewOnly"
from stg_csv_User_merge au
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Users',null,now());
select analyze_statistics('out_Users')
;