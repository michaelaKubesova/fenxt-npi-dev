insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('tmp_tableentry','stg_csv_tableentry_merge','wrk_start',now(),nvl(to_timestamp(nullif('${PREV_TS['tmp_tableentry#stg_csv_tableentry_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_tableentry_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

truncate table wrk_tmp_tableentry;

insert /*+ direct */ into wrk_tmp_tableentry
select ij.*,false,
md5(
COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
COALESCE((TableEntryId)::VARCHAR(1000),'') || '|' ||
COALESCE((IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((Description)::VARCHAR(1000),'')) as _sys_hash  
from (
select
 t.TenantId
,t.TableEntryId
,t.IsActive
,t.Description
from stg_csv_tableentry_merge t
where t._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS['tmp_tableentry#stg_csv_tableentry_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and t._sys_updated_at <= to_timestamp('${LAST_TS['stg_csv_tableentry_merge']}','yyyy-mm-dd hh24:mi:ss.us')
) ij;

select analyze_statistics('wrk_tmp_tableentry');

truncate table wrk_tmp_tableentry_diff;

insert into wrk_tmp_tableentry_diff
select a.*
FROM "wrk_tmp_tableentry" a
LEFT JOIN (
    SELECT aa."tenantid",aa."TableEntryId",aa._sys_hash
    FROM "wrk_tmp_tableentry" aa
    JOIN "tmp_tableentry" bb
    ON
        bb."tenantid" = aa."tenantid" AND bb."TableEntryId" = aa."TableEntryId"
            AND
        aa."_sys_hash" = bb."_sys_hash"
            AND
        bb."_sys_is_deleted" = false
) b ON a._sys_hash = b._sys_hash AND a."tenantid" = b."tenantid" AND a."TableEntryId" = b."TableEntryId"
WHERE b."_sys_hash" IS NULL;

MERGE /* +direct */ INTO tmp_tableentry o
USING wrk_tmp_tableentry_diff temp
ON (
    o."TenantId" = temp."TenantId" AND o."TableEntryId" = temp."TableEntryId"
)
WHEN MATCHED THEN UPDATE SET 
    TenantId = temp.TenantId,
    TableEntryId = temp.TableEntryId,
    IsActive = temp.IsActive,
    Description = temp.Description,
    _sys_is_deleted = temp._sys_is_deleted,
    _sys_hash = temp._sys_hash,
    _sys_updated_at = now()
WHEN NOT MATCHED THEN INSERT
    (
        TenantId, 
        TableEntryId, 
        IsActive, 
        Description,
        _sys_is_deleted, 
        _sys_hash,
        _sys_updated_at
    )
    VALUES (
        temp.TenantId, 
        temp.TableEntryId, 
        temp.IsActive, 
        temp.Description,
        temp._sys_is_deleted, 
        temp._sys_hash,
        now()
    );

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('tmp_tableentry','stg_csv_tableentry_merge','wrk_finish',now(),nvl(to_timestamp(nullif('${PREV_TS['tmp_tableentry#stg_csv_tableentry_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_tableentry_merge']}','yyyy-mm-dd hh24:mi:ss.us'));
