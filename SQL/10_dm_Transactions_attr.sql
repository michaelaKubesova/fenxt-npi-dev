INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_attr',now(),null);
insert /*+ direct */ into dm_Transactions_attr
select
${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
t.TenantId as "TenantId",
GoodData_Attr(PostStatusTranslation) as "PostStatusTranslation",
GoodData_date(PostDate)  as "PostDate",
GoodData_Attr(TransactionTypeTranslation) as "TransactionTypeTranslation",
GoodData_Attr(EncumbranceStatusTranslation) as "EncumbranceStatusTranslation",
GoodData_Attr(TransactionCode1) as "TransactionCode1",
GoodData_Attr(TransactionCode2) as "TransactionCode2",
GoodData_Attr(TransactionCode3) as "TransactionCode3",
GoodData_Attr(TransactionCode4) as "TransactionCode4",
GoodData_Attr(TransactionCode5) as "TransactionCode5",
GoodData_date(DateAdded)  as "DateAdded",
GoodData_date(DateChanged)  as "DateChanged",
GoodData_Attr(TransactionDistributionId) as "TransactionAttrDistributionId",
GoodData_Attr(TransactionId) as "TransactionId",
GoodData_Attr(AddedByUserId) as "AddedByUserNameId",
GoodData_Attr(au.UserName) as "AddedByUserName",
GoodData_Attr(eu.UserName) as "LastChangedByUserName",
GoodData_Attr(Class) as "Class"
from stg_csv_Transactions_merge t
left join stg_csv_Users_merge au
  on t.AddedByUserId = au.UsersId and t.TenantId = au.TenantId 
left join stg_csv_Users_merge eu
  on t.LastChangedByUserId = eu.UsersId and t.TenantId = eu.TenantId 
;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Transactions_attr',null,now());
select analyze_statistics('dm_Transactions_attr')
;