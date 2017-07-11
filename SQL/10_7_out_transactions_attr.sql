insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_start',null,'out_transactions_attr_transactions');

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_user']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_user']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_start',null,'out_transactions_attr_tmp_user');

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_start',null,'out_transactions_attr_tmp_tableentry');

truncate table wrk_tmp_out_transactions_attr;

insert /*+ direct */ into wrk_tmp_out_transactions_attr
select ij.*,
md5(
COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
COALESCE((PostStatusTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((PostDate)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionTypeTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((EncumbranceStatusTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode1)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode1IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode2)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode2IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode3)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode3IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode4)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode4IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode5)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode5IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((DateAdded)::VARCHAR(1000),'') || '|' ||
COALESCE((DateChanged)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionAttrDistributionId)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionId)::VARCHAR(1000),'') || '|' ||
COALESCE((AddedByUserNameId)::VARCHAR(1000),'') || '|' ||
COALESCE((AddedByUserName)::VARCHAR(1000),'') || '|' ||
COALESCE((LastChangedByUserName)::VARCHAR(1000),'') || '|' ||
COALESCE((Class)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionAttributeId)::VARCHAR(1000),'') || '|' ||
COALESCE((IsBeginningBalance)::VARCHAR(1000),'')
) as _sys_hash  
from (
select
     t.TenantId as "TenantId"
    ,GoodData_Attr(t.PostStatusTranslation) as "PostStatusTranslation"
    ,t.PostDate  as "PostDate"
    ,GoodData_Attr(t.TransactionTypeTranslation) as "TransactionTypeTranslation"
    ,GoodData_Attr(t.EncumbranceStatusTranslation) as "EncumbranceStatusTranslation"
    ,tc1.Description as "TransactionCode1"
    ,case when tc1.IsActive then 'Active' else 'Inactive' end as "TransactionCode1IsActive"
    ,tc2.Description as "TransactionCode2"
    ,case when tc2.IsActive then 'Active' else 'Inactive' end as "TransactionCode2IsActive"
    ,tc3.Description as "TransactionCode3"
    ,case when tc3.IsActive then 'Active' else 'Inactive' end as "TransactionCode3IsActive"
    ,tc4.Description as "TransactionCode4"
    ,case when tc4.IsActive then 'Active' else 'Inactive' end as "TransactionCode4IsActive"
    ,tc5.Description as "TransactionCode5"
    ,case when tc5.IsActive then 'Active' else 'Inactive' end as "TransactionCode5IsActive"
    ,t.DateAdded  as "DateAdded"
    ,t.DateChanged  as "DateChanged"
    ,GoodData_Attr(t.TranDistributionId) as "TransactionAttrDistributionId"
    ,GoodData_Attr(t.TransactionId) as "TransactionId"
    ,GoodData_Attr(t.AddedById) as "AddedByUserNameId"
    ,GoodData_Attr(au.Name) as "AddedByUserName"
    ,GoodData_Attr(eu.Name) as "LastChangedByUserName"
    ,GoodData_Attr(c.Description) as "Class"
    ,GoodData_Attr(t.TransactionId) as "TransactionAttributeId"
    ,GoodData_Attr('false') as "IsBeginningBalance"
    ,t._sys_is_deleted
from ( 
  select * 
    from out_transactions 
   where (_sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'))
         OR (TenantId, TranDistributionId) in 
            (select ids.* 
               from (
                select TenantId, TranDistributionId from out_transactions where (TenantId,classid) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
                union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode1Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
                union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode2Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
                union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode3Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
                union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode4Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
                union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode5Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
                union all select TenantId, TranDistributionId from out_transactions where (TenantId,AddedById) in (select TenantId, UserId from tmp_user where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_user']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_user']}','yyyy-mm-dd hh24:mi:ss.us'))
                union all select TenantId, TranDistributionId from out_transactions where (TenantId,LastChangedById) in (select TenantId, UserId from tmp_user where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_user']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_user']}','yyyy-mm-dd hh24:mi:ss.us'))
                ) ids 
            )  
  ) t
join stg_csv_user_merge au
    on t.AddedById = au.UserId and t.TenantId = au.TenantId and au._sys_is_deleted = false
join stg_csv_user_merge eu
    on t.LastChangedById = eu.UserId and t.TenantId = eu.TenantId  and eu._sys_is_deleted = false
left join stg_csv_tableentry_merge tc1 on t.TransactionCode1Id = tc1.TableEntryId and t.TenantId = tc1.TenantId and tc1._sys_is_deleted = false
left join stg_csv_tableentry_merge tc2 on t.TransactionCode2Id = tc2.TableEntryId and t.TenantId = tc2.TenantId and tc2._sys_is_deleted = false
left join stg_csv_tableentry_merge tc3 on t.TransactionCode3Id = tc3.TableEntryId and t.TenantId = tc3.TenantId and tc3._sys_is_deleted = false
left join stg_csv_tableentry_merge tc4 on t.TransactionCode4Id = tc4.TableEntryId and t.TenantId = tc4.TenantId and tc4._sys_is_deleted = false
left join stg_csv_tableentry_merge tc5 on t.TransactionCode5Id = tc5.TableEntryId and t.TenantId = tc5.TenantId and tc5._sys_is_deleted = false
left join stg_csv_tableentry_merge c on t.ClassId = c.TableEntryId and t.TenantId = c.TenantId and c._sys_is_deleted = false
) ij;


insert /*+ direct */ into wrk_tmp_out_transactions_attr
select ij.*,
md5(
COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
COALESCE((PostStatusTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((PostDate)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionTypeTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((EncumbranceStatusTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode1)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode1IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode2)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode2IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode3)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode3IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode4)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode4IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode5)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode5IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((DateAdded)::VARCHAR(1000),'') || '|' ||
COALESCE((DateChanged)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionAttrDistributionId)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionId)::VARCHAR(1000),'') || '|' ||
COALESCE((AddedByUserNameId)::VARCHAR(1000),'') || '|' ||
COALESCE((AddedByUserName)::VARCHAR(1000),'') || '|' ||
COALESCE((LastChangedByUserName)::VARCHAR(1000),'') || '|' ||
COALESCE((Class)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionAttributeId)::VARCHAR(1000),'') || '|' ||
COALESCE((IsBeginningBalance)::VARCHAR(1000),'')
) as _sys_hash  
from (
select
	t.TenantId as "TenantId"
	,GoodData_Attr(t.PostStatusTranslation) as "PostStatusTranslation"
	,t.PostDate as "PostDate"
	,GoodData_Attr(t.TransactionTypeTranslation) as "TransactionTypeTranslation"
	,GoodData_Attr(t.EncumbranceStatusTranslation) as "EncumbranceStatusTranslation"
        ,GoodData_Attr(tc1.Description) as "TransactionCode1"
	,case when tc1.IsActive then 'Active' else 'Inactive' end as "TransactionCode1IsActive"
	,GoodData_Attr(tc2.Description) as "TransactionCode2"
	,case when tc2.IsActive then 'Active' else 'Inactive' end as "TransactionCode2IsActive"
	,GoodData_Attr(tc3.Description) as "TransactionCode3"
	,case when tc3.IsActive then 'Active' else 'Inactive' end as "TransactionCode3IsActive"
	,GoodData_Attr(tc4.Description) as "TransactionCode4"
	,case when tc4.IsActive then 'Active' else 'Inactive' end as "TransactionCode4IsActive"
	,GoodData_Attr(tc5.Description) as "TransactionCode5"
	,case when tc5.IsActive then 'Active' else 'Inactive' end as "TransactionCode5IsActive"
	,cast(null as varchar(255))  as "DateAdded"
	,cast(null as varchar(255))  as "DateChanged"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionAttrDistributionId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionId"
	,GoodData_Attr(null) as "AddedByUserNameId"
	,GoodData_Attr(null) as "AddedByUserName"
	,GoodData_Attr(null) as "LastChangedByUserName"
	,GoodData_Attr(t.Class) as "Class"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionAttributeId"
	,GoodData_Attr('true') as "IsBeginningBalance"
	,t._sys_is_deleted
from stg_csv_summarizedtransaction_merge t
left join stg_csv_tableentry_merge tc1 on t.TransactionCode1 = tc1.TableEntryId and t.TenantId = tc1.TenantId and tc1._sys_is_deleted = false
left join stg_csv_tableentry_merge tc2 on t.TransactionCode2 = tc2.TableEntryId and t.TenantId = tc2.TenantId and tc2._sys_is_deleted = false
left join stg_csv_tableentry_merge tc3 on t.TransactionCode3 = tc3.TableEntryId and t.TenantId = tc3.TenantId and tc3._sys_is_deleted = false
left join stg_csv_tableentry_merge tc4 on t.TransactionCode4 = tc4.TableEntryId and t.TenantId = tc4.TenantId and tc4._sys_is_deleted = false
left join stg_csv_tableentry_merge tc5 on t.TransactionCode5 = tc5.TableEntryId and t.TenantId = tc5.TenantId and tc5._sys_is_deleted = false
) ij;

select analyze_statistics('wrk_tmp_out_transactions_attr');

truncate table wrk_tmp_out_transactions_attr_diff;

insert into wrk_tmp_out_transactions_attr_diff
select a.*
FROM "wrk_tmp_out_transactions_attr" a
LEFT JOIN (
    SELECT aa."tenantid",aa."TransactionAttrDistributionId",aa._sys_hash
    FROM "wrk_tmp_out_transactions_attr" aa
    JOIN "tmp_out_transactions_attr" bb
    ON
        bb."tenantid" = aa."tenantid" AND bb."TransactionAttrDistributionId" = aa."TransactionAttrDistributionId"
            AND
        aa."_sys_hash" = bb."_sys_hash"
            AND
        bb."_sys_is_deleted" = aa."_sys_is_deleted"
) b ON a._sys_hash = b._sys_hash AND a."tenantid" = b."tenantid" AND a."TransactionAttrDistributionId" = b."TransactionAttrDistributionId"
WHERE b."_sys_hash" IS NULL;

select analyze_statistics('wrk_tmp_out_transactions_attr_diff');

MERGE /* +direct */ INTO tmp_out_transactions_attr o
USING wrk_tmp_out_transactions_attr_diff temp
ON (
    o."TenantId" = temp."TenantId" AND o."TransactionAttrDistributionId" = temp."TransactionAttrDistributionId"
)
WHEN MATCHED THEN UPDATE SET 
    TenantId = temp.TenantId,
    PostStatusTranslation = temp.PostStatusTranslation,
    PostDate = temp.PostDate,
    TransactionTypeTranslation = temp.TransactionTypeTranslation,
    EncumbranceStatusTranslation = temp.EncumbranceStatusTranslation,
    TransactionCode1 = temp.TransactionCode1,
    TransactionCode1IsActive = temp.TransactionCode1IsActive,
    TransactionCode2 = temp.TransactionCode2,
    TransactionCode2IsActive = temp.TransactionCode2IsActive,
    TransactionCode3 = temp.TransactionCode3,
    TransactionCode3IsActive = temp.TransactionCode3IsActive,
    TransactionCode4 = temp.TransactionCode4,
    TransactionCode4IsActive = temp.TransactionCode4IsActive,
    TransactionCode5 = temp.TransactionCode5,
    TransactionCode5IsActive = temp.TransactionCode5IsActive,
    DateAdded = temp.DateAdded,
    DateChanged = temp.DateChanged,
    TransactionAttrDistributionId = temp.TransactionAttrDistributionId,
    TransactionId = temp.TransactionId,
    AddedByUserNameId = temp.AddedByUserNameId,
    AddedByUserName = temp.AddedByUserName,
    LastChangedByUserName = temp.LastChangedByUserName,
    Class = temp.Class,
    TransactionAttributeId = temp.TransactionAttributeId,
    IsBeginningBalance = temp.IsBeginningBalance,
    _sys_is_deleted = temp._sys_is_deleted,
    _sys_hash = temp._sys_hash,
    _sys_updated_at = now()
WHEN NOT MATCHED THEN INSERT
    (
        TenantId,
        PostStatusTranslation,
        PostDate,
        TransactionTypeTranslation,
        EncumbranceStatusTranslation,
        TransactionCode1,
        TransactionCode1IsActive,
        TransactionCode2,
        TransactionCode2IsActive,
        TransactionCode3,
        TransactionCode3IsActive,
        TransactionCode4,
        TransactionCode4IsActive,
        TransactionCode5,
        TransactionCode5IsActive,
        DateAdded,
        DateChanged,
        TransactionAttrDistributionId,
        TransactionId,
        AddedByUserNameId,
        AddedByUserName,
        LastChangedByUserName,
        Class,
        TransactionAttributeId,
        IsBeginningBalance,
        _sys_is_deleted, 
        _sys_hash,
        _sys_updated_at
    )
    VALUES (
        temp.TenantId,
        temp.PostStatusTranslation,
        temp.PostDate,
        temp.TransactionTypeTranslation,
        temp.EncumbranceStatusTranslation,
        temp.TransactionCode1,
        temp.TransactionCode1IsActive,
        temp.TransactionCode2,
        temp.TransactionCode2IsActive,
        temp.TransactionCode3,
        temp.TransactionCode3IsActive,
        temp.TransactionCode4,
        temp.TransactionCode4IsActive,
        temp.TransactionCode5,
        temp.TransactionCode5IsActive,
        temp.DateAdded,
        temp.DateChanged,
        temp.TransactionAttrDistributionId,
        temp.TransactionId,
        temp.AddedByUserNameId,
        temp.AddedByUserName,
        temp.LastChangedByUserName,
        temp.Class,
        temp.TransactionAttributeId,
        temp.IsBeginningBalance,
        temp._sys_is_deleted, 
        temp._sys_hash,
        now()
    );

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_finish',null,'out_transactions_attr_transactions');

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_user']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_user']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_finish',null,'out_transactions_attr_tmp_user');

insert into _sys_load_info (project_id,ts_from, ts_to,event_ts,event_type,gdc_project_id, entity) 
values (null,nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr_tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'),now(),'tmp_finish',null,'out_transactions_attr_tmp_tableentry');
