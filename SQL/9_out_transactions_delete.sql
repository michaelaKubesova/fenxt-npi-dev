insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TS_DELETE['dm_transactions_Transaction']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS_DELETE['Transaction']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'wrk_start_delete',null,'dm_transactions_Transaction');

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TS_DELETE['dm_transactions_TransactionDistribution']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS_DELETE['TransactionDistribution']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'wrk_start_delete',null,'dm_transactions_TransactionDistribution');

update out_transactions
set _sys_is_deleted = true, _sys_updated_at = now()
where (tenantid,TranDistributionId) in
(select tenantid,TranDistributionId 
   from stg_csv_transactiondistribution_merge
  where _sys_is_deleted = true
    and (_sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS_DELETE['dm_transactions_TransactionDistribution']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TS_DELETE['TransactionDistribution']}','yyyy-mm-dd hh24:mi:ss.us'))
  );

update out_transactions
set _sys_is_deleted = true, _sys_updated_at = now()
where (tenantid,TransactionId) in
(select tenantid,TransactionId 
   from stg_csv_transaction_merge
  where _sys_is_deleted = true
    and (_sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS_DELETE['dm_transactions_Transaction']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TS_DELETE['Transaction']}','yyyy-mm-dd hh24:mi:ss.us'))
  );

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TS_DELETE['dm_transactions_Transaction']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS_DELETE['Transaction']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'wrk_finish_delete',null,'dm_transactions_Transaction');

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TS_DELETE['dm_transactions_TransactionDistribution']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS_DELETE['TransactionDistribution']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'wrk_finish_delete',null,'dm_transactions_TransactionDistribution');

