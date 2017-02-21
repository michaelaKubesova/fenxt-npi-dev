truncate table wk_Transactions_TransactionDistribution_Join;
insert /*+ direct */ into wk_Transactions_TransactionDistribution_Join
select 
 t.TenantId
,t.TransactionTypeTranslation
,t.EncumbranceStatusTranslation
,t.AddedById
,t.DateAdded
,t.LastChangedById
,t.DateChanged
,t.BatchId
,t.PostStatusTranslation
,t.AccountId
,t.PostDate
,t.FiscalPeriodId
,td.GrantId
,td.TranDistributionId
,t.TransactionId
,td.Projectid
,td.ClassId
,td.Amount as "TDAmount"
,td.TransactionCode1Id
,td.TransactionCode2Id
,td.TransactionCode3Id
,td.TransactionCode4Id
,td.TransactionCode5Id
from stg_csv_transaction_merge t
join stg_csv_transactiondistribution_merge td
	on td.TransactionId = t.TransactionId and t.TenantId = td.TenantId;