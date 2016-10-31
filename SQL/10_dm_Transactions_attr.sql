INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_attr',now(),null);
insert /*+ direct */ into dm_Transactions_attr
select
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr(t.PostStatusTranslation) as "PostStatusTranslation"
	,GoodData_date(t.PostDate)  as "PostDate"
	,GoodData_Attr(t.TransactionTypeTranslation) as "TransactionTypeTranslation"
	,GoodData_Attr(t.EncumbranceStatusTranslation) as "EncumbranceStatusTranslation"
	,GoodData_Attr((select tc1.Description from stg_csv_tableentry_merge tc1 where td.TransactionCode1Id = tc1.TableEntryId and t.TenantId = tc1.TenantId and tc1.Deleted = false and tc1._sys_is_deleted = false)) as "TransactionCode1"
	,case when (select tc1.IsActive from stg_csv_tableentry_merge tc1 where td.TransactionCode1Id = tc1.TableEntryId and t.TenantId = tc1.TenantId and tc1.Deleted = false and tc1._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode1IsActive"
	,GoodData_Attr((select tc2.Description from stg_csv_tableentry_merge tc2 where td.TransactionCode2Id = tc2.TableEntryId and t.TenantId = tc2.TenantId and tc2.Deleted = false and tc2._sys_is_deleted = false)) as "TransactionCode2"
	,case when (select tc2.IsActive from stg_csv_tableentry_merge tc2 where td.TransactionCode2Id = tc2.TableEntryId and t.TenantId = tc2.TenantId and tc2.Deleted = false and tc2._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode2IsActive"
	,GoodData_Attr((select tc3.Description from stg_csv_tableentry_merge tc3 where td.TransactionCode3Id = tc3.TableEntryId and t.TenantId = tc3.TenantId and tc3.Deleted = false and tc3._sys_is_deleted = false)) as "TransactionCode3"
	,case when (select tc3.IsActive from stg_csv_tableentry_merge tc3 where td.TransactionCode3Id = tc3.TableEntryId and t.TenantId = tc3.TenantId and tc3.Deleted = false and tc3._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode3IsActive"
	,GoodData_Attr((select tc4.Description from stg_csv_tableentry_merge tc4 where td.TransactionCode4Id = tc4.TableEntryId and t.TenantId = tc4.TenantId and tc4.Deleted = false and tc4._sys_is_deleted = false)) as "TransactionCode4"
	,case when (select tc4.IsActive from stg_csv_tableentry_merge tc4 where td.TransactionCode4Id = tc4.TableEntryId and t.TenantId = tc4.TenantId and tc4.Deleted = false and tc4._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode4IsActive"
	,GoodData_Attr((select tc5.Description from stg_csv_tableentry_merge tc5 where td.TransactionCode5Id = tc5.TableEntryId and t.TenantId = tc5.TenantId and tc5.Deleted = false and tc5._sys_is_deleted = false)) as "TransactionCode5"
	,case when (select tc5.IsActive from stg_csv_tableentry_merge tc5 where td.TransactionCode5Id = tc5.TableEntryId and t.TenantId = tc5.TenantId and tc5.Deleted = false and tc5._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode5IsActive"
	,GoodData_date(t.DateAdded)  as "DateAdded"
	,GoodData_date(t.DateChanged)  as "DateChanged"
	,GoodData_Attr(td.TranDistributionId) as "TransactionAttrDistributionId"
	,GoodData_Attr(t.TransactionId) as "TransactionId"
	,GoodData_Attr(t.AddedById) as "AddedByUserNameId"
	,GoodData_Attr(au.Name) as "AddedByUserName"
	,GoodData_Attr(eu.Name) as "LastChangedByUserName"
	,GoodData_Attr((select class.Description from stg_csv_tableentry_merge class where td.ClassId = class.TableEntryId and t.TenantId = class.TenantId and class.Deleted = false and class._sys_is_deleted = false)) as "Class"
	,GoodData_Attr(t.TransactionId) as "TransactionAttributeId"
from stg_csv_transaction_merge t
join stg_csv_transactiondistribution_merge td
	on td.TransactionId = t.TransactionId and t.TenantId = td.TenantId and td._sys_is_deleted = false and td.Deleted = false
join stg_csv_user_merge au
	on t.AddedById = au.UserId and t.TenantId = au.TenantId and au._sys_is_deleted = false and au.Deleted = false
join stg_csv_user_merge eu
	on t.LastChangedById = eu.UserId and t.TenantId = eu.TenantId and eu._sys_is_deleted = false and eu.Deleted = false
where t.Deleted = false
	and t._sys_is_deleted = false

union all

select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 GoodData_Attr(t.PostStatusTranslation) as "PostStatusTranslation"
	,GoodData_date(t.PostDate)  as "PostDate"
	,GoodData_Attr(t.TransactionTypeTranslation) as "TransactionTypeTranslation"
	,GoodData_Attr(t.EncumbranceStatusTranslation) as "EncumbranceStatusTranslation"
,GoodData_Attr((select tc1.Description from stg_csv_tableentry_merge tc1 where t.TransactionCode1 = cast(tc1.TableEntryId as varchar) and t.TenantId = tc1.TenantId and tc1.Deleted = false and tc1._sys_is_deleted = false)) as "TransactionCode1"
	,case when (select tc1.IsActive from stg_csv_tableentry_merge tc1 where t.TransactionCode1 = cast(tc1.TableEntryId as varchar) and t.TenantId = tc1.TenantId and tc1.Deleted = false and tc1._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode1IsActive"
	,GoodData_Attr((select tc2.Description from stg_csv_tableentry_merge tc2 where t.TransactionCode2 = cast(tc2.TableEntryId as varchar) and t.TenantId = tc2.TenantId and tc2.Deleted = false and tc2._sys_is_deleted = false)) as "TransactionCode2"
	,case when (select tc2.IsActive from stg_csv_tableentry_merge tc2 where t.TransactionCode2 = cast(tc2.TableEntryId as varchar) and t.TenantId = tc2.TenantId and tc2.Deleted = false and tc2._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode2IsActive"
	,GoodData_Attr((select tc3.Description from stg_csv_tableentry_merge tc3 where t.TransactionCode3 = cast(tc3.TableEntryId as varchar) and t.TenantId = tc3.TenantId and tc3.Deleted = false and tc3._sys_is_deleted = false)) as "TransactionCode3"
	,case when (select tc3.IsActive from stg_csv_tableentry_merge tc3 where t.TransactionCode3 = cast(tc3.TableEntryId as varchar) and t.TenantId = tc3.TenantId and tc3.Deleted = false and tc3._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode3IsActive"
	,GoodData_Attr((select tc4.Description from stg_csv_tableentry_merge tc4 where t.TransactionCode4 = cast(tc4.TableEntryId as varchar) and t.TenantId = tc4.TenantId and tc4.Deleted = false and tc4._sys_is_deleted = false)) as "TransactionCode4"
	,case when (select tc4.IsActive from stg_csv_tableentry_merge tc4 where t.TransactionCode4 = cast(tc4.TableEntryId as varchar) and t.TenantId = tc4.TenantId and tc4.Deleted = false and tc4._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode4IsActive"
	,GoodData_Attr((select tc5.Description from stg_csv_tableentry_merge tc5 where t.TransactionCode5 = cast(tc5.TableEntryId as varchar) and t.TenantId = tc5.TenantId and tc5.Deleted = false and tc5._sys_is_deleted = false)) as "TransactionCode5"
	,case when (select tc5.IsActive from stg_csv_tableentry_merge tc5 where t.TransactionCode5 = cast(tc5.TableEntryId as varchar) and t.TenantId = tc5.TenantId and tc5.Deleted = false and tc5._sys_is_deleted = false) then 'Active' else 'Inactive' end as "TransactionCode5IsActive"
	,GoodData_date(null)  as "DateAdded"
	,GoodData_date(null)  as "DateChanged"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionAttrDistributionId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionId"
	,GoodData_Attr(null) as "AddedByUserNameId"
	,GoodData_Attr(null) as "AddedByUserName"
	,GoodData_Attr(null) as "LastChangedByUserName"
	,GoodData_Attr(t.Class) as "Class"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionAttributeId"
from stg_csv_summarizedtransaction_merge t
where t._sys_is_deleted = false
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_attr',null,now());
select analyze_statistics('dm_Transactions_attr')
;