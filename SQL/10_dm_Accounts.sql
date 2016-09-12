INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Accounts',now(),null);
insert /*+ direct */ into dm_Accounts
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
t.TenantId as "TenantId",
GoodData_Attr(AccountId) as "AccountId",
GoodData_Attr(AccountNumber) as "AccountNumber",
GoodData_Attr(AccountDescription) as "AccountDescription",
GoodData_Attr(AccountCategory) as "AccountCategory",
GoodData_Attr(AccountCategoryTranslation) as "AccountCategoryTranslation",
GoodData_Attr(FundDescription) as "FundDescription",
GoodData_Attr(Class) as "Class",
GoodData_Attr(StatusTranslation) as "StatusTranslation",
GoodData_Attr(AccountCodeDescription) as "AccountCodeDescription",
GoodData_date(DateAdded)  as "DateAdded",
GoodData_date(DateChanged)  as "DateChanged", 
GoodData_Attr(AddedByUserId) as "AddedByUserId",
GoodData_Attr(AddedByUserId) as "AddedByUserName",
GoodData_Attr(au.UserName) as "AddedByUserNameLabel",
GoodData_Attr(LastChangedByUserId) as "ChangedByUserId",
GoodData_Attr(LastChangedByUserId) as "ChangedByUserName",
GoodData_Attr(eu.UserName) as "ChangedByUserNameLabel",
GoodData_Attr(AccountId) as "AccountDateId",
GoodData_Attr(1) as "Dummy"
from stg_csv_Accounts_merge  t
join stg_csv_Users_merge au
  on t.AddedByUserId = au.UsersId and t.TenantId = au.TenantId
join stg_csv_Users_merge eu
  on t.LastChangedByUserId = eu.UsersId and t.TenantId = eu.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Accounts',null,now());
select analyze_statistics('dm_Accounts')
;