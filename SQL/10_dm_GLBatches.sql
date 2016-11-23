INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_GLBatches',now(),null);
insert /*+ direct */ into dm_GLBatches
select  
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	b.TenantId as "TenantId",
	 GoodData_date(b.DateAdded)  as "DateAdded"
	,GoodData_date(b.DateChanged)  as "DateChanged"
	,GoodData_date(b.DateDeleted) as "DateDeleted"
	,GoodData_date(b.DateApproved) as "DateApproved"
	,GoodData_Attr(b.BatchId) as "BatchId"
	,GoodData_Attr(b.BatchNumber) as "BatchNumber"
	,GoodData_Attr(b.StatusTranslation) as "StatusTranslation"
	,GoodData_Attr(b.AddedById) as "AddedByUserName"
	,GoodData_Attr(au.Name) as "AddedByUserNameLabel"
	,GoodData_Attr(eu.Name) as "ChangedByUserNameLabel"
	,GoodData_Attr(du.Name) as "DeletedByNameLabel"
	,GoodData_Attr(apu.Name) as "ApprovedByUserNameLabel"
	,GoodData_Attr(b.BatchId) as "BatchDateId"
 	,GoodData_Attr('batch/'||b.BatchId||'?tenantid='||'{$TenantId}') as "BatchHyperlink"
from stg_csv_GLBatch_merge b
join stg_csv_User_merge au
  on b.AddedById = au.UserId and b.TenantId = au.TenantId
join stg_csv_User_merge eu
  on b.LastChangedById = eu.UserId and b.TenantId = eu.TenantId
left join stg_csv_User_merge du
  on b.DeletedById = du.UserId and b.TenantId = du.TenantId
left join stg_csv_User_merge apu
  on b.ApprovedById = apu.UserId and b.TenantId = apu.TenantId
where b.StatusTranslation != 'System Batch'
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_GLBatches',null,now());
select analyze_statistics('dm_GLBatches')
;