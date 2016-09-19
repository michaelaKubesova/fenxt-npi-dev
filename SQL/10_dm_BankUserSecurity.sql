INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BankUserSecurity',now(),null);
insert /*+ direct */ into dm_BankUserSecurity
select distinct 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	TenantId as "TenantId",
	GoodData_Attr(UsersId||'#'||nvl(BankId, -1))  as "BankUserSecurityId",
	GoodData_Attr(UsersId)  as "UserId",
	GoodData_Attr(nvl(BankId, -1)) as "BankId"
from stg_csv_BankUserSecurity_merge t
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BankUserSecurity',null,now());
select analyze_statistics('dm_BankUserSecurity')
;
