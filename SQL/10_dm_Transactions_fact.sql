INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_fact',now(),null);
insert /*+ direct */ into dm_Transactions_fact
select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr(td.TranDistributionId) as "TransactionDistributionId"
	,GoodData_Attr(td.TranDistributionId)  as "TransactionAttrDistributionId"
	,GoodData_Attr(t.AccountId)  as "AccountId"
	,GoodData_Attr(nvl(td.ProjectId,-1))  as "ProjectId"
	,GoodData_Attr(nvl(td.GrantId,0)) as "GrantId"
	,GoodData_Attr(t.FiscalPeriodId)  as "FiscalPeriodId"
	,cast(td.Amount as decimal(15, 2)) as "TransactionAmount"
	,GoodData_Attr(nvl(t.BatchId,'0')) as "BatchId"
	,GoodData_Date(t.DateAdded) as "DateAdded"
	,GoodData_Date(t.DateChanged) as "DateChanged"
from stg_csv_transaction_merge t
join stg_csv_transactiondistribution_merge td
	on t.TransactionId = td.TransactionId and t.TenantId = td.TenantId
where t.Deleted = false
	and td.Deleted = false
	and t._sys_is_deleted = false
	and td._sys_is_deleted = false

union all

select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	st.TenantId as "TenantId",
	 GoodData_Attr(1000000000000 + st.SummaryId) as "TransactionDistributionId"
	,GoodData_Attr(1000000000000 + st.SummaryId)  as "TransactionAttrDistributionId"
	,GoodData_Attr(st.AccountId)  as "AccountId"
	,GoodData_Attr(nvl(st.ProjectId,-1))  as "ProjectId"
	,GoodData_Attr(0) as "GrantId"
	,GoodData_Attr(st.FiscalPeriodId)  as "FiscalPeriodId"
	,cast(st.Amount as decimal(15, 2)) as "TransactionAmount"
	,GoodData_Attr('0') as "BatchId"
	,GoodData_Date(null) as "DateAdded"
	,GoodData_Date(null) as "DateChanged"
from stg_csv_summarizedtransaction_merge st
where st._sys_is_deleted = false
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_fact',null,now());
select analyze_statistics('dm_Transactions_fact')
;
