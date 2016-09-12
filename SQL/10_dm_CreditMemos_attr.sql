INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CreditMemos_attr',now(),null);
insert /*+ direct */ into dm_CreditMemos_attr	 
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
t.TenantId as "TenantId",
GoodData_date(DateAdded)  as "DateAdded",
GoodData_date(DateChanged)  as "DateChanged",
GoodData_Attr(CreditMemoId) as "CreditMemoAttrId",
GoodData_date(Date)  as "Date",
GoodData_date(PostDate)  as "PostDate",
GoodData_Attr(AddedByUserId) as "AddedByUserId",
GoodData_Attr(AddedByUserId) as "AddedByUserName",
GoodData_Attr(au.UserName) as "AddedByUserNameLabel",
GoodData_Attr(LastChangedByUserId) as "ChangedByUserId",
GoodData_Attr(LastChangedByUserId) as "ChangedByUserName",
GoodData_Attr(eu.UserName) as "ChangedByUserNameLabel"
from stg_csv_CreditMemos_merge  t
join stg_csv_Users_merge au
  on t.AddedByUserId = au.UsersId and t.TenantId = au.TenantId
join stg_csv_Users_merge eu
  on t.LastChangedByUserId = eu.UsersId and t.TenantId = eu.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_CreditMemos_attr',null,now());
select analyze_statistics('dm_CreditMemos_attr')
;