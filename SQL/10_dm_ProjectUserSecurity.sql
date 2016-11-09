INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectUserSecurity',now(),null);
insert /*+ direct */ into dm_ProjectUserSecurity
select   
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	GoodData_Attr(UsersId||'#'||ProjectId)  as "ProjectUserSecurityId",
	GoodData_Attr(UsersId)  as "UserId",
	GoodData_Attr(ProjectId) as "ProjectId"
from stg_csv_ProjectUserSecurity_merge t

union all

select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	u.TenantId as "TenantId",
	 GoodData_Attr(UserId||'#'||-1)  as "ProjectUserSecurityId"
	,GoodData_Attr(UserId)  as "UserId"
	,GoodData_Attr(-1) as "ProjectId"
from stg_csv_User_merge u;
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_ProjectUserSecurity',null,now());
select analyze_statistics('dm_ProjectUserSecurity')
;