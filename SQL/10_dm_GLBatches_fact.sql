insert into _sys_transform_id (id,entity,ts_start,ts_end) values (-1,'dm_GLBatches_fact',now(),null);
insert /*+ direct */ into dm_GLBatches_fact
select
	-1 as _sys_transform_id,
	B.TenantId as "TenantId",
	 GoodData_Attr(B.BatchId) as "BatchFactId"
	,GoodData_Attr(B.BatchId) as "BatchId"
	,cast(isnull(SUM(case when T.TransactionTypeTranslation = 'Debit' then T.Amount else null end), 0) as decimal(15,2)) as "DebitAmount"
	,cast(isnull(SUM(case when T.TransactionTypeTranslation = 'Credit' then T.Amount else null end), 0) as decimal(15,2)) as "CreditAmount"
	,GoodData_date(B.DateAdded) as "DateAdded"
	,GoodData_date(B.DateChanged) as "DateChanged"
	,GoodData_date(B.DateApproved) as "DateApproved"
	,GoodData_date(B.DateDeleted) as "DateDeleted"
from stg_csv_GLBatch_merge B
left join stg_csv_Transaction_merge T on T.BatchId = B.BatchId and T.TenantId = B.TenantId and T._sys_is_deleted = false and T.Deleted = false
where B._sys_is_deleted = false
	and B.Deleted = false
group by B.BatchId, B.DateAdded, B.DateChanged, B.DateApproved, B.DateDeleted, B.TenantId
;
insert into _sys_transform_id (id,entity,ts_start,ts_end) values (-1,'dm_GLBatches_fact',null,now());
select analyze_statistics('dm_GLBatches_fact')
;