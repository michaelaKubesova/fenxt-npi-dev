INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_AccountHistory',now(),null);
insert /*+ direct */ into out_AccountHistory
select 
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
ah.TenantId as "TenantId",
	 GoodData_Attr(ah.AccountHistoryId) as AccountHistoryId
	,GoodData_Attr(ah.AccountId) as AccountId
	,GoodData_Attr(ah.FieldChanged) as FieldChanged
	,GoodData_Attr(ah.FieldChangedTranslation) as FieldChangedTranslation
	,GoodData_Attr(ah.OldValue) as OldValue
	,GoodData_Attr(ah.NewValue) as NewValue
	,GoodData_Date(ah.DateChanged) as DateChanged
	,GoodData_Attr(au.Name) as ChangedByUserName
from stg_csv_AccountHistory_merge ah
join stg_csv_User_merge au
	on ah.ChangedByUserId = au.UserId and ah.TenantId = au.TenantId
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_AccountHistory',null,now());
select analyze_statistics('out_AccountHistory')
;