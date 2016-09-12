INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Banks',now(),null);
insert /*+ direct */ into dm_Banks
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
t.TenantId as "TenantId",
GoodData_Attr(BankId) as "BankId",
GoodData_date(DateAdded)  as "DateAdded",
GoodData_date(DateChanged)  as "DateChanged",
GoodData_Attr(AddedByUserId) as "AddedByUserName",
GoodData_Attr(au.UserName) as "AddedByUserNameLabel",
GoodData_Attr(eu.UserName) as "ChangedByUserNameLabel",
GoodData_Attr(BankId) as "BankDateId",
GoodData_Attr(1) as "Dummy",
IsReconciled as "IsReconciled",
GoodData_date(DateLastReconciled) as "DateLastReconciled",
GoodData_Attr(LastReconciledByUserId) as "LastReconciledByUserName",
GoodData_Attr(lu.UserName) as "LastReconciledByUserNameLabel",
cast(ReconciledBalance as decimal(15,2)) as "ReconciledBalance",
GoodData_Attr(t.Name) as "Name",
GoodData_Attr(t.AccountId) as "AccountId",
GoodData_Attr(t.Description) as "Description",
GoodData_Attr(t.AccountNumber) as "AccountNumber",
GoodData_Attr(t.RoutingNumber) as "RoutingNumber",
GoodData_Attr(t.AccountType) as "AccountType",
GoodData_Attr(t.AccountTypeTranslation) as "AccountTypeTranslation"
from stg_csv_Banks_merge  t
join stg_csv_Users_merge au
  on t.AddedByUserId = au.UsersId and t.TenantId = au.TenantId
join stg_csv_Users_merge eu
  on t.LastChangedByUserId = eu.UsersId and t.TenantId = eu.TenantId
left join stg_csv_Users_merge lu
  on t.LastReconciledByUserId = lu.UsersId and t.TenantId = lu.TenantId and lu._sys_is_deleted = 'false'
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Banks',null,now());
select analyze_statistics('dm_Banks')
;