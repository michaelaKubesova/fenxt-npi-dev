SELECT 
	TranDistributionId AS Id,
	round(row_number() over (partition by 1)/5000)::int AS bucket
FROM  dm_Transactions_fact_delete 
WHERE TenantId = '${TenantId}'
  AND _sys_updated_at > to_timestamptz('${transaction_attr_TS_FROM}', 'yyyy-mm-dd hh24:mi:ss.us')
  AND _sys_updated_at <= to_timestamptz('${transaction_attr_TS_TO}', 'yyyy-mm-dd hh24:mi:ss.us')