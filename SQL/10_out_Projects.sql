INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Projects',now(),null);
insert /*+ direct */ into out_Projects
	select   
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
p.TenantId as "TenantId",	
	 GoodData_Attr(p.ProjectId) as "ProjectId"
	,GoodData_Attr(p.UserId) as "UserId"
	,GoodData_Attr(p.Description) as "Description"
	,GoodData_Attr(nvl(div.Description, 'No Division')) as "Division"
	,GoodData_Attr(nvl(loc.Description,'No Location')) as "Location"
	,GoodData_Attr(nvl(dep.Description,'No Department')) as "Department"
	,GoodData_date(p.DateAdded)  as "DateAdded"
	,GoodData_date(p.DateChanged)  as "DateChanged"
	,GoodData_Attr(p.AddedById) as "AddedByUserName"
	,GoodData_Attr(au.Name) as "AddedByUserNameLabel"
	,GoodData_Attr(nvl(typ.Description, 'No Type')) as "ProjectType"
	,GoodData_Attr(p.ProjectId) as "ProjectDateId"
	,GoodData_Attr(p.ActiveFlagTranslation) as "ProjectStatus"
	,GoodData_Attr(1) as "Dummy"
from stg_csv_project_merge p
join stg_csv_user_merge au
	on p.AddedById = au.UserId and p.TenantId = au.TenantId
left join stg_csv_tableentry_merge div
	on p.DivisionId = div.TableEntryId and p.TenantId = div.TenantId
left join stg_csv_tableentry_merge loc
	on p.LocationId = loc.TableEntryId and p.TenantId = loc.TenantId
left join stg_csv_tableentry_merge dep
	on p.DepartmentId = dep.TableEntryId and p.TenantId = dep.TenantId
left join stg_csv_tableentry_merge typ
	on p.TypeId = typ.TableEntryId and p.TenantId = typ.TenantId
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Projects',null,now());
select analyze_statistics('out_Projects')
;