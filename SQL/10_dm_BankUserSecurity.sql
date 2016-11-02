INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BankUserSecurity',now(),null);
insert /*+ direct */ into dm_BankUserSecurity
select distinct 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr(t.UsersId||'#'||t.BankId)  as "BankUserSecurityId"
	,GoodData_Attr(t.UsersId)  as "UserId"
	,GoodData_Attr(t.BankId) as "BankId"
from stg_csv_BankUserSecurity_merge t
where t.BankId is not null

union all

select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	u.TenantId as "TenantId",
	 GoodData_Attr(UserId||'#'||-1)  as "BankUserSecurityId"
	,GoodData_Attr(UserId)  as "UserId"
	,GoodData_Attr(-1) as "BankId"
from stg_csv_User_merge u
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BankUserSecurity',null,now());
select analyze_statistics('dm_BankUserSecurity')
;
