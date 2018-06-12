insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transaction_merge','wrk_start',now(),nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_transaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transactiondistribution_merge','wrk_start',now(),nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transactiondistribution_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_transactiondistribution_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

truncate table wrk_transactions;

insert /*+ direct */ into wrk_transactions
select ij.*,false,
md5 (
COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionTypeTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((EncumbranceStatusTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((AddedById)::VARCHAR(1000),'') || '|' ||
COALESCE((DateAdded)::VARCHAR(1000),'') || '|' ||
COALESCE((LastChangedById)::VARCHAR(1000),'') || '|' ||
COALESCE((DateChanged)::VARCHAR(1000),'') || '|' ||
COALESCE((BatchId)::VARCHAR(1000),'') || '|' ||
COALESCE((PostStatusTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((AccountId)::VARCHAR(1000),'') || '|' ||
COALESCE((PostDate)::VARCHAR(1000),'') || '|' ||
COALESCE((FiscalPeriodId)::VARCHAR(1000),'') || '|' ||
COALESCE((GrantId)::VARCHAR(1000),'') || '|' ||
COALESCE((TranDistributionId)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionId)::VARCHAR(1000),'') || '|' ||
COALESCE((Projectid)::VARCHAR(1000),'') || '|' ||
COALESCE((ClassId)::VARCHAR(1000),'') || '|' ||
COALESCE((TDAmount)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode1Id)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode2Id)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode3Id)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode4Id)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode5Id)::VARCHAR(1000),'')) as _sys_hash  
from (
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
    on td.TransactionId = t.TransactionId and t.TenantId = td.TenantId and t._sys_is_deleted = false and td._sys_is_deleted = false
where   (t.TenantId  ,t.TransactionId) in
( select t.TenantId  ,t.TransactionId from stg_csv_transaction_merge t
   where (t._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01')
          and t._sys_updated_at <= to_timestamp('${LAST_TS['stg_csv_transaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'))
union all
  select td.TenantId  ,td.TransactionId from stg_csv_transactiondistribution_merge td 
   where (td._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transactiondistribution_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01')
          and td._sys_updated_at <= to_timestamp('${LAST_TS['stg_csv_transactiondistribution_merge']}','yyyy-mm-dd hh24:mi:ss.us'))
)
) ij;

select analyze_statistics('wrk_transactions');

truncate table wrk_transactions_diff;

insert into wrk_transactions_diff
select a.*
FROM "wrk_transactions" a
LEFT JOIN (
    SELECT aa."tenantid",aa."TranDistributionId",aa._sys_hash
    FROM "wrk_transactions" aa
    JOIN "out_transactions" bb
    ON
        bb."tenantid" = aa."tenantid" AND bb."TranDistributionId" = aa."TranDistributionId"
            AND
        aa."_sys_hash" = bb."_sys_hash"
            AND
        bb."_sys_is_deleted" = false
) b ON a._sys_hash = b._sys_hash AND a."tenantid" = b."tenantid" AND a."TranDistributionId" = b."TranDistributionId"
WHERE b."_sys_hash" IS NULL;

select analyze_statistics('wrk_transactions_diff');

MERGE /* +direct */ INTO out_transactions o
USING wrk_transactions_diff temp
ON (
    o."TenantId" = temp."TenantId" AND o."TranDistributionId" = temp."TranDistributionId"
)
WHEN MATCHED THEN UPDATE SET 
    TenantId = temp.TenantId,
    TransactionTypeTranslation = temp.TransactionTypeTranslation,
    EncumbranceStatusTranslation = temp.EncumbranceStatusTranslation,
    AddedById = temp.AddedById,
    DateAdded = temp.DateAdded,
    LastChangedById = temp.LastChangedById,
    DateChanged = temp.DateChanged,
    BatchId = temp.BatchId,
    PostStatusTranslation = temp.PostStatusTranslation,
    AccountId = temp.AccountId,
    PostDate = temp.PostDate,
    FiscalPeriodId = temp.FiscalPeriodId,
    GrantId = temp.GrantId,
    TranDistributionId = temp.TranDistributionId,
    TransactionId = temp.TransactionId,
    Projectid = temp.Projectid,
    ClassId = temp.ClassId,
    TDAmount = temp.TDAmount,
    TransactionCode1Id = temp.TransactionCode1Id,
    TransactionCode2Id = temp.TransactionCode2Id,
    TransactionCode3Id = temp.TransactionCode3Id,
    TransactionCode4Id = temp.TransactionCode4Id,
    TransactionCode5Id = temp.TransactionCode5Id,
    _sys_is_deleted = temp._sys_is_deleted,
    _sys_hash = temp._sys_hash,
    _sys_updated_at = now()
WHEN NOT MATCHED THEN INSERT
    (
        TenantId, 
        TransactionTypeTranslation, 
        EncumbranceStatusTranslation, 
        AddedById, 
        DateAdded, 
        LastChangedById, 
        DateChanged, 
        BatchId, 
        PostStatusTranslation, 
        AccountId, 
        PostDate, 
        FiscalPeriodId, 
        GrantId, 
        TranDistributionId, 
        TransactionId, 
        Projectid, 
        ClassId, 
        TDAmount, 
        TransactionCode1Id, 
        TransactionCode2Id, 
        TransactionCode3Id, 
        TransactionCode4Id, 
        TransactionCode5Id, 
        _sys_is_deleted, 
        _sys_hash,
        _sys_updated_at
    )
    VALUES (
        temp.TenantId, 
        temp.TransactionTypeTranslation, 
        temp.EncumbranceStatusTranslation, 
        temp.AddedById, 
        temp.DateAdded, 
        temp.LastChangedById, 
        temp.DateChanged, 
        temp.BatchId, 
        temp.PostStatusTranslation, 
        temp.AccountId, 
        temp.PostDate, 
        temp.FiscalPeriodId, 
        temp.GrantId, 
        temp.TranDistributionId, 
        temp.TransactionId, 
        temp.Projectid, 
        temp.ClassId, 
        temp.TDAmount, 
        temp.TransactionCode1Id, 
        temp.TransactionCode2Id, 
        temp.TransactionCode3Id, 
        temp.TransactionCode4Id, 
        temp.TransactionCode5Id, 
        temp._sys_is_deleted, 
        temp._sys_hash,
        now()
    );

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transaction_merge','wrk_finish',now(),nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_transaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transactiondistribution_merge','wrk_finish',now(),nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transactiondistribution_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_transactiondistribution_merge']}','yyyy-mm-dd hh24:mi:ss.us'));
