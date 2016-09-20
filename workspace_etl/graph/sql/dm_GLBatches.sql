
select
 "DateAdded",
 "DateChanged",
 "DateDeleted",
 "DateApproved",
 "BatchId",
 "BatchNumber",
 "StatusTranslation",
 "AddedByUserName",
 "AddedByUserNameLabel",
 "ChangedByUserNameLabel",
 "DeletedByNameLabel",
 "ApprovedByUserNameLabel",
 "BatchDateId",
 "BatchHyperlink"
from dm_GLBatches
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_GLBATCHES_TRANSFORM_ID}