
select
 "DateAdded",
 "DateChanged",
 "DateDeleted",
 "DateApproved",
 "BatchId",
 "BatchNumber",
 GoodData_Attr('{"state":"ledger.journalentry.detail","id":'||BatchId||'}') "BatchNumberHyperlink",
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
