insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transaction_scenario_out_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_start',null,'out_transaction_scenario_out_transactions');

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transaction_scenario_tmp_transaction_scenario']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_transaction_scenario']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_start',null,'out_transaction_scenario_tmp_transaction_scenario');

truncate table wrk_out_TransactionScenario;

insert /*+ direct */ into wrk_out_TransactionScenario
select ij.*,
md5(
COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionScenarioId)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionDistributionId)::VARCHAR(1000),'') || '|' ||
COALESCE((ScenarioId)::VARCHAR(1000),'') || '|' ||
COALESCE((FiscalPeriodId)::VARCHAR(1000),'') || '|' ||
COALESCE((AccountId)::VARCHAR(1000),'')) as _sys_hash
from (
select 
     t.TenantId
    ,t.TranDistributionId||'#'||isnull(abs.ScenarioId, '<No budget>') as "TransactionScenarioId"
    ,t.TranDistributionId as "TransactionDistributionId"
    ,isnull(abs.ScenarioId, '<No budget>') as "ScenarioId"
    ,t.FiscalPeriodId
    ,t.AccountId
    ,t._sys_is_deleted
 from out_transactions T 
left join tmp_transaction_scenario abs
on  T.AccountId = abs.AccountId 
   and abs.FiscalPeriodId = T.FiscalPeriodId
   and abs.tenantid = t.tenantid
where (t._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transaction_scenario_out_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and t._sys_updated_at <= to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us')
    or exists (select 1
                from tmp_transaction_scenario ts where T.AccountId = ts.AccountId 
                 and ts.FiscalPeriodId = T.FiscalPeriodId
                 and ts.tenantid = t.tenantid
                 and ts._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transaction_scenario_tmp_transaction_scenario']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and ts._sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_transaction_scenario']}','yyyy-mm-dd hh24:mi:ss.us')
                 )
    )
) ij;


insert /*+ direct */ into wrk_out_TransactionScenario
select ij.*,
md5(
COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionScenarioId)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionDistributionId)::VARCHAR(1000),'') || '|' ||
COALESCE((ScenarioId)::VARCHAR(1000),'') || '|' ||
COALESCE((FiscalPeriodId)::VARCHAR(1000),'') || '|' ||
COALESCE((AccountId)::VARCHAR(1000),'')) as _sys_hash
from (
select 
     t.TenantId as "TenantId"
	,1000000000000 + t.SummaryId||'#'||isnull(abs.ScenarioId, '<No budget>') as "TransactionScenarioId"
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
) ij;

select analyze_statistics('wrk_out_TransactionScenario');

truncate table wrk_out_TransactionScenario_diff;

insert into wrk_out_TransactionScenario_diff
select a.*
FROM "wrk_out_TransactionScenario" a
LEFT JOIN (
    SELECT aa."tenantid",aa."TransactionScenarioId",aa._sys_hash
    FROM "wrk_out_TransactionScenario" aa
    JOIN "out_TransactionScenario_new" bb
    ON
        bb."tenantid" = aa."tenantid" AND bb."TransactionScenarioId" = aa."TransactionScenarioId"
            AND
        aa."_sys_hash" = bb."_sys_hash"
            AND
        bb."_sys_is_deleted" = aa."_sys_is_deleted"
) b ON a._sys_hash = b._sys_hash AND a."tenantid" = b."tenantid" AND a."TransactionScenarioId" = b."TransactionScenarioId"
WHERE b."_sys_hash" IS NULL;

select analyze_statistics('wrk_out_TransactionScenario_diff');
MERGE /* +direct */ INTO out_TransactionScenario_new o
USING wrk_out_TransactionScenario_diff temp
ON (
    o."TenantId" = temp."TenantId" AND o."TransactionScenarioId" = temp."TransactionScenarioId"
)
WHEN MATCHED THEN UPDATE SET 
    TenantId = temp.TenantId,
    TransactionScenarioId = temp.TransactionScenarioId,
    TransactionDistributionId = temp.TransactionDistributionId,
    ScenarioId = temp.ScenarioId,
    FiscalPeriodId = temp.FiscalPeriodId,
    AccountId = temp.AccountId,
    _sys_is_deleted = temp._sys_is_deleted,
    _sys_hash = temp._sys_hash,
    _sys_updated_at = now()
WHEN NOT MATCHED THEN INSERT
    (
        TenantId,
        TransactionScenarioId,
        TransactionDistributionId,
        ScenarioId,
        FiscalPeriodId,
        AccountId,
        _sys_is_deleted, 
        _sys_hash,
        _sys_updated_at
    )
    VALUES (
        temp.TenantId,
        temp.TransactionScenarioId,
        temp.TransactionDistributionId,
        temp.ScenarioId,
        temp.FiscalPeriodId,
        temp.AccountId,
        temp._sys_is_deleted, 
        temp._sys_hash,
        now()
    );

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transaction_scenario_out_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_finish',null,'out_transaction_scenario_out_transactions');

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transaction_scenario_tmp_transaction_scenario']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_transaction_scenario']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_finish',null,'out_transaction_scenario_tmp_transaction_scenario');
