INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_fact',now(),null);
insert /*+ direct */ into dm_Transactions_fact
select   
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
TenantId as "TenantId",
GoodData_Attr(TransactionDistributionId) as "TransactionDistributionId",
 GoodData_Attr(TransactionDistributionId)  as "TransactionAttrDistributionId",
 GoodData_Attr(AccountId)  as "AccountId",
 GoodData_Attr(nvl(ProjectId,-1))  as "ProjectId",
 GoodData_Attr(nvl(GrantId,0)) as "GrantId",
 GoodData_Attr(FiscalPeriodId)  as "FiscalPeriodId",
cast(Amount as decimal(15, 2)) as "TransactionAmount",
 GoodData_Attr(nvl(BatchId,'0')) as "BatchId",
GoodData_Date(DateAdded) as "DateAdded",
GoodData_Date(DateChanged) as "DateChanged"
from stg_csv_Transactions_merge
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_fact',null,now());
select analyze_statistics('dm_Transactions_fact')
;
