insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('tmp_user','stg_csv_user_merge','wrk_start',now(),nvl(to_timestamp(nullif('${PREV_TS['tmp_user#stg_csv_user_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_user_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

truncate table wrk_tmp_user;

insert /*+ direct */ into wrk_tmp_user
select ij.*,false,
md5(
COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
COALESCE((userId)::VARCHAR(1000),'') || '|' ||
COALESCE((name)::VARCHAR(1000),'') ) as _sys_hash  
from (
select
 t.TenantId
,t.userId
,t.name
from stg_csv_user_merge t
where t._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS['tmp_user#stg_csv_user_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and t._sys_updated_at <= to_timestamp('${LAST_TS['stg_csv_user_merge']}','yyyy-mm-dd hh24:mi:ss.us')
) ij;

select analyze_statistics('wrk_tmp_user');

truncate table wrk_tmp_user_diff;

insert into wrk_tmp_user_diff
select a.*
FROM "wrk_tmp_user" a
LEFT JOIN (
    SELECT aa."tenantid",aa."userId",aa._sys_hash
    FROM "wrk_tmp_user" aa
    JOIN "tmp_user" bb
    ON
        bb."tenantid" = aa."tenantid" AND bb."userId" = aa."userId"
            AND
        aa."_sys_hash" = bb."_sys_hash"
            AND
        bb."_sys_is_deleted" = false
) b ON a._sys_hash = b._sys_hash AND a."tenantid" = b."tenantid" AND a."userId" = b."userId"
WHERE b."_sys_hash" IS NULL;

MERGE /* +direct */ INTO tmp_user o
USING wrk_tmp_user_diff temp
ON (
    o."TenantId" = temp."TenantId" AND o."userId" = temp."userId"
)
WHEN MATCHED THEN UPDATE SET 
    TenantId = temp.TenantId,
    userId = temp.userId,
    name = temp.name,
    _sys_is_deleted = temp._sys_is_deleted,
    _sys_hash = temp._sys_hash,
    _sys_updated_at = now()
WHEN NOT MATCHED THEN INSERT
    (
        TenantId, 
        userId, 
        name, 
        _sys_is_deleted, 
        _sys_hash,
        _sys_updated_at
    )
    VALUES (
        temp.TenantId, 
        temp.userId, 
        temp.name, 
        temp._sys_is_deleted, 
        temp._sys_hash,
        now()
    );

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('tmp_user','stg_csv_user_merge','wrk_finish',now(),nvl(to_timestamp(nullif('${PREV_TS['tmp_user#stg_csv_user_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_user_merge']}','yyyy-mm-dd hh24:mi:ss.us'));
