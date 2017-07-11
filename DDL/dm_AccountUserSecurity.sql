create or replace view dm_AccountUserSecurity
AS
select  t.TenantId as "TenantId",
	 GoodData_Attr(UsersId||'#'||AccountId)  as "AccountUserSecurityId"
	,GoodData_Attr(UsersId)  as "UserId"
	,GoodData_Attr(AccountId) as "AccountId"
from stg_csv_AccountUserSecurity_merge t
where Deleted = false

union all

select u.TenantId as "TenantId",
	 GoodData_Attr(UserId||'#'||-1)  as "AccountUserSecurityId"
	,GoodData_Attr(UserId)  as "UserId"
	,GoodData_Attr(-1) as "AccountId"
from stg_csv_User_merge u
where  _sys_is_deleted = false;