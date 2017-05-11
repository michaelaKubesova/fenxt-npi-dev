INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_CreditMemos_attr',now(),null);
insert /*+ direct */ into out_CreditMemos_attr	 
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
cm.TenantId as "TenantId",
	 GoodData_date(cm.DateAdded)  as "DateAdded"
	,GoodData_date(cm.DateChanged)  as "DateChanged"
	,GoodData_Attr(cm.CreditMemoId) as "CreditMemoAttrId"
	,GoodData_date(cm.Date)  as "Date"
	,GoodData_date(cm.PostDate)  as "PostDate"
	,GoodData_Attr(cm.AddedById) as "AddedByUserId"
	,GoodData_Attr(cm.AddedById) as "AddedByUserName"
	,GoodData_Attr(au.Name) as "AddedByUserNameLabel"
	,GoodData_Attr(cm.LastChangedById) as "ChangedByUserId"
	,GoodData_Attr(cm.LastChangedById) as "ChangedByUserName"
	,GoodData_Attr(eu.Name) as "ChangedByUserNameLabel"
from stg_csv_CreditMemo_merge cm
join stg_csv_User_merge au
	on cm.AddedById = au.UserId and cm.TenantId = au.TenantId
join stg_csv_User_merge eu
	on cm.LastChangedById = eu.UserId and cm.TenantId = eu.TenantId
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_CreditMemos_attr',null,now());
select analyze_statistics('out_CreditMemos_attr')
;