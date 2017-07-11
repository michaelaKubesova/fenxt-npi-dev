INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Grants',now(),null);
insert /*+ direct */ into out_Grants
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
g.TenantId as "TenantId",
	GoodData_Attr(g.GrantId) as "GrantId",
	GoodData_Attr(g.GrantUserId) as "UserId",
	GoodData_Attr(g.Description) as "Description",
	GoodData_Attr(TE.Description) as "Type",
	GoodData_Attr(TES.Description) as "Status",
	cast(g.GrantAmount as decimal(15,2)) as "GrantAmount",
	GoodData_date(g.DateAdded)  as "DateAdded",
	GoodData_date(g.StartDate)  as "StartDate",
	GoodData_date(g.EndDate)  as "EndDate"
from stg_csv_grant_merge g
join stg_csv_TableEntry_merge TE on g.TypeId = te.TableEntryId and g.TenantId = TE.Tenantid
join stg_csv_TableEntry_merge TES on g.StatusId = TES.TableEntryId and g.TenantId = TES.Tenantid
;

INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Grants',null,now());
select analyze_statistics('out_Grants')
;