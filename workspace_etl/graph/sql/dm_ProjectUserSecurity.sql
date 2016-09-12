

select
 "ProjecttUserSecurityId",
 "UserId",
 "ProjectId"
from dm_ProjectUserSecurity
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_PROJECTUSERSECURITY_TRANSFORM_ID}
union all
select
	GoodData_Attr(UsersId||'#0')  as "ProjecttUserSecurityId",
	GoodData_Attr(UsersId)  as "UserId",
	GoodData_Attr('0') as "ProjectId"
from stg_csv_Users_merge u
where TenantId = '${TenantId}'