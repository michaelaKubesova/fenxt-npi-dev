INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_Transactions_attr',now(),null);
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
from wk_Transactions_TransactionDistribution_join t
join stg_csv_user_merge au
	on t.AddedById = au.UserId and t.TenantId = au.TenantId 
join stg_csv_user_merge eu
	on t.LastChangedById = eu.UserId and t.TenantId = eu.TenantId
left join stg_csv_tableentry_merge tc1 on t.TransactionCode1Id = tc1.TableEntryId and t.TenantId = tc1.TenantId
left join stg_csv_tableentry_merge tc2 on t.TransactionCode2Id = tc2.TableEntryId and t.TenantId = tc2.TenantId
left join stg_csv_tableentry_merge tc3 on t.TransactionCode3Id = tc3.TableEntryId and t.TenantId = tc3.TenantId
left join stg_csv_tableentry_merge tc4 on t.TransactionCode4Id = tc4.TableEntryId and t.TenantId = tc4.TenantId
left join stg_csv_tableentry_merge tc5 on t.TransactionCode5Id = tc5.TableEntryId and t.TenantId = tc5.TenantId
left join stg_csv_tableentry_merge c on t.ClassId = c.TableEntryId and t.TenantId = c.TenantId
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
,GoodData_Attr((select tc1.Description from stg_csv_tableentry_merge tc1 where t.TransactionCode1 = cast(tc1.TableEntryId as varchar) and t.TenantId = tc1.TenantId )) as "TransactionCode1"
	,case when (select tc1.IsActive from stg_csv_tableentry_merge tc1 where t.TransactionCode1 = cast(tc1.TableEntryId as varchar) and t.TenantId = tc1.TenantId ) then 'Active' else 'Inactive' end as "TransactionCode1IsActive"
	,GoodData_Attr((select tc2.Description from stg_csv_tableentry_merge tc2 where t.TransactionCode2 = cast(tc2.TableEntryId as varchar) and t.TenantId = tc2.TenantId)) as "TransactionCode2"
	,case when (select tc2.IsActive from stg_csv_tableentry_merge tc2 where t.TransactionCode2 = cast(tc2.TableEntryId as varchar) and t.TenantId = tc2.TenantId ) then 'Active' else 'Inactive' end as "TransactionCode2IsActive"
	,GoodData_Attr((select tc3.Description from stg_csv_tableentry_merge tc3 where t.TransactionCode3 = cast(tc3.TableEntryId as varchar) and t.TenantId = tc3.TenantId )) as "TransactionCode3"
	,case when (select tc3.IsActive from stg_csv_tableentry_merge tc3 where t.TransactionCode3 = cast(tc3.TableEntryId as varchar) and t.TenantId = tc3.TenantId ) then 'Active' else 'Inactive' end as "TransactionCode3IsActive"
	,GoodData_Attr((select tc4.Description from stg_csv_tableentry_merge tc4 where t.TransactionCode4 = cast(tc4.TableEntryId as varchar) and t.TenantId = tc4.TenantId )) as "TransactionCode4"
	,case when (select tc4.IsActive from stg_csv_tableentry_merge tc4 where t.TransactionCode4 = cast(tc4.TableEntryId as varchar) and t.TenantId = tc4.TenantId ) then 'Active' else 'Inactive' end as "TransactionCode4IsActive"
	,GoodData_Attr((select tc5.Description from stg_csv_tableentry_merge tc5 where t.TransactionCode5 = cast(tc5.TableEntryId as varchar) and t.TenantId = tc5.TenantId )) as "TransactionCode5"
	,case when (select tc5.IsActive from stg_csv_tableentry_merge tc5 where t.TransactionCode5 = cast(tc5.TableEntryId as varchar) and t.TenantId = tc5.TenantId ) then 'Active' else 'Inactive' end as "TransactionCode5IsActive"
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
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'out_Transactions_attr',null,now());
select analyze_statistics('out_Transactions_attr')
;