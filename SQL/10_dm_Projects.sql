INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Projects',now(),null);
insert /*+ direct */ into dm_Projects
	select   
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	GoodData_Attr(ProjectId) as "ProjectId",
	GoodData_Attr(UserId) as "UserId",
	GoodData_Attr(t.Description) as "Description",
	GoodData_Attr(nvl(Division, 'No Division')) as "Division",
	GoodData_Attr(nvl(Location,'No Location')) as "Location",
	GoodData_Attr(nvl(Department,'No Department')) as "Department",
	GoodData_date(DateAdded)  as "DateAdded",
	GoodData_date(DateChanged)  as "DateChanged",
	GoodData_Attr(AddedByUserId) as "AddedByUserName",
	GoodData_Attr(au.UserName) as "AddedByUserNameLabel",
	GoodData_Attr(nvl(t.Type, 'No Type')) as "ProjectType",
	GoodData_Attr(ProjectId) as "ProjectDateId",
	GoodData_Attr(1) as "Dummy"
	from stg_csv_Projects_merge  t
	join stg_csv_Users_merge au
	  on t.AddedByUserId = au.UsersId and t.TenantId = au.TenantId
	join stg_csv_Users_merge eu
	  on t.LastChangedByUserId = eu.UsersId and t.TenantId = eu.TenantId
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Projects',null,now());
select analyze_statistics('dm_Projects')
;