CREATE or replace VIEW dm_Transactions_fact AS
select
	t.TenantId as "TenantId",
	 GoodData_Attr(t.TranDistributionId) as "TransactionDistributionId"
	,GoodData_Attr(t.TranDistributionId)  as "TransactionAttrDistributionId"
	,GoodData_Attr(t.AccountId)  as "AccountId"
	,GoodData_Attr(nvl(t.ProjectId,'-1'))  as "ProjectId"
	,GoodData_Attr(nvl(t.GrantId,'0')) as "GrantId"
	,GoodData_Attr(t.FiscalPeriodId)  as "FiscalPeriodId"
	,cast(t.TDAmount as decimal(15, 2)) as "TransactionAmount"
	,GoodData_Attr(nvl(t.BatchId,'0')) as "BatchId"
	,GoodData_Date(t.DateAdded) as "DateAdded"
	,GoodData_Date(t.DateChanged) as "DateChanged"
	,_sys_updated_at
from out_transactions t
where _sys_is_deleted = false
union all
select
	st.TenantId as "TenantId",
	 GoodData_Attr(1000000000000 + st.SummaryId) as "TransactionDistributionId"
	,GoodData_Attr(1000000000000 + st.SummaryId)  as "TransactionAttrDistributionId"
	,GoodData_Attr(st.AccountId)  as "AccountId"
	,GoodData_Attr(nvl(st.ProjectId,'-1'))  as "ProjectId"
	,GoodData_Attr('0') as "GrantId"
	,GoodData_Attr(st.FiscalPeriodId)  as "FiscalPeriodId"
	,cast(st.Amount as decimal(15, 2)) as "TransactionAmount"
	,GoodData_Attr('0') as "BatchId"
	,null::date as "DateAdded"
	,null::date as "DateChanged"
	,_sys_updated_at
from stg_csv_summarizedtransaction_merge st
where _sys_is_deleted = false
;



CREATE or replace VIEW dm_Transactions_fact_delete 
AS
SELECT out_Transactions.TranDistributionId,
out_Transactions.TenantId,
out_Transactions._sys_updated_at
FROM out_Transactions
 WHERE (out_Transactions._sys_is_deleted = true)
  UNION ALL 
   SELECT (1000000000000 + st.SummaryId) 
  AS TranDistributionId,
  st.TenantId,
  st._sys_updated_at
  FROM stg_csv_SummarizedTransaction_merge st
   WHERE (st._sys_is_deleted = true);