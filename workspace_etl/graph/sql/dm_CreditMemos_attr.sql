
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
