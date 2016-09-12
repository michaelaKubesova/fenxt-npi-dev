INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_GLBatches',now(),null);
insert /*+ direct */ into dm_GLBatches
select  
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	GoodData_date(DateAdded)  as "DateAdded",
	GoodData_date(DateChanged)  as "DateChanged",
	GoodData_date(DateDeleted) as "DateDeleted",
	GoodData_date(DateApproved) as "DateApproved",
	GoodData_Attr(BatchId) as "BatchId",
	GoodData_Attr(BatchNumber) as "BatchNumber",
	GoodData_Attr(StatusTranslation) as "StatusTranslation",
	GoodData_Attr(AddedByUserId) as "AddedByUserName",
	GoodData_Attr(au.UserName) as "AddedByUserNameLabel",
	GoodData_Attr(eu.UserName) as "ChangedByUserNameLabel",
	GoodData_Attr(du.UserName) as "DeletedByNameLabel",
	GoodData_Attr(apu.UserName) as "ApprovedByUserNameLabel",
	GoodData_Attr(BatchId) as "BatchDateId",
 	GoodData_Attr('batch/'||BatchId||'?tenantid='|| t.TenantId) as "BatchHyperlink"
from stg_csv_GLBatches_merge t
join stg_csv_Users_merge au
  on t.AddedByUserId = au.UsersId and t.TenantId = au.TenantId
join stg_csv_Users_merge eu
  on t.LastChangedByUserId = eu.UsersId and t.TenantId = eu.TenantId
left join stg_csv_Users_merge du
  on t.DeletedById = du.UsersId and t.TenantId = du.TenantId
left join stg_csv_Users_merge apu
  on t.ApprovedById = apu.UsersId and t.TenantId = apu.TenantId
	where t.StatusTranslation != 'System Batch'
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_GLBatches',null,now());
select analyze_statistics('dm_GLBatches')
;