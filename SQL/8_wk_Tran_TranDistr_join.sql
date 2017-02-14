--check
insert /*+ direct */ into wk_Transactions_TransactionDistribution_Join
select 
 t.TenantId as "TenantId"
,t.TransactionTypeTranslation
,t.Amount as "TAmount"
,t.Reference
,t.JournalId
,t.EncumbranceStatus
,t.EncumbranceStatusTranslation
,t.ReverseDate
,t.ReversedTransactionId
,t.TransactionNumber
,t.SourceRecordId
,t.TransactionId as "TTransactionId"
,t.SourceNumber
,t.SourceType
,t.SourceSystemMask
,t.AddedById
,t.DateAdded
,t.LastChangedById
,t.DateChanged
,t.Deleted as "TDeleted"
,t.BatchId
,t.PostStatus
,t.PostStatusTranslation
,t.AccountId
,t.PostDate
,t.FiscalPeriodId
,t.TransactionType
,tc3.Description as "TransactionCode3Id"
,tc4.Description as "TransactionCode4Id"
,tc5.Description as "TransactionCode5Id"
,td.GrantId
,td.Deleted as "TDDeleted"
,td.TranDistributionId
,td.TransactionId as "TDTransactionId"
,td.Projectid
,td.ClassId
,td.Amount as "TDAmount"
,td.Comment
,tc1.Description as "TransactionCode1Id"
,tc2.Description as "TransactionCode2Id"
,case when tc1.IsActive then 'Active' else 'Inactive' end as "TransactionCode1IsActive"
,case when tc2.IsActive then 'Active' else 'Inactive' end as "TransactionCode2IsActive"
,case when tc3.IsActive then 'Active' else 'Inactive' end as "TransactionCode3IsActive"
,case when tc4.IsActive then 'Active' else 'Inactive' end as "TransactionCode4IsActive"
,case when tc5.IsActive then 'Active' else 'Inactive' end as "TransactionCode5IsActive"
from stg_csv_transaction_merge t
join stg_csv_transactiondistribution_merge td
	on td.TransactionId = t.TransactionId and t.TenantId = td.TenantId
left join stg_csv_tableentry_merge tc1 on td.TransactionCode1Id = tc1.TableEntryId and td.TenantId = tc1.TenantId
left join stg_csv_tableentry_merge tc2 on td.TransactionCode2Id = tc2.TableEntryId and td.TenantId = tc2.TenantId
left join stg_csv_tableentry_merge tc3 on td.TransactionCode3Id = tc3.TableEntryId and td.TenantId = tc3.TenantId
left join stg_csv_tableentry_merge tc4 on td.TransactionCode4Id = tc4.TableEntryId and td.TenantId = tc4.TenantId
left join stg_csv_tableentry_merge tc5 on td.TransactionCode5Id = tc5.TableEntryId and td.TenantId = tc5.TenantId