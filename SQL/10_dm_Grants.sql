INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Grants',now(),null);
insert /*+ direct */ into dm_Grants
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
t.TenantId as "TenantId",
GoodData_Attr(GrantId) as "GrantId",
GoodData_Attr(nvl(UserId,'0')) as "UserId",
cast(Amount as decimal(15,2)) as "GrantAmount",
GoodData_date(DateAdded)  as "DateAdded",
GoodData_date(DateChanged)  as "DateChanged" ,
GoodData_Attr(AddedByUserId) as "AddedByUserId",
GoodData_Attr(AddedByUserId) as "AddedByUserName",
GoodData_Attr(au.UserName) as "AddedByUserNameLabel",
GoodData_Attr(LastChangedByUserId) as "ChangedByUserId",
GoodData_Attr(LastChangedByUserId) as "ChangedByUserName",
GoodData_Attr(eu.UserName) as "ChangedByUserNameLabel",
GoodData_Attr(GrantId) as "GrantDateId",
GoodData_Attr(1) as "Dummy"
from stg_csv_Grants_merge  t
join stg_csv_Users_merge au
  on t.AddedByUserId = au.UsersId and t.TenantId = au.TenantId
join stg_csv_Users_merge eu
  on t.LastChangedByUserId = eu.UsersId and t.TenantId = eu.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Grants',null,now());
select analyze_statistics('dm_Grants')
;