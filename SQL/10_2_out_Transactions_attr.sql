INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_attr',now(),null);
insert /*+ direct */ into out_Transactions_attr
select
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr(t.PostStatusTranslation) as "PostStatusTranslation"
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
from out_transactions t
join stg_csv_user_merge au
	on t.AddedById = au.UserId and t.TenantId = au.TenantId  and au._sys_is_deleted = false
join stg_csv_user_merge eu
	on t.LastChangedById = eu.UserId and t.TenantId = eu.TenantId and eu._sys_is_deleted = false
left join stg_csv_tableentry_merge tc1 on t.TransactionCode1Id = tc1.TableEntryId and t.TenantId = tc1.TenantId and tc1._sys_is_deleted = false
left join stg_csv_tableentry_merge tc2 on t.TransactionCode2Id = tc2.TableEntryId and t.TenantId = tc2.TenantId and tc2._sys_is_deleted = false
left join stg_csv_tableentry_merge tc3 on t.TransactionCode3Id = tc3.TableEntryId and t.TenantId = tc3.TenantId and tc3._sys_is_deleted = false
left join stg_csv_tableentry_merge tc4 on t.TransactionCode4Id = tc4.TableEntryId and t.TenantId = tc4.TenantId and tc4._sys_is_deleted = false
left join stg_csv_tableentry_merge tc5 on t.TransactionCode5Id = tc5.TableEntryId and t.TenantId = tc5.TenantId and tc5._sys_is_deleted = false
left join stg_csv_tableentry_merge c on t.ClassId = c.TableEntryId and t.TenantId = c.TenantId  and c._sys_is_deleted = false
where t._sys_is_deleted = false
;
--union all
insert /*+ direct */ into out_Transactions_attr
select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr(t.PostStatusTranslation) as "PostStatusTranslation"
	,cast(t.PostDate as varchar(255))  as "PostDate"
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
from stg_csv_summarizedtransaction_merge t
left join stg_csv_tableentry_merge tc1 on t.TransactionCode1 = tc1.TableEntryId and t.TenantId = tc1.TenantId and tc1._sys_is_deleted = false
left join stg_csv_tableentry_merge tc2 on t.TransactionCode2 = tc2.TableEntryId and t.TenantId = tc2.TenantId and tc2._sys_is_deleted = false
left join stg_csv_tableentry_merge tc3 on t.TransactionCode3 = tc3.TableEntryId and t.TenantId = tc3.TenantId and tc3._sys_is_deleted = false
left join stg_csv_tableentry_merge tc4 on t.TransactionCode4 = tc4.TableEntryId and t.TenantId = tc4.TenantId and tc4._sys_is_deleted = false
left join stg_csv_tableentry_merge tc5 on t.TransactionCode5 = tc5.TableEntryId and t.TenantId = tc5.TenantId and tc5._sys_is_deleted = false
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_attr',null,now());
select analyze_statistics('out_Transactions_attr')
;