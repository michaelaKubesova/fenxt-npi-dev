
select
 "GrantId",
 "UserId",
 "GrantAmount",
 "DateAdded",
 "DateChanged",
 "AddedByUserId",
 "AddedByUserName",
 "AddedByUserNameLabel",
 "ChangedByUserId",
 "ChangedByUserName",
 "ChangedByUserNameLabel",
 "GrantDateId",
 "Dummy"
from dm_Grants
where TenantId = '${TenantId}'
and _sys_transform_id = ${DM_GRANTS_TRANSFORM_ID}
union all
select  
GoodData_Attr(0) as "GrantId" , 
GoodData_Attr('0') as "UserId" , 
null as "GrantAmount" , 
null as "DateAdded" , 
null as "DateChanged",
GoodData_Attr('') as "AddedByUserId",
GoodData_Attr('') as "AddedByUserName",
GoodData_Attr('') as "AddedByUserNameLabel",
GoodData_Attr('') as "ChangedByUserId",
GoodData_Attr('') as "ChangedByUserName",
GoodData_Attr('') as "ChangedByUserNameLabel",
GoodData_Attr(0) as "GrantDateId",
GoodData_Attr(1) as "Dummy"
;