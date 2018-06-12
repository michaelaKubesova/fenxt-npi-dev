insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transaction_merge','wrk_start_delete',now(),nvl(to_timestamp(nullif('${PREV_TS_DELETE['out_transactions#stg_csv_transaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS_DELETE['stg_csv_transaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transactiondistribution_merge','wrk_start_delete',now(),nvl(to_timestamp(nullif('${PREV_TS_DELETE['out_transactions#stg_csv_transactiondistribution_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS_DELETE['stg_csv_transactiondistribution_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

update out_transactions
set _sys_is_deleted = true, _sys_updated_at = now()
where (tenantid,TranDistributionId) in
(select tenantid,TranDistributionId 
   from stg_csv_transactiondistribution_merge
  where _sys_is_deleted = true
    and (_sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS_DELETE['out_transactions#stg_csv_transactiondistribution_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TS_DELETE['stg_csv_transactiondistribution_merge']}','yyyy-mm-dd hh24:mi:ss.us'))
  );

update out_transactions
set _sys_is_deleted = true, _sys_updated_at = now()
where (tenantid,TransactionId) in
(select tenantid,TransactionId 
   from stg_csv_transaction_merge
  where _sys_is_deleted = true
    and (_sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS_DELETE['out_transactions#stg_csv_transaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TS_DELETE['stg_csv_transaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'))
  );

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transaction_merge','wrk_finish_delete',now(),nvl(to_timestamp(nullif('${PREV_TS_DELETE['out_transactions#stg_csv_transaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS_DELETE['stg_csv_transaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transactiondistribution_merge','wrk_finish_delete',now(),nvl(to_timestamp(nullif('${PREV_TS_DELETE['out_transactions#stg_csv_transactiondistribution_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS_DELETE['stg_csv_transactiondistribution_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

