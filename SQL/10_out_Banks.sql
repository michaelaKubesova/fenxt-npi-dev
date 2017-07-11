INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Banks',now(),null);
insert /*+ direct */ into out_Banks
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
b.TenantId as "TenantId",
	 GoodData_Attr(b.BankId) as "BankId"
	,GoodData_date(b.DateAdded)  as "DateAdded"
	,GoodData_date(b.DateChanged)  as "DateChanged"
	,GoodData_Attr(b.AddedById) as "AddedByUserName"
	,GoodData_Attr(au.Name) as "AddedByUserNameLabel"
	,GoodData_Attr(eu.Name) as "ChangedByUserNameLabel"
	,GoodData_Attr(b.BankId) as "BankDateId"
	,GoodData_Attr(1) as "Dummy"
	,b.IsReconciled as "IsReconciled"
	,GoodData_date(b.DateLastReconciled) as "DateLastReconciled"
	,GoodData_Attr(b.LastReconciledById) as "LastReconciledByUserName"
	,GoodData_Attr(lu.Name) as "LastReconciledByUserNameLabel"
	,cast(b.ReconciledBalance as decimal(15,2)) as "ReconciledBalance"
	,GoodData_Attr(b.BankName) as "Name"
	,GoodData_Attr(b.AccountName) as "AccountId"
	,GoodData_Attr(b.Description) as "Description"
	,GoodData_Attr(null) as "AccountNumber"
	,GoodData_Attr(null) as "RoutingNumber"
	,GoodData_Attr(b.AccountType) as "AccountType"
	,GoodData_Attr(b.AccountTypeTranslation) as "AccountTypeTranslation"
from stg_csv_bank_merge b
join stg_csv_user_merge au
	on b.AddedById = au.UserId and b.TenantId = au.TenantId and au._sys_is_deleted = false
join stg_csv_user_merge eu
	on b.LastChangedById = eu.UserId and b.TenantId = eu.TenantId and eu._sys_is_deleted = false
left join stg_csv_user_merge lu
	on b.LastReconciledById = lu.UserId and b.TenantId = lu.TenantId  and lu._sys_is_deleted = false
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Banks',null,now());
select analyze_statistics('out_Banks')
;