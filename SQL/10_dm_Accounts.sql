INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Accounts',now(),null);
insert /*+ direct */ into dm_Accounts
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
a.TenantId as "TenantId",
	 GoodData_Attr(a.AccountId) as "AccountId"
	,GoodData_Attr(a.AccountNumber) as "AccountNumber"
	,GoodData_Attr(a.AccountDescription) as "AccountDescription"
	,GoodData_Attr(a.AccountCategory) as "AccountCategory"
	,GoodData_Attr(a.AccountCategoryTranslation) as "AccountCategoryTranslation"
	,GoodData_Attr(f.Description) as "FundDescription"
	,GoodData_Attr(class.Description) as "Class"
	,GoodData_Attr(a.StatusTranslation) as "StatusTranslation"
	,GoodData_Attr(ac.Description) as "AccountCodeDescription"
	,GoodData_date(a.DateAdded)  as "DateAdded"
	,GoodData_date(a.DateChanged)  as "DateChanged"
	,GoodData_Attr(a.AddedByUserId) as "AddedByUserId"
	,GoodData_Attr(a.AddedByUserId) as "AddedByUserName"
	,GoodData_Attr(au.Name) as "AddedByUserNameLabel"
	,GoodData_Attr(a.LastChangedByUserId) as "ChangedByUserId"
	,GoodData_Attr(a.LastChangedByUserId) as "ChangedByUserName"
	,GoodData_Attr(eu.Name) as "ChangedByUserNameLabel"
	,GoodData_Attr(a.AccountId) as "AccountDateId"
	,GoodData_Attr(1) as "Dummy"
from stg_csv_account_merge a
join stg_csv_user_merge au
	on a.AddedByUserId = au.UserId and a.TenantId = au.TenantId
join stg_csv_user_merge eu
	on a.LastChangedByUserId = eu.UserId and a.TenantId = eu.TenantId
join stg_csv_fund_merge f
	on a.FundId = f.FundId and a.TenantId = f.TenantId
join stg_csv_tableentry_merge class
	on a.ClassId = class.TableEntryId and a.TenantId = class.TenantId
join stg_csv_accountcode_merge ac
	on a.AccountCodeId = ac.AccountCodeId and a.TenantId = ac.TenantId
where a._sys_is_deleted = false
	and au._sys_is_deleted = false
	and eu._sys_is_deleted = false
	and f._sys_is_deleted = false
	and ac._sys_is_deleted = false
	and class._sys_is_deleted = false
	and a.Deleted = false
	and au.Deleted = false
	and eu.Deleted = false
	and f.Deleted = false
	and ac.Deleted = false
	and class.Deleted = false
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Accounts',null,now());
select analyze_statistics('dm_Accounts')
;