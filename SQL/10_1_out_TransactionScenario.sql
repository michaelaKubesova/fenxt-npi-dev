insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_TransactionScenario','out_transactions','tmp_start',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#out_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_TransactionScenario','tmp_transaction_scenario','tmp_start',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#tmp_transaction_scenario']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_transaction_scenario']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_TransactionScenario','stg_csv_SummarizedTransaction_merge','tmp_start',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#stg_csv_SummarizedTransaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['stg_csv_SummarizedTransaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'));


truncate table wrk_out_TransactionScenario;
insert /*+ direct */ into wrk_out_TransactionScenario
select 
  t.TenantId as "TenantId"
	,t.TranDistributionId as "TransactionDistributionId"
	,isnull(abs.ScenarioId, '<No budget>') as "ScenarioId"
	,t.FiscalPeriodId as "FiscalPeriodId"
	,t.AccountId as "AccountId"
	,t._sys_is_deleted
 from out_transactions T 
left join tmp_transaction_scenario abs
on  T.AccountId = abs.AccountId 
   and abs.FiscalPeriodId = T.FiscalPeriodId
   and abs.tenantid = t.tenantid
   and abs._sys_is_deleted = false
where   (t.tenantid  ,t.AccountId, t.FiscalPeriodId) in
( select tt.tenantid  ,tt.AccountId, tt.FiscalPeriodId from out_transactions tt
   where (tt._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#out_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01')
          and tt._sys_updated_at <= to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'))
union all
  select td.tenantid  ,td.AccountId, td.FiscalPeriodId from tmp_transaction_scenario td
   where (td._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#tmp_transaction_scenario']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01')
          and td._sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_transaction_scenario']}','yyyy-mm-dd hh24:mi:ss.us'))
)
;

insert /*+ direct */ into wrk_out_TransactionScenario
select
	t.TenantId as "TenantId"
	,1000000000000 + t.SummaryId as "TransactionDistributionId"
	,isnull(abs.ScenarioId, '<No budget>') as "ScenarioId"
	,t.FiscalPeriodId as "FiscalPeriodId"
	,t.AccountId as "AccountId"
	,t._sys_is_deleted
from stg_csv_SummarizedTransaction_merge t	
left join tmp_transaction_scenario abs
on  T.AccountId = abs.AccountId 
   and abs.FiscalPeriodId = T.FiscalPeriodId
   and abs.tenantid = t.tenantid
   and abs._sys_is_deleted = false
where   (t.tenantid  ,t.AccountId, t.FiscalPeriodId) in
( select tt.tenantid  ,tt.AccountId, tt.FiscalPeriodId from stg_csv_SummarizedTransaction_merge tt
   where (tt._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#stg_csv_SummarizedTransaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01')
          and tt._sys_updated_at <= to_timestamp('${LAST_TMP_TS['stg_csv_SummarizedTransaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'))
union all
  select td.tenantid  ,td.AccountId, td.FiscalPeriodId from tmp_transaction_scenario td
   where (td._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#tmp_transaction_scenario']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01')
          and td._sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_transaction_scenario']}','yyyy-mm-dd hh24:mi:ss.us'))
)
;



truncate table wrk_out_TransactionScenario_diff;

insert into wrk_out_TransactionScenario_diff
select a.*
FROM "wrk_out_TransactionScenario" a
LEFT JOIN (
    SELECT aa."tenantid",aa."TransactionDistributionId",aa."ScenarioId",
    aa."FiscalPeriodId",aa."AccountId"
    FROM "wrk_out_TransactionScenario" aa
    JOIN "out_TransactionScenario" bb
    ON
        bb."tenantid" = aa."tenantid" AND bb."TransactionDistributionId" = aa."TransactionDistributionId"
        AND bb."ScenarioId" = aa."ScenarioId" AND bb.FiscalPeriodId <=> aa.FiscalPeriodId
        AND bb.AccountId <=> aa.AccountId AND bb._sys_is_deleted <=> aa._sys_is_deleted
    where bb._sys_is_deleted =false
) b ON  b."tenantid" = a."tenantid" AND b."TransactionDistributionId" = a."TransactionDistributionId"
        AND b."ScenarioId" = a."ScenarioId"
WHERE b."tenantid" IS NULL
;

select analyze_statistics('wrk_out_TransactionScenario_diff');



MERGE /* +direct */ INTO out_TransactionScenario o
USING wrk_out_TransactionScenario_diff temp
ON (
    o."TenantId" = temp."TenantId" AND o."TransactionDistributionId" = temp."TransactionDistributionId"
    AND o."ScenarioId"=temp."ScenarioId"
)
WHEN MATCHED THEN UPDATE SET
    TenantId = temp.TenantId,
    TransactionDistributionId = temp.TransactionDistributionId,
    ScenarioId = temp.ScenarioId,
    FiscalPeriodId = temp.FiscalPeriodId,
    AccountId = temp.AccountId,
    _sys_is_deleted = temp._sys_is_deleted,
    _sys_updated_at = now()
WHEN NOT MATCHED THEN INSERT
    (
        TenantId,
        TransactionDistributionId,
        ScenarioId,
        FiscalPeriodId,
        AccountId,
        _sys_is_deleted,
        _sys_updated_at
    )
    VALUES (
        temp.TenantId,
        temp.TransactionDistributionId,
        temp.ScenarioId,
        temp.FiscalPeriodId,
        temp.AccountId,
        temp._sys_is_deleted,
        now()
    );

select analyze_statistics('out_TransactionScenario')
;

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_TransactionScenario','out_transactions','tmp_finish',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#out_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_TransactionScenario','tmp_transaction_scenario','tmp_finish',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#tmp_transaction_scenario']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_transaction_scenario']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_TransactionScenario','stg_csv_SummarizedTransaction_merge','tmp_finish',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_TransactionScenario#stg_csv_SummarizedTransaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['stg_csv_SummarizedTransaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'));
