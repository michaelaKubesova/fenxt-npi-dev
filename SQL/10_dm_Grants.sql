INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Grants',now(),null);
insert /*+ direct */ into dm_Grants
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
g.TenantId as "TenantId",
	GoodData_Attr(g.GrantId) as "GrantId",
	GoodData_Attr(g.GrantUserId) as "UserId",
	cast(g.GrantAmount as decimal(15,2)) as "GrantAmount",
	GoodData_date(g.DateAdded)  as "DateAdded",
	GoodData_date(g.DateChanged)  as "DateChanged" ,
	GoodData_Attr(g.AddedById) as "AddedByUserId",
	GoodData_Attr(g.AddedById) as "AddedByUserName",
	GoodData_Attr(au.Name) as "AddedByUserNameLabel",
	GoodData_Attr(g.LastChangedById) as "ChangedByUserId",
	GoodData_Attr(g.LastChangedById) as "ChangedByUserName",
	GoodData_Attr(eu.Name) as "ChangedByUserNameLabel",
	GoodData_Attr(g.GrantId) as "GrantDateId",
	GoodData_Attr(1) as "Dummy"
from stg_csv_grant_merge g
join stg_csv_user_merge au
	on g.AddedById = au.UserId and g.TenantId = au.TenantId
join stg_csv_user_merge eu
	on g.LastChangedById = eu.UserId and g.TenantId = eu.TenantId
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Grants',null,now());
select analyze_statistics('dm_Grants')
;