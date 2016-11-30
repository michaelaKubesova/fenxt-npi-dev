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
	,GoodData_Attr(as.Segment1Value) as "AccountSegment1"
	,GoodData_Attr(as.Segment2Value) as "AccountSegment2"
	,GoodData_Attr(as.Segment3Value) as "AccountSegment3"
	,GoodData_Attr(as.Segment4Value) as "AccountSegment4"
	,GoodData_Attr(as.Segment5Value) as "AccountSegment5"
	,GoodData_Attr(as.Segment6Value) as "AccountSegment6"
	,GoodData_Attr(as.Segment7Value) as "AccountSegment7"
	,GoodData_Attr(as.Segment8Value) as "AccountSegment8"
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
join stg_csv_AccountSegmentValue_merge as  and a.TenantId = as.TenantId
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Accounts',null,now());
select analyze_statistics('dm_Accounts')
;