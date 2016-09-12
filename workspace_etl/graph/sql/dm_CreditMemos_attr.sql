
select
 "DateAdded",
 "DateChanged",
 "CreditMemoAttrId",
 "Date",
 "PostDate",
 "AddedByUserId",
 "AddedByUserName",
 "AddedByUserNameLabel",
 "ChangedByUserId",
 "ChangedByUserName",
 "ChangedByUserNameLabel"
from dm_CreditMemos_attr
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_CREDITMEMOS_ATTR_TRANSFORM_ID}